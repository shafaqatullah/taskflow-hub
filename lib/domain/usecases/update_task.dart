import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTask {
  const UpdateTask(this._repository);

  final TaskRepository _repository;

  Future<Task> call(Task task) => _repository.updateTask(task);
}
