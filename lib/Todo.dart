/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/12
 * Description: Lab 7 - Todo entity class for use with the Floor database
 */

import 'package:floor/floor.dart';

/**
 * The Todo class represents a todo item entity in the database.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
@entity
class Todo {
  // Primary key for the todo item
  @primaryKey
  final int id;

  // Content of the todo item
  final String content;

  /**
   * Constructs a new Todo instance.
   *
   * @param id The unique identifier for the todo item.
   * @param content The content of the todo item.
   */
  Todo(this.id, this.content);
}
