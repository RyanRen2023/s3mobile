/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/19
 * Description: Week 9 Lab 7 - Todo list page using responsive layout
 */

import 'package:flutter/material.dart';
import 'package:lab_two/Todo.dart';
import 'package:lab_two/TodoDetailPage.dart';
import 'ConfigProperties.dart';
import 'DatabaseOperator.dart';
import 'TodoDAO.dart';

/**
 * The TodoListPage class represents the todo list screen of the application.
 * It manages the state of the todo list and handles adding and deleting todo items.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return TodoListPageState();
  }
}

/**
 * The TodoListPageState class contains the logic for the TodoListPage widget,
 * including database interactions and user interface updates.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class TodoListPageState extends State<TodoListPage> {
  // List to store todo items
  List<Todo> contents = [];
  // Data access object for interacting with the database
  late final TodoDAO? todoDAO;

  // Controller for the text field to add new todo items
  late TextEditingController _addTodoController;

  // Currently selected todo item
  Todo? _selectedTodo;

  /**
   * Initializes the database and loads the existing todo items.
   */
  Future<void> _initDatabase() async {
    todoDAO = await DatabaseOperator.getTodoDAO();
    contents = await DatabaseOperator.getAllToItems();
  }

  /**
   * Adds a new todo item to the list and the database.
   */
  void addTodoList() {
    var todo = _addTodoController.value.text;
    final newItem = Todo(DateTime.now().millisecondsSinceEpoch, todo);
    if (todo.isNotEmpty) {
      setState(() {
        contents.add(newItem);
        _addTodoController.text = "";
      });
      todoDAO?.insertTodo(newItem).then((value) {
        print("add successful " + newItem.content);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _addTodoController = TextEditingController();
    _initDatabase().then((value) {
      initListView();
    });
  }

  @override
  void dispose() {
    _addTodoController.dispose();
    super.dispose();
  }

  /**
   * Initializes the list view by setting the state.
   */
  void initListView() {
    setState(() {
      contents;
    });
  }

  /**
   * Creates a responsive layout based on screen size.
   * If the screen is wide, show a side-by-side layout of the list and details.
   * Otherwise, show only the list.
   */
  Widget responsiveLayout() {
    var screen = MediaQuery.of(context).size;
    var height = screen.height;
    var width = screen.width;
    if (width > height || width > 720) {
      return Row(
        children: [
          Expanded(child: todoListView()),
          SizedBox(width: 10),
          Expanded(child: todoDetailedView())
        ],
      );
    } else {
      return todoListView();
    }
  }

  /**
   * Builds the todo list view with add button and text field.
   */
  Widget todoListView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ConfigProperties.padding_size),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: addTodoList,
                  child: const Text("ADD"),
                ),
                SizedBox(width: ConfigProperties.sizedbox_width),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _addTodoController,
                    decoration: const InputDecoration(
                      hintText: "Add To Do list",
                      border: OutlineInputBorder(),
                      labelText: "Todo:",
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: contents.isEmpty
                  ? Center(child: Text("There are no items in the list"))
                  : ListView.builder(
                      itemCount: contents.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5.0),
                          child: ListTile(
                            title: Text(
                              "Row number: $index",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ConfigProperties.font_size,
                                color: Colors.blue,
                              ),
                            ),
                            subtitle: Text(
                              contents[index].content,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ConfigProperties.font_size,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              var screen = MediaQuery.of(context).size;
                              var height = screen.height;
                              var width = screen.width;
                              setState(() {
                                _selectedTodo = contents[index];
                              });

                              // Navigate to the detail page if screen is narrow
                              if (width <= height && width <= 720) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TodoDetailPage(
                                      title: "Todo Detail",
                                      selectedTodo: _selectedTodo,
                                    ),
                                  ),
                                );
                              }
                            },
                            onLongPress: () => dialogDeleteItem(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * Builds the detailed view for the selected todo item.
   */
  Widget todoDetailedView() {
    if (_selectedTodo != null) {
      return Card(
        elevation: 5,
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.assignment, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    "Todo Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.blue),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "ID: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _selectedTodo!.id.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Todo: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _selectedTodo!.content.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Text(
          'No data selected',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  /**
   * Displays a dialog to confirm the deletion of a todo item.
   *
   * @param index The index of the todo item to delete.
   */
  void dialogDeleteItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Delete Item"),
              content: const Text("Confirm to Delete Item?"),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    Todo todo = contents[index];
                    setState(() {
                      contents.removeAt(index);
                    });
                    todoDAO?.deleteTodoById(todo.id);
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: responsiveLayout(),
    );
  }
}
