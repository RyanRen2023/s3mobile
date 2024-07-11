/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/12
 * Description: Lab 7 - Database configuration using Floor
 */

// Required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:lab_two/TodoDAO.dart';
import 'package:lab_two/Todo.dart';
part 'database.g.dart'; // the generated code will be there

/**
 * The AppDatabase class is the main database configuration class
 * that uses the Floor package to set up the database and manage entities.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
@Database(version: 1, entities: [Todo])
abstract class AppDatabase extends FloorDatabase {
  /**
   * Provides the TodoDAO instance for accessing Todo entities in the database.
   *
   * @return TodoDAO The data access object for Todo entities.
   */
  TodoDAO get todoDAO;
}
