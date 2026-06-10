import 'package:equatable/equatable.dart';

enum TaskPriority { low, medium, high }

/// Core business entity — independent of frameworks and storage.
class Task extends Equatable {
  const Task({
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
  final TaskPriority priority;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    TaskPriority? priority,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isCompleted,
    priority,
    createdAt,
    updatedAt,
  ];
}
