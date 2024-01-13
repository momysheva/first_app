import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'task1.dart';


class AdminPage extends StatefulWidget {
  final Map<String, dynamic> profileData;
  AdminPage({required this.profileData});
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
Future<Map<String, dynamic>> mobileTasks (String username) async {
// Assuming you have a function to handle the login request
   final response = await http.get(Uri.parse('http://10.101.54.111:8000/mobile_tasks/$username'));

    if (response.statusCode == 200) {
      // Successful login, handle the response data
      return jsonDecode(response.body);
    } else {
      // Failed login, throw an error
      throw Exception('Failed');
    }
  
  }


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = widget.profileData['user'];
    String username = userData['username'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        backgroundColor: Color.fromARGB(255, 129, 53, 48),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                
                onPressed: () async {
                  BuildContext currentContext = context;
                   Navigator.push(
                      currentContext,
                      MaterialPageRoute(builder: (context) => ProfilePage(profileData: widget.profileData)),
            );
                },
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color.fromARGB(255, 129, 53, 48))), 
                child: const Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
                ),
                ElevatedButton(
                
                onPressed: ()async{
           BuildContext currentContext = context;
      Map<String, dynamic>? profileData = await mobileTasks(username);
      if (profileData != null) {
        Navigator.push(
          currentContext,
          MaterialPageRoute(builder: (context) => TasksPage(profileData: profileData)),
        );
      } else {
        // Show an error message to the user, e.g., using a SnackBar
        ScaffoldMessenger.of(currentContext).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            duration: Duration(seconds: 3),
          ),
        );
      }},
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color.fromARGB(255, 129, 53, 48))), 
                child: const Text(
                  "View Tasks",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
                ),
               

            ],
          ),
        ),
      ),


    );
  }
}
