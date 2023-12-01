import 'package:flutter/material.dart';
import '../offline_services/databaseHelper.dart';
import '../offline_services/taskOffline.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _taskController;
  late List<Task> _tasks;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _tasks = [];
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<Task> tasks = await DatabaseHelper().getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _addTask() async {
    String taskName = _taskController.text.trim();
    if (taskName.isNotEmpty) {
      Task newTask = Task(name: taskName, completed: false);
      await DatabaseHelper().insertTask(newTask);
      _taskController.clear();
      _loadTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFlite Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(labelText: 'Nova Tarefa'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                Task task = _tasks[index];
                return ListTile(
                  title: Text(task.name),
                  trailing: task.completed ? Icon(Icons.check_box) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
