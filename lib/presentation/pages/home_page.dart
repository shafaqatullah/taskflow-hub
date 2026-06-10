import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/task.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/task_list_tile.dart';
import 'task_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadTasks();
    });
  }

  Future<void> _confirmDelete(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete task?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await context.read<TaskProvider>().removeTask(id);
    }
  }

  void _openForm({Task? task}) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => TaskFormPage(task: task)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        final tasks = provider.visibleTasks;

        return Scaffold(
          appBar: AppBar(
            title: const Text('TaskFlow Hub'),
            actions: [
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) {
                  final icon = switch (themeProvider.themeMode) {
                    ThemeMode.light => Icons.light_mode,
                    ThemeMode.dark => Icons.dark_mode,
                    ThemeMode.system => Icons.brightness_auto,
                  };
                  return IconButton(
                    tooltip: 'Cycle theme (${themeProvider.themeMode.name})',
                    onPressed: themeProvider.cycleThemeMode,
                    icon: Icon(icon),
                  );
                },
              ),
              IconButton(
                tooltip: 'Refresh',
                onPressed: provider.loadTasks,
                icon: const Icon(Icons.refresh),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All (${provider.tasks.length})',
                      selected: provider.filter == TaskFilter.all,
                      onSelected: () => provider.setFilter(TaskFilter.all),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Active (${provider.activeCount})',
                      selected: provider.filter == TaskFilter.active,
                      onSelected: () => provider.setFilter(TaskFilter.active),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Done (${provider.completedCount})',
                      selected: provider.filter == TaskFilter.completed,
                      onSelected: () =>
                          provider.setFilter(TaskFilter.completed),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : tasks.isEmpty
              ? EmptyState(
                  title: provider.filter == TaskFilter.all
                      ? 'No tasks yet'
                      : 'No tasks in this view',
                  subtitle: provider.filter == TaskFilter.all
                      ? 'Tap + to create your first task.'
                      : 'Try another filter or add a new task.',
                )
              : RefreshIndicator(
                  onRefresh: provider.loadTasks,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskListTile(
                        task: task,
                        onToggle: () => provider.toggleComplete(task.id),
                        onEdit: () => _openForm(task: task),
                        onDelete: () => _confirmDelete(task.id),
                      );
                    },
                  ),
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add),
            label: const Text('New Task'),
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
    );
  }
}
