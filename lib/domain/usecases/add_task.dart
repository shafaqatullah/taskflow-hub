import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTask {
  const AddTask(this._repository);

  final TaskRepository _repository;

  Future<Task> call({
    required String title,
    required String description,
    required TaskPriority priority,
  }) {
    return _repository.addTask(
      title: title,
      description: description,
      priority: priority,
    );
  }
}
