import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'task1.dart';

class ViewTasksPage extends StatelessWidget {
  final Task taskData;
  final Map<String, dynamic> routes;

  ViewTasksPage({required this.taskData, required this.routes});

  @override
  Widget build(BuildContext context) {
    final String description = taskData.description;
    final String creationDate = taskData.creationDate;
    final String dueDate = taskData.dueDate;
    final String status = taskData.isComplete.toString();
    Map<String, dynamic> driverRoutes = routes['routes'];
    String duration = driverRoutes['time'];
    String distance = driverRoutes['distance'];
    String originLocation = driverRoutes['origin_location'];
    String destinationLocation = driverRoutes['destination_location'];

    return Scaffold(
  appBar: AppBar(
    title: Text('Task Info'),
    backgroundColor: Color.fromARGB(255, 129, 53, 48),
  ),
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const SizedBox(height: 10),
          ItemTasks(description, 'description', CupertinoIcons.info),
          const SizedBox(height: 10),
          ItemTasks(creationDate, 'creationDate', CupertinoIcons.info),
          const SizedBox(height: 10),
          ItemTasks(dueDate, 'dueDate', CupertinoIcons.info),
          const SizedBox(height: 10),
          ItemTasks(status, 'status', CupertinoIcons.info),
          const SizedBox(height: 10),
          ItemTasks(duration, 'duration', CupertinoIcons.info),
          const SizedBox(height: 10),
          ItemTasks(distance, 'distance', CupertinoIcons.info),
          const SizedBox(height: 10),
          ItemTasks(originLocation, 'originLocation', CupertinoIcons.info),
          const SizedBox(height: 10),
          ItemTasks(destinationLocation, 'destinationLocation', CupertinoIcons.info),
        ],
      ),
    ),
  ),
);
  }


  ItemTasks(String title, String subtitle, IconData iconData){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,5),
            color: Color.fromARGB(255, 129, 53, 48),
            spreadRadius: 2,
            blurRadius: 10
          )
        ]

      ),
      child:ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading:Icon(iconData),
        tileColor: Colors.white,
      )
    );
  }
}
