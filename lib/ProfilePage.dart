/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/12
 * Description: Lab 7 - Profile page using encrypted shared preferences
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'DataRepository.dart';

/**
 * The ProfilePage class represents the profile screen of the application.
 * It manages the state of the profile form and handles user data loading and saving.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

/**
 * The ProfilePageState class contains the logic for the ProfilePage widget,
 * including form validation, data storage, and interaction with other apps.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  final double sizedBox_Height = 16.0;
  final double padding_Size = 16.0;
  final double iconSpacing = 8.0;

  final String _keyName = "userName";
  final String _firstName = "firstName";
  final String _lastName = "lastName";
  final String _phone = "phone";
  final String _email = "email";

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
      final loginName = DataRepository.loginName;
      showSnackBar("Welcome back $loginName");
    });
  }

  @override
  void dispose() {
    savaData();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /**
   * Launches the specified URL using the default application.
   *
   * @param _url The URL to launch.
   */
  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  /**
   * Loads user data from the DataRepository and updates the form fields.
   */
  void loadData() {
    DataRepository.loadData();
    _firstNameController.text = DataRepository.firstName;
    _lastNameController.text = DataRepository.lastName;
    _phoneController.text = DataRepository.phone;
    _emailController.text = DataRepository.email;
  }

  /**
   * Saves the current form data to the DataRepository.
   */
  void savaData() {
    DataRepository.firstName = _firstNameController.value.text;
    DataRepository.lastName = _lastNameController.value.text;
    DataRepository.phone = _phoneController.value.text;
    DataRepository.email = _emailController.value.text;
    DataRepository.saveData();
  }

  /**
   * Displays a snackbar with the provided message.
   *
   * @param message The message to display.
   */
  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/todoList");
              },
              child: const Text("Go to Todo"))
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(padding_Size),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  hintText: "Input First Name",
                  border: OutlineInputBorder(),
                  labelText: "First Name",
                ),
              ),
              SizedBox(height: sizedBox_Height),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  hintText: "Input Last Name",
                  border: OutlineInputBorder(),
                  labelText: "Last Name",
                ),
              ),
              SizedBox(height: sizedBox_Height),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: "Input Phone Number",
                        border: OutlineInputBorder(),
                        labelText: "Phone Number",
                      ),
                    ),
                  ),
                  SizedBox(width: iconSpacing),
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () {
                      var phone = _phoneController.value.text;
                      Uri phoneLaunchUri = Uri(
                        scheme: 'tel',
                        path: phone,
                      );
                      _launchUrl(phoneLaunchUri);
                    },
                  ),
                  SizedBox(width: iconSpacing),
                  IconButton(
                    icon: Icon(Icons.sms),
                    onPressed: () {
                      var phone = _phoneController.value.text;
                      Uri smsLaunchUri = Uri(
                        scheme: 'sms',
                        path: phone,
                      );
                      _launchUrl(smsLaunchUri);
                    },
                  ),
                ],
              ),
              SizedBox(height: sizedBox_Height),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Input Email Address",
                        border: OutlineInputBorder(),
                        labelText: "Email Address",
                      ),
                    ),
                  ),
                  SizedBox(width: iconSpacing),
                  IconButton(
                    onPressed: () {
                      var email = _emailController.value.text;
                      Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: email,
                      );
                      _launchUrl(emailLaunchUri);
                    },
                    icon: Icon(Icons.email),
                  ),
                ],
              ),
              SizedBox(height: sizedBox_Height),
            ],
          ),
        ),
      ),
    );
  }
}
