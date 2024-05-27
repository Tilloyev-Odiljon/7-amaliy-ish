import 'package:flutter/material.dart';
import 'add_task_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vazifalar ilovasi!!!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  Future<void> _addNewTask(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        tasks.add(Task(
          title: result['title'],
          date: result['date'],
        ));
      });
    }
  }

  Widget _buildItem(Task task) {
    return Container(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.date),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (bool? value) {
            setState(() {
              task.isCompleted = value ?? false;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewTask(context),
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.yellow,
        child: ListView.builder(
          itemCount: tasks.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: const Text(
                  "Mening vazifalarim!!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return _buildItem(tasks[index - 1]);
            }
          },
        ),
      ),
    );
  }
}

class Task {
  String title;
  String date;
  bool isCompleted;

  Task({
    required this.title,
    required this.date,
    this.isCompleted = false,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      date: map['date'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}