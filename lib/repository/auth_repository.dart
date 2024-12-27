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

        final user = User(
          id: response['InsertedID'],
          username: username,
          email: email,
          password: password,
          health: 100,
        );

        await UserLocalStorage.saveUserData(user);

        return user.id!;
      } else {
        throw Exception("Registration failed. Invalid response from server.");
      }
    } catch (e) {
      print("An error occurred during registration: $e");
      throw Exception("Registration failed: $e");
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final body = {
        "email": email,
        "password": password,
      };

      dynamic response =
          await _apiServices.postApiResponse('/api/get_user', body);

      if (response != null && response['id'] != null) {
        print("User logged in successfully: ${response['id']}");

        final user = User.fromJson(response);

        await UserLocalStorage.saveUserData(user);

        return user;
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
