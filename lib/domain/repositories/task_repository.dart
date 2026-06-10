import '../entities/task.dart';

/// Contract for task persistence — implemented in the data layer.
abstract interface class TaskRepository {
  Future<List<Task>> getTasks();

  Future<Task> addTask({
    required String title,
    required String description,
    required TaskPriority priority,
  });

  Future<Task> updateTask(Task task);

  Future<void> deleteTask(String id);

  Future<Task> toggleComplete(String id);
}
