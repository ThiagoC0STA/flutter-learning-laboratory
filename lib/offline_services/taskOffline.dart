class Task {
  String name;
  bool completed;

  Task({required this.name, required this.completed});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'completed': completed ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      completed: map['completed'] == 1,
    );
  }
}
