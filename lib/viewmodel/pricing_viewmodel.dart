part of 'viewmodel.dart';

class PricingViewmodel with ChangeNotifier {
  final _priceRepo = PricingRepository();

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<dynamic> purchaseContent(String userId, String contentId) async {
    setLoading(true);
    try {
      final response = await _priceRepo.purchaseContent(userId, contentId);
      return response;
    } catch (e) {
      print("Error while purchasing content : ${e}");
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<dynamic> purchaseAllContent(String userId) async {
    setLoading(true);
    try {
      final response = await _priceRepo.purchaseAllContent(userId);
      return response;
    } catch (e) {
      print("Error while purchasing all content : ${e}");
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
