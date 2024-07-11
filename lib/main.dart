/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/12
 * Description: Lab 7 - Main application for managing login and profile using encrypted shared preferences
 */


import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:lab_two/TodoListPage.dart';
import 'DatabaseOperator.dart';
import 'ProfilePage.dart';
import 'DataRepository.dart';

/**
 * The main entry point of the application.
 * Initializes the database and runs the Flutter app.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseOperator.initDatabase();
  runApp(const MyApp());
}

/**
 * The MyApp class sets up the main structure of the application,
 * including theme settings and navigation routes.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class MyApp extends StatelessWidget {


  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week 8 Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Week 5 Lab Navigator'),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const MyHomePage(title: 'Login'),
        '/profile': (context) => const ProfilePage(title: "My Profile"),
        '/todoList': (context) => const TodoListPage(title: "Todo List")
      },
    );
  }
}
/**
 * The MyHomePage class represents the login screen of the application.
 * It manages the state of the login form and handles user authentication.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/**
 * The _MyHomePageState class contains the logic for the MyHomePage widget,
 * including form validation, data storage, and navigation.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late TextEditingController _passController;
  String _pngUrl = "images/question_mark.png";
  String _message = "";
  final String _keyName = "userName";
  final String _keyPass = "userPass";
  static final prefs = EncryptedSharedPreferences();
  final FocusNode _focusNode = FocusNode();

  final double sizedBoxHeight = 16.0;
  final String _expectedPass = "1234";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initDataFromEncryptSharedPrefs();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passController.dispose();
    super.dispose();
  }

  /**
   * Displays a dialog prompt asking the user if they want to save their login credentials.
   */
  void showSaveDialogPrompt() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Saving Prompt"),
        content: const Text(
            "Saving your Username and Password for next time using?"),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: saveEncryptedSharedPreference,
                  child: const Text("Yes")),
              ElevatedButton(
                  onPressed: clearDataInDialog, child: const Text("No")),
            ],
          ),
        ],
      ),
    );
  }

  /**
   * Changes the displayed image based on the provided state.
   *
   * @param state A boolean value indicating the new state.
   */
  void changeImages(state) {
    setState(() {
      if (state) {
        _pngUrl = "images/a_light_bulb.png";
      } else {
        _pngUrl = "images/stop_sign.png";
      }
    });
  }
  /**
   * Initializes user data from EncryptedSharedPreferences and updates the form fields.
   */
  void initDataFromEncryptSharedPrefs() async {
    String? name = await prefs.getString(_keyName);
    String? pass = await prefs.getString(_keyPass);

    if (isNotEmpty(name) && isNotEmpty(pass)) {
      setState(() {
        _nameController.text = name!;
        _passController.text = pass!;
      });
      showSnackBarWithClearAction("Load User Data Successfully!");
    }
  }
  /**
   * Saves the current form data to EncryptedSharedPreferences.
   */
  void saveEncryptedSharedPreference() async {
    var name = _nameController.value.text;
    var pass = _passController.value.text;
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyPass, pass);
    hiddenDialog();
    showSnackBar("Save successfully!");
    navigateToProfile();
  }
  /**
   * Clears the saved user data and navigates to the profile page.
   */
  void clearDataInDialog() {
    hiddenDialog();
    clearEncryptedSharedPreference();
    showSnackBar("User data has been removed successfully!");
    navigateToProfile();
  }
  /**
   * Clears the saved user data and shows a snackbar message.
   */
  void clearDataInSnack() {
    clearEncryptedSharedPreference();
    showSnackBar("User data has been removed successfully!");
  }
  /**
   * Clears the saved user data from EncryptedSharedPreferences.
   */
  void clearEncryptedSharedPreference() {
    prefs.getString(_keyName).then((value) {
      if (isNotEmpty(value)) {
        prefs.remove(_keyName);
      }
    });

    prefs.getString(_keyPass).then((value) {
      if (isNotEmpty(value)) {
        prefs.remove(_keyPass);
      }
    });

    setState(() {
      _nameController.text = "";
      _passController.text = "";
    });
  }
  /**
   * Checks if the provided string is not empty.
   *
   * @param value The string to check.
   * @return True if the string is not null and not empty, false otherwise.
   */
  bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }
  /**
   * Hides the currently displayed dialog.
   */
  void hiddenDialog() {
    Navigator.pop(context);
  }
  /**
   * Navigates to the profile page and passes the login name.
   */
  void navigateToProfile() {
    var loginName = _nameController.value.text;
    DataRepository.loginName = loginName;
    Navigator.of(context).pushNamed("/profile");
  }
  /**
   * Navigates to the todo list page and passes the login name.
   */
  void navigateTodoList() {
    var loginName = _nameController.value.text;
    DataRepository.loginName = loginName;
    Navigator.of(context).pushNamed("/todoList");
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
  /**
   * Displays a snackbar with the provided message and a clear action button.
   *
   * @param message The message to display.
   */
  void showSnackBarWithClearAction(String message) {
    var snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: "Clear",
        onPressed: clearDataInSnack,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Input Login Name",
                  border: OutlineInputBorder(),
                  labelText: "Login Name",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Input Password",
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  var name = _nameController.value.text;
                  var pass = _passController.value.text;
                  if (isNotEmpty(name) &&
                      isNotEmpty(pass) &&
                      pass == _expectedPass) {
                    changeImages(true);
                    showSaveDialogPrompt();
                  } else {
                    changeImages(false);
                    setState(() {
                      _message =
                          'Login name or password should not be empty or password is not correct.';
                    });
                    _focusNode.requestFocus();
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              Text(_message),
              Image.asset(
                _pngUrl,
                width: 50,
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
