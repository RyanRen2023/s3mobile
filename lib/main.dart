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
      home: const MyHomePage(title: 'Mobile Lab3 Food Galley'),
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

  var fontsize_h1 = 25.0;
  var fontsize_h2 = 20.0;
  var fontsize_h3 = 15.0;

  var pngHight = 80.0;
  var pngWidth = 80.0;
  var meat_array = [
    "images/Beef.png",
    "images/Chicken.png",
    "images/Pork.png",
    "images/Seafood.png"
  ];
  var meat_array_name = ["BEEF", "CHICKEN", "PORK", "SEAFOOD"];

  var course_array = [
    "images/MainDishes.png",
    "images/Salad.png",
    "images/SideDishes.png",
    "images/Crockpot.png"
  ];
  var course_array_name = [
    "Main Dishes",
    "Salad Recipes",
    "Side dishes",
    "Crockpot"
  ];

  var dessert_array = [
    "images/Ice_cream.png",
    "images/Brownies.png",
    "images/Pies.png",
    "images/Cookies.png"
  ];
  var dessert_array_name = ["Ice Cream", "Brownies", "Pies", "Cookies"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
          // width: 500,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 4.0)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "BROWSE CATEGORIES",
                  style: TextStyle(fontSize: fontsize_h1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Center(
                    child: Text(
                      "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                      style: TextStyle(fontSize: fontsize_h2),
                    ),
                  ),
                ),
                Text(
                  "BY MEAT",
                  style: TextStyle(fontSize: fontsize_h2,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            meat_array[0],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          meat_array_name[0],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            meat_array[1],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          meat_array_name[1],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            meat_array[2],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          meat_array_name[2],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            meat_array[3],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          meat_array_name[3],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "BY COURSE",
                  style: TextStyle(fontSize: fontsize_h2,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            course_array[0],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          course_array_name[0],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            course_array[1],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          course_array_name[1],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            course_array[2],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          course_array_name[2],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            course_array[3],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          course_array_name[3],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "BY DESSERT",
                  style: TextStyle(fontSize: fontsize_h2,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            dessert_array[0],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          dessert_array_name[0],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            dessert_array[1],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          dessert_array_name[1],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            dessert_array[2],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          dessert_array_name[2],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            dessert_array[3],
                            fit: BoxFit.cover,
                            width: pngWidth,
                            height: pngHight,
                          ),
                        ),
                        Text(
                          dessert_array_name[3],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontsize_h3,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}
