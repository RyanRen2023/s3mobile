/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/12
 * Description: Lab 7 - Todo list page using Flutter
 */

import 'package:flutter/material.dart';
import 'package:lab_two/Todo.dart';
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
  List<Todo> contents = [];
  late final TodoDAO? todoDAO;

  late TextEditingController _addTodoController;

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
                    child: const Text("OK")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No")),
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
      body: Center(
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
                    SizedBox(
                      width: ConfigProperties.sizedbox_width,
                    ),
                    Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _addTodoController,
                          decoration: const InputDecoration(
                            hintText: "add To Do list",
                            border: OutlineInputBorder(),
                            labelText: "Todo:",
                          ),
                        ))
                  ],
                ),
                Expanded(
                    child: contents.isEmpty
                        ? Text("There are no items in the list")
                        : ListView.builder(
                            itemCount: contents.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Row number: $index",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: ConfigProperties.font_size,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              ConfigProperties.sizedbox_width),
                                      Text(
                                        contents[index].content,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: ConfigProperties.font_size,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onLongPress: () => dialogDeleteItem(index),
                                ),
                              );
                            },
                          )),
              ],
            )),
      ),
    );
  }
}
