import '../../domain/entities/task.dart';

class TaskModel {
  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String priority;
  final String createdAt;
  final String updatedAt;

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      priority: task.priority.name,
      createdAt: task.createdAt.toIso8601String(),
      updatedAt: task.updatedAt.toIso8601String(),
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
      priority: json['priority'] as String? ?? TaskPriority.medium.name,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'priority': priority,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      priority: TaskPriority.values.byName(priority),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}
