import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:lab_two/TodoListPage.dart';
import 'ProfilePage.dart';
import 'DataRepository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week 5 Lab',
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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

  void changeImages(state) {
    setState(() {
      if (state) {
        _pngUrl = "images/a_light_bulb.png";
      } else {
        _pngUrl = "images/stop_sign.png";
      }
    });
  }

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

  void saveEncryptedSharedPreference() async {
    var name = _nameController.value.text;
    var pass = _passController.value.text;
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyPass, pass);
    hiddenDialog();
    showSnackBar("Save successfully!");
    navigateToProfile();
  }

  void clearDataInDialog() {
    hiddenDialog();
    clearEncryptedSharedPreference();
    showSnackBar("User data has been removed successfully!");
    navigateToProfile();
  }

  void clearDataInSnack() {
    clearEncryptedSharedPreference();
    showSnackBar("User data has been removed successfully!");
  }

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

  bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  void hiddenDialog() {
    Navigator.pop(context);
  }

  void navigateToProfile() {
    var loginName = _nameController.value.text;
    DataRepository.loginName = loginName;
    Navigator.of(context).pushNamed("/profile");
  }

  void navigateTodoList() {
    var loginName = _nameController.value.text;
    DataRepository.loginName = loginName;
    Navigator.of(context).pushNamed("/todoList");
  }

  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
