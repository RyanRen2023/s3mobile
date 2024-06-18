import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ConfigProperties.dart';
import 'ListViewRepository.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() {
    return TodoListPageState();
  }
}

class TodoListPageState extends State<TodoListPage> {
  List<String> contents = [];

  late TextEditingController _addTodoController;

  @override
  void initState() {
    super.initState();
    _addTodoController = TextEditingController();
    initListView();
  }

  @override
  void dispose() {
    saveListView();
    _addTodoController.dispose();
    super.dispose();
  }

  void addTodoList() {
    var todo = _addTodoController.value.text;
    if (todo.isNotEmpty) {
      setState(() {
        contents.add(todo);
        _addTodoController.text = "";
      });
    }
  }

  Future<void> initListView() async {
    await ListViewRepository.retrieveListView();
    Future.delayed(Duration.zero, () {
      setState(() {
        contents = ListViewRepository.contents;
      });
    });
  }

  void saveListView() {
    ListViewRepository.contents = contents;
    ListViewRepository.saveListView();
  }

  void dialogDeleteItem(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Delete Item"),
              content: const Text("Confirm to Delete Item?"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contents.removeAt(index);
                      });
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
                    child: contents.length == 0
                        ? Text("There are no items in the list")
                        : ListView.builder(
                            itemCount: contents.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Row number: $index"),
                                    SizedBox(
                                        width: ConfigProperties.sizedbox_width),
                                    Text(contents[index]),
                                  ],
                                ),
                                onLongPress: () => dialogDeleteItem(index),
                              );
                            },
                          )),
              ],
            )),
      ),
    );
  }
}
