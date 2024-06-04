import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late TextEditingController _passController;
  String pngUrl = "images/question_mark.png";
  String _message = "";
  final String _keyName = "userName";
  final String _keyPass = "userPass";
  static var prefs = EncryptedSharedPreferences();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passController = TextEditingController();
    // initDataFromSharedPrefs();
    initDataFromEncryptSharedPrefs();
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
          ElevatedButton(
              onPressed: saveEncryptedSharedPreference,
              child: const Text("Yes")),
          ElevatedButton(
              onPressed: clearDataInDialog,
              child: const Text("No")),
        ],
      ),
    );
  }

  void changeImages() {
    setState(() {
      if (_passController.value.text == "QWERT123") {
        pngUrl = "images/a_light_bulb.png";
      } else {
        pngUrl = "images/stop_sign.png";
      }
    });
  }



  void initDataFromEncryptSharedPrefs() async {

    String? name = await prefs.getString(_keyName);
    String? pass = await prefs.getString(_keyPass);

    if (isNotEmpty(name) && isNotEmpty(pass)) {
      setState(() {
        _nameController.text = name;
        _passController.text = pass;
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
  }

  void clearDataInDialog(){
    hiddenDialog();
    clearEncryptedSharedPreference();
    showSnackBar("User data has been removed successfully!");
  }

  void clearDataInSnack(){
    clearEncryptedSharedPreference();
    showSnackBar("User data has been removed successfully!");
  }


  void clearEncryptedSharedPreference() async {

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

  // validate a string is not null or empty
  bool isNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }



  void hiddenDialog() async{
     Navigator.pop(context);
  }

  void showSnackBar(message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackBarWithClearAction(message) async {
    var snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: "Clear",
          onPressed: clearDataInSnack,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
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
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "Input Password",
                  border: OutlineInputBorder(),
                  labelText: "Password"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  var name = _nameController.value.text;
                  var pass = _passController.value.text;
                  if (isNotEmpty(name) && isNotEmpty(pass)) {
                    changeImages();
                    showSaveDialogPrompt();
                  } else {
                    setState(() {
                      _message = 'Login name or password should not be empty';
                    });
                    _focusNode.requestFocus();
                  }
                },
                child: const Text("Login")),
            const SizedBox(
              height: 20,
            ),
            Text(_message),
            // Image.asset(
            //   pngUrl,
            //   width: 200,
            //   height: 200,
            // )
          ],
        ),
      ),
    );
  }
}
