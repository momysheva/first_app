import 'package:flutter/material.dart';
import 'dart:convert';
import 'viewtasks.dart';
import 'package:http/http.dart' as http;
import 'map.dart';


class Task {
   int taskId;
   String assignedDriver;
   String title;
   String description;
   String creationDate;
   String dueDate;
   bool isComplete;
   bool isActive;

  Task({
    required this.taskId,
    required this.assignedDriver,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.dueDate,
    required this.isComplete,
    required this.isActive,
  });
}


class TasksPage extends StatefulWidget {
  final Map<String, dynamic> profileData;

  TasksPage({required this.profileData});

  @override
  _TasksPageState createState() => _TasksPageState();
  }

  class _TasksPageState extends State<TasksPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    tasks = parseTasks(jsonEncode(widget.profileData));
  }

  Future<Map<String, dynamic>> mobileRoads(int task_id) async {
    final response = await http.get(
        Uri.parse('http://10.101.54.111:8000/mobile_routes/$task_id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed');
    }
  }

  Future<void> updateTaskStatus(int task_id, String username) async {
    final response = await http.put(
      Uri.parse(
          'http://10.101.54.111:8000/mobile_status/$task_id/$username/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({}),
    );

    // Handle the response if needed
  }

  List<Task> parseTasks(String jsonData) {
    final List<dynamic> tasksData = jsonDecode(jsonData)['tasks'];
    return tasksData.map((taskData) {
      return Task(
        taskId: taskData['task_id'],
        assignedDriver: taskData['assigned_driver'],
        title: taskData['title'],
        description: taskData['description'],
        creationDate: taskData['creation_date'],
        dueDate: taskData['due_date'],
        isComplete: taskData['is_complete'],
        isActive: taskData['is_active'],
      );
    }).toList();
  }

  String getStatusText(Task task) {
    if (task.isActive && !task.isComplete) {
      return 'Mark Complete';
    } else if (!task.isActive && !task.isComplete) {
      return 'Mark Active';
    } else {
      return 'Complete';
    }
  }

  Color getStatusColor(Task task) {
    if (task.isComplete) {
      return Colors.green;
    } else if (task.isActive) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('All Tasks'),
      backgroundColor: Color.fromARGB(255, 129, 53, 48),
    ),
    body: Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  for (Task task in tasks)
                    ListTile(
                      title: Text(task.title),
                      subtitle: Text('Due Date: ${task.dueDate}'),
                      tileColor: getStatusColor(task),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await updateTaskStatus(
                                  task.taskId, task.assignedDriver);

                              if (task.isActive && !task.isComplete) {
                                task.isComplete = true;
                                task.isActive = false;
                              } else if (!task.isActive && !task.isComplete) {
                                task.isActive = true;
                              } else if (task.isComplete) {
                                task.isComplete = true;
                              }

                              setState(() {});
                            },
                            child: Text(getStatusText(task)),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              BuildContext currentContext = context;

                              Map<String, dynamic>? routes =
                                  await mobileRoads(task.taskId);
                              Navigator.push(
                                currentContext,
                                MaterialPageRoute(
                                  builder: (context) => ViewTasksPage(
                                    taskData: task,
                                    routes: routes,
                                  ),
                                ),
                              );
                            },
                            child: Text('View'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              Task? firstActiveTask = tasks.firstWhere((task) => task.isActive);
              BuildContext currentContext = context;
              Map<String, dynamic>? activeRoutes = await mobileRoads(firstActiveTask.taskId);
                   Navigator.push(
                      currentContext,
                      MaterialPageRoute(builder: (context) => MapScreen(fromAddress: activeRoutes['routes']['origin_location'], toAddress:activeRoutes['routes']['destination_location'])),
            );

              print('View Active Routes');
            },
            child: Text('View Active Routes'),
          ),
        ],
      ),
    ),
  );
}

  } 