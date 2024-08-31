import 'package:flutter/material.dart';

class GoalsProvider with ChangeNotifier {
  List<Task> toDoList = [];
  int completedGoalsCount = 0;

  void addTask(String taskName) {
    toDoList.add(Task(taskName: taskName));
    notifyListeners();
  }

  void removeTask(int index) {
    if (toDoList[index].isCompleted) {
      completedGoalsCount--;
    }
    toDoList.removeAt(index);
    notifyListeners();
  }

  void toggleTaskCompletion(int index, bool isCompleted) {
    toDoList[index].isCompleted = isCompleted;
    if (isCompleted) {
      completedGoalsCount++;
    } else {
      completedGoalsCount--;
    }
    notifyListeners();
  }

  void updateBadgeStatus() {
    notifyListeners();
  }
}

class Task {
  final String taskName;
  bool isCompleted;

  Task({required this.taskName, this.isCompleted = false});
}