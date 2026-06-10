import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow_hub/data/models/task_model.dart';
import 'package:taskflow_hub/domain/entities/task.dart';

void main() {
  group('TaskModel', () {
    final now = DateTime(2026, 6, 10, 12, 0);
    final task = Task(
      id: 'task-1',
      title: 'Write tests',
      description: 'Cover model serialization',
      isCompleted: false,
      priority: TaskPriority.high,
      createdAt: now,
      updatedAt: now,
    );

    test('round-trips through JSON', () {
      final model = TaskModel.fromEntity(task);
      final json = model.toJson();
      final restored = TaskModel.fromJson(json).toEntity();

      expect(restored, task);
    });

    test('defaults missing optional JSON fields', () {
      final model = TaskModel.fromJson({
        'id': 'task-2',
        'title': 'Defaults',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      });

      expect(model.description, '');
      expect(model.isCompleted, false);
      expect(model.priority, TaskPriority.medium.name);
    });
  });
}
