import '../entities/task.dart';
import '../repositories/task_repository.dart';

class ToggleTaskComplete {
  const ToggleTaskComplete(this._repository);

  final TaskRepository _repository;

  Future<Task> call(String id) => _repository.toggleComplete(id);
}
