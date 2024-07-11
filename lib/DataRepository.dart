/*
 * Student Name: Xihai Ren
 * Student No: 041127486
 * Professor: Eric Torunski
 * Due Date: 2024/07/12
 * Description: Lab 7 - Data repository using encrypted shared preferences
 */

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

/**
 * The DataRepository class handles the storage and retrieval of user data
 * using EncryptedSharedPreferences for secure data management.
 *
 * @version 1.0.0
 * @since Dart 2.12
 *
 * @author Xihai Ren
 */
class DataRepository {
  // Static instance of EncryptedSharedPreferences for secure storage
  static final prefs = EncryptedSharedPreferences();

  // Static variables to hold user data
  static String loginName = "";
  static String firstName = "";
  static String lastName = "";
  static String phone = "";
  static String email = "";

  // Keys for storing data in EncryptedSharedPreferences
  static final String _firstName = "firstName";
  static final String _lastName = "lastName";
  static final String _phone = "phone";
  static final String _email = "email";

  /**
   * Loads user data from EncryptedSharedPreferences.
   * Retrieves firstName, lastName, phone, and email and assigns them to the respective variables.
   */
  static loadData() {
    prefs.getString(_firstName).then((value) {
      if (value.isNotEmpty) {
        firstName = value;
      }
    });
    prefs.getString(_lastName).then((value) {
      lastName = value;
    });
    prefs.getString(_phone).then((value) {
      phone = value;
    });
    prefs.getString(_email).then((value) {
      email = value;
    });
  }

  /**
   * Saves user data to EncryptedSharedPreferences.
   * Stores firstName, lastName, phone, and email using the defined keys.
   */
  static saveData() {
    prefs.setString(_firstName, firstName);
    prefs.setString(_lastName, lastName);
    prefs.setString(_phone, phone);
    prefs.setString(_email, email);
  }
}
