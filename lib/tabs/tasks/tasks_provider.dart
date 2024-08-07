import 'package:flutter/cupertino.dart';

import '../../firebase_utils.dart';
import '../../models/task_model.dart';

class TasksProvider with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  List<TaskModel> tasks = [];
  // Future<void> getAllTasks() async {
  //   tasks = await FirebaseUtils.getAllTasksFromFirestore();
  //   notifyListeners();
  // }

  Future<void> getTasks(String userId) async {
    final allTasks = await FirebaseUtils.getAllTasksFromFirestore(userId);
    tasks = allTasks
        // tasks = tasks
        .where((task) =>
            task.dateTime.day == selectedDate.day &&
            task.dateTime.month == selectedDate.month &&
            task.dateTime.year == selectedDate.year)
        .toList();
    tasks.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    notifyListeners();
  }

  void changeSelctedDate(String userId, DateTime dateTime) {
    selectedDate = dateTime;
    getTasks(userId);
  }
}
