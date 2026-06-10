import 'package:flutter/foundation.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/toggle_task_complete.dart';
import '../../domain/usecases/update_task.dart';

enum TaskFilter { all, active, completed }

class TaskProvider extends ChangeNotifier {
  TaskProvider({
    required GetTasks getTasks,
    required AddTask addTask,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
    required ToggleTaskComplete toggleTaskComplete,
  }) : _getTasks = getTasks,
       _addTask = addTask,
       _updateTask = updateTask,
       _deleteTask = deleteTask,
       _toggleTaskComplete = toggleTaskComplete;

  final GetTasks _getTasks;
  final AddTask _addTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;
  final ToggleTaskComplete _toggleTaskComplete;

  List<Task> _tasks = [];
  TaskFilter _filter = TaskFilter.all;
  bool _isLoading = false;
  String? _errorMessage;

  List<Task> get tasks => _tasks;
  TaskFilter get filter => _filter;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Task> get visibleTasks {
    return switch (_filter) {
      TaskFilter.all => _tasks,
      TaskFilter.active => _tasks.where((task) => !task.isCompleted).toList(),
      TaskFilter.completed => _tasks.where((task) => task.isCompleted).toList(),
    };
  }

  int get activeCount => _tasks.where((task) => !task.isCompleted).length;
  int get completedCount => _tasks.where((task) => task.isCompleted).length;

  Future<void> loadTasks() async {
    _setLoading(true);
    try {
      _tasks = await _getTasks();
      _errorMessage = null;
    } on Failure catch (failure) {
      _errorMessage = failure.message;
    } catch (_) {
      _errorMessage = 'Something went wrong while loading tasks.';
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createTask({
    required String title,
    required String description,
    required TaskPriority priority,
  }) async {
    try {
      final task = await _addTask(
        title: title,
        description: description,
        priority: priority,
      );
      _tasks = [task, ..._tasks];
      _errorMessage = null;
      notifyListeners();
      return true;
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      notifyListeners();
      return false;
    } catch (_) {
      _errorMessage = 'Unable to create task.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> editTask(Task task) async {
    try {
      final updated = await _updateTask(task);
      final index = _tasks.indexWhere((item) => item.id == updated.id);
      if (index != -1) {
        _tasks[index] = updated;
        _tasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      }
      _errorMessage = null;
      notifyListeners();
      return true;
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      notifyListeners();
      return false;
    } catch (_) {
      _errorMessage = 'Unable to update task.';
      notifyListeners();
      return false;
    }
  }

  Future<void> removeTask(String id) async {
    try {
      await _deleteTask(id);
      _tasks.removeWhere((task) => task.id == id);
      _errorMessage = null;
      notifyListeners();
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      notifyListeners();
    } catch (_) {
      _errorMessage = 'Unable to delete task.';
      notifyListeners();
    }
  }

  Future<void> toggleComplete(String id) async {
    try {
      final updated = await _toggleTaskComplete(id);
      final index = _tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        _tasks[index] = updated;
      }
      _errorMessage = null;
      notifyListeners();
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      notifyListeners();
    } catch (_) {
      _errorMessage = 'Unable to update task status.';
      notifyListeners();
    }
  }

  void setFilter(TaskFilter filter) {
    if (_filter == filter) {
      return;
    }
    _filter = filter;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
