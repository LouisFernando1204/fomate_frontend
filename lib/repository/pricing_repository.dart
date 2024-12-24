part of 'repository.dart';

class PricingRepository {
  final apiUrl = "http://127.0.0.1:8080/api";

  Future<http.Response> purchaseContent(String userId, String contentId) async {
    try {
      print("User Id: ${userId}");
      print("Content Id: ${contentId}");

      final response = await http.post(Uri.parse('${apiUrl}/purchase_content'),
          body: {'userId': userId, 'contentId': contentId});

      if (response.statusCode == 200) {
        print("Response Body : ${response.body}");
        return jsonDecode(response.body);
      } else {
        print("Request failed: ${response.statusCode}");
        throw Exception('Failed to purchase content.');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<http.Response> purchaseAllContent(String userId) async {
    try {
      print("API : ${apiUrl}");
      print("User Id : ${userId}");

      final response = await http.post(
          Uri.parse('http://127.0.0.1:8080/api/purchase_all_content'),
          body: {'userId': userId});

      if (response.statusCode == 200) {
        print("Response Body : ${response.body}");
        return jsonDecode(response.body);
      } else {
        print("Request failed: ${response.statusCode}");

        throw Exception('Failed to purchase all content.');
      }
    } catch (e) {
      throw e;
    }
  }
}
