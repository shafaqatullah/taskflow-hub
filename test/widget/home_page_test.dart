import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow_hub/data/datasources/task_local_datasource.dart';
import 'package:taskflow_hub/data/repositories/task_repository_impl.dart';
import 'package:taskflow_hub/domain/usecases/add_task.dart';
import 'package:taskflow_hub/domain/usecases/delete_task.dart';
import 'package:taskflow_hub/domain/usecases/get_tasks.dart';
import 'package:taskflow_hub/domain/usecases/toggle_task_complete.dart';
import 'package:taskflow_hub/domain/usecases/update_task.dart';
import 'package:taskflow_hub/presentation/pages/home_page.dart';
import 'package:taskflow_hub/presentation/providers/task_provider.dart';
import 'package:taskflow_hub/presentation/providers/theme_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpHomePage(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = TaskRepositoryImpl(
      localDataSource: TaskLocalDataSourceImpl(preferences),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(preferences),
          ),
          ChangeNotifierProvider(
            create: (_) => TaskProvider(
              getTasks: GetTasks(repository),
              addTask: AddTask(repository),
              updateTask: UpdateTask(repository),
              deleteTask: DeleteTask(repository),
              toggleTaskComplete: ToggleTaskComplete(repository),
            ),
          ),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows empty state when no tasks exist', (tester) async {
    await pumpHomePage(tester);

    expect(find.text('No tasks yet'), findsOneWidget);
    expect(find.text('New Task'), findsOneWidget);
  });
}
