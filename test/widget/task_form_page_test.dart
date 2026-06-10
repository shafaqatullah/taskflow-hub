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
import 'package:taskflow_hub/presentation/pages/task_form_page.dart';
import 'package:taskflow_hub/presentation/providers/task_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpForm(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = TaskRepositoryImpl(
      localDataSource: TaskLocalDataSourceImpl(preferences),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(
          getTasks: GetTasks(repository),
          addTask: AddTask(repository),
          updateTask: UpdateTask(repository),
          deleteTask: DeleteTask(repository),
          toggleTaskComplete: ToggleTaskComplete(repository),
        ),
        child: const MaterialApp(home: TaskFormPage()),
      ),
    );
  }

  testWidgets('shows inline validation for empty title', (tester) async {
    await pumpForm(tester);

    await tester.tap(find.text('Create Task'));
    await tester.pumpAndSettle();

    expect(find.text('Title is required.'), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
  });
}
