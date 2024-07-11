/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/12
 * Description: Lab 7 - Using database
 */

import 'Todo.dart';
import 'TodoDAO.dart';
import 'database.dart';

/**
 * The DatabaseOperator class handles database operations
 * such as initializing the database and accessing data access objects (DAOs).
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class DatabaseOperator {
  // Static variable to hold the database instance
  static late final AppDatabase? _database;

  /**
   * Initializes the database if it has not been initialized.
   * Uses the Floor library to build the database.
   *
   * @return Future<void> A Future that completes when the database is initialized.
   */
  static Future<void> initDatabase() async {
    _database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  /**
   * Gets the TodoDAO instance. If the database has not been initialized, it will initialize it first.
   *
   * @return Future<TodoDAO?> A Future that completes with the TodoDAO instance.
   */
  static Future<TodoDAO?> getTodoDAO() async {
    if (_database == null) {
      await initDatabase();
    }
    return _database?.todoDAO;
  }

  /**
   * Gets all Todo items from the database.
   * Ensures that the database is initialized and the TodoDAO is available.
   *
   * @return Future<List<Todo>> A Future that completes with a list of all Todo items.
   */
  static Future<List<Todo>> getAllToItems() async {
    List<Todo> list = [];
    TodoDAO? todoDAO = await getTodoDAO();
    if (todoDAO != null) {
      list = await todoDAO.findAllTodos();
    }
    return list;
  }
}
