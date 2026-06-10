import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../core/errors/failures.dart';
import '../models/task_model.dart';

abstract interface class TaskLocalDataSource {
  Future<List<TaskModel>> loadTasks();

  Future<void> saveTasks(List<TaskModel> tasks);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  TaskLocalDataSourceImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<List<TaskModel>> loadTasks() async {
    try {
      final raw = _preferences.getString(AppConstants.tasksStorageKey);
      if (raw == null || raw.isEmpty) {
        return [];
      }

      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((item) => TaskModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw const CacheFailure('Unable to read saved tasks.');
    }
  }

  @override
  Future<void> saveTasks(List<TaskModel> tasks) async {
    try {
      final encoded = jsonEncode(tasks.map((task) => task.toJson()).toList());
      final saved = await _preferences.setString(
        AppConstants.tasksStorageKey,
        encoded,
      );
      if (!saved) {
        throw const CacheFailure('Unable to persist tasks.');
      }
    } catch (error) {
      if (error is CacheFailure) {
        rethrow;
      }
      throw const CacheFailure('Unable to persist tasks.');
    }
  }
}
