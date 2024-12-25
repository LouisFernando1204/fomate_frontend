part of 'repository.dart';

class ContentRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Content>> getContentList(String userId) async {
    try {
      dynamic unpurchasedResponse = await _apiServices
          .getApiResponse('/api/get_unpurchased_content/${userId}');
      List<Content> unpurchasedContent = [];
      if (unpurchasedResponse != null) {
        unpurchasedContent = (unpurchasedResponse as List)
            .map((e) => Content.fromJson(e))
            .toList();
        print("Unpurchased content retrieved: $unpurchasedContent");
      }

      dynamic purchasedResponse = await _apiServices
          .getApiResponse('/api/get_purchased_content/${userId}');
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

  Future<List<String>> purchaseAllContent(String userId) async {
    try {
      Map<String, String> requestBody = {
        "userId": userId,
      };

      dynamic response = await _apiServices.postApiResponse(
        '/api/purchase_all_content',
        requestBody,
      );

      if (response != null && response['InsertedIDs'] != null) {
        List<String> insertedIds = List<String>.from(response['InsertedIDs']);
        print("All content successfully purchased with IDs: $insertedIds");
        return insertedIds;
      } else {
        throw Exception(
            response['message'] ?? 'Failed to purchase all content.');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('Error purchasing all content: $e');
    }
  }

  Future<String> purchaseContent(String userId, String contentId) async {
    try {
      Map<String, String> requestBody = {
        "userId": userId,
        "contentId": contentId
      };

      dynamic response = await _apiServices.postApiResponse(
        '/api/purchase_content',
        requestBody,
      );

      if (response != null && response['InsertedID'] != null) {
        String insertedId = response['InsertedID'];
        print("Content successfully purchased with ID: $insertedId");
        return insertedId;
      } else {
        throw Exception(response['message'] ?? 'Failed to purchase content.');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('Error purchasing content: $e');
    }
  }

  Future<List<dynamic>?> checkPurchasedContent(
      String userId, String contentId) async {
    try {
      dynamic response = await _apiServices
          .getApiResponse('/api/get_purchased_content/${userId}');

      if (response != null) {
        var purchasedContent = response.firstWhere(
          (content) => content['id'] == contentId,
          orElse: () => null,
        );

        if (purchasedContent != null) {
          return [Content.fromJson(purchasedContent), true];
        } else {
          dynamic unpurchasedResponse = await _apiServices
              .getApiResponse('/api/get_unpurchased_content/${userId}');

          if (unpurchasedResponse != null) {
            var unpurchasedContent = unpurchasedResponse.firstWhere(
              (content) => content['id'] == contentId,
              orElse: () => null,
            );

            if (unpurchasedContent != null) {
              return [Content.fromJson(unpurchasedContent), false];
            } else {
              return null;
            }
          } else {
            throw Exception('Failed to retrieve unpurchased contents.');
          }
        }
      } else {
        throw Exception(
            response['message'] ?? 'Failed to retrieve purchased contents.');
      }
    } catch (e) {
      print("An error occurred: $e");
      return null;
    }
  }
}
