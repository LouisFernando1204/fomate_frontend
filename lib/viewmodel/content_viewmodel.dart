part of 'viewmodel.dart';

class ContentViewModel with ChangeNotifier {
  final _contentRepo = ContentRepository();

  ApiResponse<List<Content>> contentList = ApiResponse.loading();
  setContentList(ApiResponse<List<Content>> response) {
    contentList = response;
    notifyListeners();
  }

  Future<dynamic> getContentList(String userId) async {
    _contentRepo.fetchAllContent(userId).then((value) {
      setContentList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setContentList(ApiResponse.error(error.toString()));
    });
  }

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  ApiResponse<List<String>> insertedPurchasedAllContentIDs =
      ApiResponse.loading();
  setInsertedPurchasedAllContentIDs(ApiResponse<List<String>> response) {
    insertedPurchasedAllContentIDs = response;
    notifyListeners();
  }

  Future<dynamic> purchaseAllContent(String userId) async {
    _contentRepo.purchaseAllContent(userId).then((value) {
      setLoading(true);
      setInsertedPurchasedAllContentIDs(ApiResponse.completed(value));
      setLoading(false);
    }).onError((error, stackTrace) {
      setInsertedPurchasedAllContentIDs(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<String> insertedPurchasedContentID = ApiResponse.loading();
  setInsertedPurchasedContentID(ApiResponse<String> response) {
    insertedPurchasedContentID = response;
    notifyListeners();
  }

  Future<dynamic> purchaseContent(String userId, String contentId) async {
    _contentRepo.purchaseContent(userId, contentId).then((value) {
      setLoading(true);
      setInsertedPurchasedContentID(ApiResponse.completed(value));
      setLoading(false);
    }).onError((error, stackTrace) {
      setInsertedPurchasedContentID(ApiResponse.error(error.toString()));
    });
  }
}
