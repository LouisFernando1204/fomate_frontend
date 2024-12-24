import 'package:fomate_frontend/data/network/network_api_services.dart';
import 'package:fomate_frontend/model/model.dart';

class ContentRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Content>> fetchAllContent() async {
    try {
      dynamic unpurchasedResponse = await _apiServices.getApiResponse(
          '/api/get_unpurchased_content/676a498e14808629f4d44778');
      List<Content> unpurchasedContent = [];
      if (unpurchasedResponse != null) {
        unpurchasedContent = (unpurchasedResponse as List)
            .map((e) => Content.fromJson(e))
            .toList();
        print("Unpurchased content retrieved: $unpurchasedContent");
      }

      dynamic purchasedResponse = await _apiServices.getApiResponse(
          '/api/get_purchased_content/676a498e14808629f4d44778');
      List<Content> purchasedContent = [];
      if (purchasedResponse != null) {
        purchasedContent = (purchasedResponse as List)
            .map((e) => Content.fromJson(e))
            .toList();
        print("Purchased content retrieved: $purchasedContent");
      }

      List<Content> allContent = [...unpurchasedContent, ...purchasedContent];
      print("Combined content: $allContent");

      return allContent;
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('Error fetching content: $e');
    }
  }
}
