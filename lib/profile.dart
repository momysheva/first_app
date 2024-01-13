import 'package:flutter/material.dart';
//import 'dart:convert';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> profileData;


  ProfilePage({required this.profileData});


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = profileData['user'];
    String firstName = userData['first_name'];
    String lastName = userData['last_name'];
    String middleName = userData['middle_name'];
    String email = userData['email'];
    String role = userData['role'];
    int license = userData['driver_license_id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Color.fromARGB(255, 129, 53, 48),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const CircleAvatar(
                radius: 50,
                // You can use a profile picture here
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                '$firstName $middleName $lastName',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Email: $email', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Role: $role', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Driver License ID: ${license.toString()}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}