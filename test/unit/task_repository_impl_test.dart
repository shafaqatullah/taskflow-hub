import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow_hub/data/datasources/task_local_datasource.dart';
import 'package:taskflow_hub/data/repositories/task_repository_impl.dart';
import 'package:taskflow_hub/domain/entities/task.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TaskRepositoryImpl', () {
    late TaskRepositoryImpl repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      repository = TaskRepositoryImpl(
        localDataSource: TaskLocalDataSourceImpl(preferences),
      );
    });

    test('adds and retrieves tasks', () async {
      final created = await repository.addTask(
        title: 'Review PR',
        description: 'Check CI status',
        priority: TaskPriority.medium,
      );

      final tasks = await repository.getTasks();
      expect(tasks, hasLength(1));
      expect(tasks.first.id, created.id);
      expect(tasks.first.title, 'Review PR');
    });

    test('toggles completion state', () async {
      final created = await repository.addTask(
        title: 'Merge branch',
        description: '',
        priority: TaskPriority.low,
      );

      final toggled = await repository.toggleComplete(created.id);
      expect(toggled.isCompleted, isTrue);

      final tasks = await repository.getTasks();
      expect(tasks.first.isCompleted, isTrue);
    });

    test('deletes a task', () async {
      final created = await repository.addTask(
        title: 'Delete me',
        description: '',
        priority: TaskPriority.high,
      );

      await repository.deleteTask(created.id);
      final tasks = await repository.getTasks();
      expect(tasks, isEmpty);
    });
  });
}
