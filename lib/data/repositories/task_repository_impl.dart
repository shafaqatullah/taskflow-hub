import 'package:uuid/uuid.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/validators.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({required TaskLocalDataSource localDataSource, Uuid? uuid})
    : _localDataSource = localDataSource,
      _uuid = uuid ?? const Uuid();

  final TaskLocalDataSource _localDataSource;
  final Uuid _uuid;

  @override
  Future<List<Task>> getTasks() async {
    final models = await _localDataSource.loadTasks();
    final tasks = models.map((model) => model.toEntity()).toList();
    tasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return tasks;
  }

  @override
  Future<Task> addTask({
    required String title,
    required String description,
    required TaskPriority priority,
  }) async {
    Validators.ensureValidTaskInput(title: title, description: description);

    final now = DateTime.now();
    final task = Task(
      id: _uuid.v4(),
      title: title.trim(),
      description: description.trim(),
      isCompleted: false,
      priority: priority,
      createdAt: now,
      updatedAt: now,
    );

    final models = await _localDataSource.loadTasks();
    models.add(TaskModel.fromEntity(task));
    await _localDataSource.saveTasks(models);
    return task;
  }

  @override
  Future<Task> updateTask(Task task) async {
    Validators.ensureValidTaskInput(
      title: task.title,
      description: task.description,
    );

    final models = await _localDataSource.loadTasks();
    final index = models.indexWhere((model) => model.id == task.id);
    if (index == -1) {
      throw const CacheFailure('Task not found.');
    }

    final updated = task.copyWith(updatedAt: DateTime.now());
    models[index] = TaskModel.fromEntity(updated);
    await _localDataSource.saveTasks(models);
    return updated;
  }

  @override
  Future<void> deleteTask(String id) async {
    final models = await _localDataSource.loadTasks();
    models.removeWhere((model) => model.id == id);
    await _localDataSource.saveTasks(models);
  }

  @override
  Future<Task> toggleComplete(String id) async {
    final models = await _localDataSource.loadTasks();
    final index = models.indexWhere((model) => model.id == id);
    if (index == -1) {
      throw const CacheFailure('Task not found.');
    }

    final current = models[index].toEntity();
    final updated = current.copyWith(
      isCompleted: !current.isCompleted,
      updatedAt: DateTime.now(),
    );
    models[index] = TaskModel.fromEntity(updated);
    await _localDataSource.saveTasks(models);
    return updated;
  }
}
