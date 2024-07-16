import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Todo.dart';

/**
 * The TodoDetailPage class represents the detail screen of a selected todo item.
 * It receives a title and a selected todo item as parameters.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({super.key, required this.title, this.selectedTodo});

  final String title;
  final Todo? selectedTodo;

  @override
  State<StatefulWidget> createState() => TodoDetailPageState();
}

/**
 * The TodoDetailPageState class contains the logic for the TodoDetailPage widget,
 * including displaying the details of the selected todo item.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class TodoDetailPageState extends State<TodoDetailPage> {
  /**
   * Builds the detailed view for the selected todo item.
   *
   * @return A widget displaying the details of the selected todo item.
   */
  Widget todoDetailedView() {
    final _selectedTodo = widget.selectedTodo;
    // Check if a todo item is selected
    if (_selectedTodo != null) {
      // If a todo item is selected, display its details in a Card
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
                    _selectedTodo.id.toString(),
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
                      _selectedTodo.content.toString(),
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
      // If no todo item is selected, display a message
      return Center(
        child: Text(
          'No todo selected',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: todoDetailedView(),
      ),
    );
  }
}