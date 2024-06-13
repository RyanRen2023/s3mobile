import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
class DataRepository{

  static final prefs = EncryptedSharedPreferences();
  static String loginName = "";
  static String firstName = "";
  static String lastName = "";
  static String phone = "";
  static String email = "";

  static final String _firstName = "firstName";
  static final String _lastName = "lastName";
  static final String _phone = "phone";
  static final String _email = "email";

  static loadData(){
    prefs.getString(_firstName).then((value) {
      if (value.isNotEmpty){
        firstName = value;
      }
    });
    prefs.getString(_lastName).then((value) {
      lastName = value;
    });
    prefs.getString(_phone).then((value){
      phone = value;
    });
    prefs.getString(_email).then((value){
      email = value;
    });
  }

  static saveData(){
    prefs.setString(_firstName, firstName);
    prefs.setString(_lastName, lastName);
    prefs.setString(_phone, phone);
    prefs.setString(_email, email);
  }
}