import 'dart:convert';
import 'package:fomate_frontend/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorage {
  static const String _userKey = 'user_data';

  static Future<void> saveUserData(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson = jsonEncode(user.toJson());
      await prefs.setString(_userKey, userJson);
      print("User data saved successfully.");
    } catch (e) {
      print("Error saving user data: $e");
      throw Exception("Failed to save user data.");
    }
  }

  static Future<User?> getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString(_userKey);

      if (userJson != null) {
        Map<String, dynamic> userData = jsonDecode(userJson);
        print("User data retrieved: $userData");
        return User.fromJson(userData);
      } else {
        print("No user data found.");
        return null;
      }
    } catch (e) {
      print("Error retrieving user data: $e");
      throw Exception("Failed to retrieve user data.");
    }
  }

  static Future<void> clearUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      print("User data cleared successfully.");
    } catch (e) {
      print("Error clearing user data: $e");
      throw Exception("Failed to clear user data.");
    }
  }
}
