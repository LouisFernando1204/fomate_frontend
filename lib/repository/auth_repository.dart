part of 'repository.dart';

class AuthRepository {
  final _apiServices = NetworkApiServices();

  Future<String> register(
      String username, String email, String password) async {
    try {
      final body = {
        "username": username,
        "email": email,
        "password": password,
        "health": 100
      };

      dynamic response =
          await _apiServices.postApiResponse('/api/create_user', body);

      if (response != null && response['InsertedID'] != null) {
        print("User registered successfully: ${response['InsertedID']}");

        await UserLocalStorage.saveUserData(
          id: response['InsertedID'],
          username: username,
          email: email,
          password: password,
          health: 100,
        );

        return response['InsertedID'];
      } else {
        throw Exception("Registration failed. Invalid response from server.");
      }
    } catch (e) {
      print("An error occurred during registration: $e");
      throw Exception("Registration failed: $e");
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final body = {
        "email": email,
        "password": password,
      };

      dynamic response =
          await _apiServices.postApiResponse('/api/get_user', body);

      if (response != null && response['id'] != null) {
        print("User logged in successfully: ${response['id']}");

        await UserLocalStorage.saveUserData(
          id: response['id'],
          username: response['username'],
          email: response['email'],
          password: response['password'],
          health: response['health'],
        );

        return {
          "id": response['id'],
          "username": response['username'],
          "email": response['email'],
          "health": response['health'],
        };
      } else {
        throw Exception("Login failed. Invalid credentials.");
      }
    } catch (e) {
      print("An error occurred during login: $e");
      throw Exception("Login failed: $e");
    }
  }

  Future<void> logout() async {
    try {
      await UserLocalStorage.clearUserData();
      print("User logged out successfully.");
    } catch (e) {
      print("Error during logout: $e");
      throw Exception("Logout failed: $e");
    }
  }
}
