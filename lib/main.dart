import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mobile Lab2 Home Page'),
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Text("Hi, there"),),
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            OutlinedButton(onPressed: () {}, child: Text("Button1")),
            OutlinedButton(onPressed: () {}, child: Text("Button2"))
          ]),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Button 1")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Button 2")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Button 3")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Button 4")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_passController.value.text == "QWERTY123") {
                      pngUrl = "images/a_light_bulb.png";
                    } else {
                      pngUrl = "images/stop_sign.png";
                    }
                  });
                },
                child: const Text("Login")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.camera),label:'Camera'),
        BottomNavigationBarItem(icon: Icon(Icons.add_call), label:'Phone'),
      ],onTap: (btnIndex){
        print(btnIndex)
      },),
    );
  }
}
