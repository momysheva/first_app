import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'admin_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<Map<String, dynamic>> loginUser() async {
    final String username = _userIdController.text;
    final String password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://10.101.54.111:8000/mobile_login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Color.fromARGB(255, 129, 53, 48),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: "User"),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                BuildContext currentContext = context;
                try {
                  Map<String, dynamic>? profileData = await loginUser();
                  if (profileData != null) {
                    Navigator.push(
                      currentContext,
                      MaterialPageRoute(
                          builder: (context) => AdminPage(profileData: profileData)),
                    );
                  } else {
                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      SnackBar(
                        content: Text('Login failed. Please check your credentials.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(currentContext).showSnackBar(
                    SnackBar(
                      content: Text('An error occurred: $e'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 129, 53, 48)),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
