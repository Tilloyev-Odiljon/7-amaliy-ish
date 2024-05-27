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