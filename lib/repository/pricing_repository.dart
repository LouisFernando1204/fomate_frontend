part of 'repository.dart';

class PricingRepository {
  Future<http.Response> purchaseContent(String userId, String contentId) async {
    try {

      final apiUrl = dotenv.env['API_URL'] ?? 'http://127.0.0.1:8080/api';
      print("User Id: ${userId}");
      print("Content Id: ${contentId}");

      final response = await http.post(Uri.parse('${apiUrl}/purchase_content'),
          body: {'user_id': userId, 'content_id': contentId});

      if (response.statusCode == 200) {
        print("Response Body : ${response.body}");
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to purchase content.');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<http.Response> purchaseAllContent(String userId) async {
    try {

      final apiUrl = dotenv.env['API_URL'] ?? 'http://127.0.0.1:8080/api';
      print("API : ${apiUrl}");
      print("User Id : ${userId}");

      final response = await http.post(
          Uri.parse('${apiUrl}/api/purchase_content'),
          body: {'user_id': userId});

      if (response.statusCode == 200) {
        print("Response Body : ${response.body}");
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to purchase all content.');
      }
    } catch (e) {
      throw e;
    }
  }
}
