import 'package:app/providers/goals_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/utils/dialog_box.dart';
import 'package:app/utils/todo_tile.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final TextEditingController _controller = TextEditingController();

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            Provider.of<GoalsProvider>(context, listen: false)
                .addTask(_controller.text);
            _controller.clear();
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void removeTask(int index) {
    final goalsProvider = Provider.of<GoalsProvider>(context, listen: false);

    // Store the removed task for undo operation (if needed)
    final removedTask = goalsProvider.toDoList[index];

    // Remove the task from the provider and update the UI
    setState(() {
      goalsProvider.removeTask(index);
    });

    // Show a snackbar with an undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task removed"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            // Re-add the task if undo is pressed
            setState(() {
              goalsProvider.addTask(removedTask.taskName);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF81C9F3),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          "Health Goals",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: Color(0xFF81C9F3),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<GoalsProvider>(
          builder: (context, goalsProvider, child) {
            return Column(
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: goalsProvider.toDoList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(goalsProvider.toDoList[index].taskName),
                        onDismissed: (direction) {
                          removeTask(index);
                        },
                        background: Container(color: Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ToDoTile(
                            taskName: goalsProvider.toDoList[index].taskName,
                            taskCompleted:
                                goalsProvider.toDoList[index].isCompleted,
                            onChanged: (value) {
                              setState(() {
                                goalsProvider.toggleTaskCompletion(index, value!);
                                goalsProvider.updateBadgeStatus();
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}