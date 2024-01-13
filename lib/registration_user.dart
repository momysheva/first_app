import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}
class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _governmentIdController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _drivingLicenseCode = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
        backgroundColor: Color.fromARGB(255, 129, 53, 48),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text('Goverment ID'),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: _governmentIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Goverment ID',
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text('Name'),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text('Surname'),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: _surNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Surname',
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text('Middle Name'),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: _middleNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Middle Name',
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text('Address'),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Address',
                ),
              ),
                  const SizedBox(
                height: 3,
              ),
              const Text('Phone Number'),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                ),
              ),
                   const SizedBox(
                height: 3,
              ),
              const Text('Email'),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email',
                ),
              ),
               const SizedBox(
                height: 3,
              ),
              const Text('Driving License Code'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _drivingLicenseCode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Driving License Code',
                ),
              ),
              //create button for register
              ElevatedButton(
                onPressed: () {
                  //we will trying to print input
                  print(_nameController.text);
                  print(_governmentIdController.text);
                  print(_emailController.text);
                  print(_drivingLicenseCode.text);
                },
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color.fromARGB(255, 129, 53, 48))),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}