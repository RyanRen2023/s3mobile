/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/12
 * Description: Lab 7 - Data Access Object (DAO) for the Todo entity using Floor
 */

import 'package:floor/floor.dart';
import 'package:lab_two/Todo.dart';

/**
 * The TodoDAO class provides the methods that the rest of the application
 * uses to interact with the data in the Todo table.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
@dao
abstract class TodoDAO {
  /**
   * Retrieves all todo items from the database.
   *
   * @return A Future that resolves to a list of all todo items.
   */
  @Query('SELECT * FROM Todo')
  Future<List<Todo>> findAllTodos();

  /**
   * Finds a todo item by its id.
   *
   * @param id The id of the todo item to retrieve.
   * @return A Stream that emits the todo item with the specified id, or null if not found.
   */
  @Query('SELECT * FROM Todo WHERE id = :id')
  Stream<Todo?> findTodoById(int id);

  /**
   * Inserts a new todo item into the database.
   *
   * @param todo The todo item to insert.
   */
  @insert
  Future<void> insertTodo(Todo todo);

  /**
   * Deletes a todo item by its id.
   *
   * @param id The id of the todo item to delete.
   */
  @Query('DELETE FROM Todo WHERE id = :id')
  Future<void> deleteTodoById(int id);
}