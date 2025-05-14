import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_todo/models/task.dart';

// All CRUD method for Hive DB
class HiveDataStore {
  // Box Name - String
  static const boxName = 'taskBox';

  // Current box will save all data in Box<Task>
  final Box<Task> box = Hive.box<Task>(boxName);

  // Add new task to box
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  // Show task
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  // Update task
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  // Delete task
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  // Listen to Box Changes - will update UI accordingly
  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}
