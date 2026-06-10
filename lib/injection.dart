import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/task_local_datasource.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/repositories/task_repository.dart';
import 'domain/usecases/add_task.dart';
import 'domain/usecases/delete_task.dart';
import 'domain/usecases/get_tasks.dart';
import 'domain/usecases/toggle_task_complete.dart';
import 'domain/usecases/update_task.dart';
import 'presentation/providers/task_provider.dart';

Future<List<SingleChildWidget>> buildProviders() async {
  final preferences = await SharedPreferences.getInstance();
  final localDataSource = TaskLocalDataSourceImpl(preferences);
  final TaskRepository repository = TaskRepositoryImpl(
    localDataSource: localDataSource,
  );

  final getTasks = GetTasks(repository);
  final addTask = AddTask(repository);
  final updateTask = UpdateTask(repository);
  final deleteTask = DeleteTask(repository);
  final toggleTaskComplete = ToggleTaskComplete(repository);

  return [
    ChangeNotifierProvider(
      create: (_) => TaskProvider(
        getTasks: getTasks,
        addTask: addTask,
        updateTask: updateTask,
        deleteTask: deleteTask,
        toggleTaskComplete: toggleTaskComplete,
      ),
    ),
  ];
}
