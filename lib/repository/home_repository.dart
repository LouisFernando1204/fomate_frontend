part of 'repository.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<int> getHealth(String userId) async {
    try {
      dynamic response =
          await _apiServices.getApiResponse('/api/get_health/$userId');

      if (response != null) {
        return response as int;
      } else {
        throw Exception(
            "Failed to retrieve health. Invalid response from server.");
      }
    } catch (e) {
      print("An error occurred while fetching health: $e");
      throw Exception("Failed to retrieve health: $e");
    }
  }

  Future<String> updateHealth(String userId, int newHealth) async {
    try {
      final body = {
        "userId": userId,
        "newHealth": newHealth,
      };

      dynamic response =
          await _apiServices.postApiResponse('/api/update_health', body);

      if (response != null) {
        print("User health updated successfully.");
        return "Health updated successfully";
      } else {
        throw Exception(
            "Failed to update health. Invalid response from server.");
      }
    } catch (e) {
      print("An error occurred while updating health: $e");
      throw Exception("Failed to update health: $e");
    }
  }

  Future<String> addSchedule(String userId, String appName, String startTime,
      String endTime, int timer) async {
    try {
      final body = {
        "userId": userId,
        "appName": appName,
        "startTime": startTime,
        "endTime": endTime,
        "timer": timer,
      };

      dynamic response =
          await _apiServices.postApiResponse('/api/add_schedule', body);

      if (response != null && response['InsertedID'] != null) {
        print("Schedule added successfully with ID: ${response['InsertedID']}");
        return response['InsertedID'];
      } else {
        throw Exception(
            "Failed to add schedule. Invalid response from server.");
      }
    } catch (e) {
      print("An error occurred while adding schedule: $e");
      throw Exception("Failed to add schedule: $e");
    }
  }

  Future<List<Schedule>> getScheduleList(String userId) async {
    try {
      dynamic response =
          await _apiServices.getApiResponse('/api/get_schedule/$userId');

      if (response != null) {
        List<Schedule> schedules = (response as List)
            .map((scheduleJson) => Schedule.fromJson(scheduleJson))
            .toList();
        return schedules;
      } else {
        throw Exception(
            "Failed to retrieve schedules. Invalid response from server.");
      }
    } catch (e) {
      print("An error occurred while fetching schedule: $e");
      throw Exception("Failed to retrieve schedule: $e");
    }
  }

  Future<List<App>> getAppList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/api/get_all_app');

      if (response != null) {
        List<App> apps =
            (response as List).map((appJson) => App.fromJson(appJson)).toList();
        return apps;
      } else {
        throw Exception(
            "Failed to retrieve apps. Invalid response from server.");
      }
    } catch (e) {
      print("An error occurred while fetching app: $e");
      throw Exception("Failed to retrieve app: $e");
    }
  }
}
