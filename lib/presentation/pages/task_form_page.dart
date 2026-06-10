import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/validators.dart';
import '../../domain/entities/task.dart';
import '../providers/task_provider.dart';

class TaskFormPage extends StatefulWidget {
  const TaskFormPage({super.key, this.task});

  final Task? task;

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late TaskPriority _priority;

  bool get isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
    _priority = widget.task?.priority ?? TaskPriority.medium;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<TaskProvider>();
    final success = isEditing
        ? await provider.editTask(
            widget.task!.copyWith(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              priority: _priority,
            ),
          )
        : await provider.createTask(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            priority: _priority,
          );

    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.of(context).pop();
    } else if (provider.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(provider.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Task' : 'New Task')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'What needs to be done?',
              ),
              textInputAction: TextInputAction.next,
              validator: Validators.validateTitle,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Add more details',
              ),
              maxLines: 4,
              validator: Validators.validateDescription,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskPriority>(
              initialValue: _priority,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: TaskPriority.values
                  .map(
                    (priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(priority.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _priority = value);
                }
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submit,
              child: Text(isEditing ? 'Save Changes' : 'Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
