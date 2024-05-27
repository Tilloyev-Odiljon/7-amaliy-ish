import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vazifa qo`shish'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Vazifa nomi'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Sana'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final date = _dateController.text;

                if (title.isNotEmpty && date.isNotEmpty) {
                  Navigator.of(context).pop({
                    'title': title,
                    'date': date,
                  });
                }
              },
              child: Text('Vazifa qo`shish'),
            ),
          ],
        ),
      ),
    );
  }
}