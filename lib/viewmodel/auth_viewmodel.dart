part of 'viewmodel.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  ApiResponse<String> insertedUserID = ApiResponse.loading();
  setInsertedUserID(ApiResponse<String> response) {
    insertedUserID = response;
    notifyListeners();
  }

  Future<dynamic> register(BuildContext context, String username, String email,
      String password) async {
    setLoading(true);
    _authRepo.register(username, email, password).then((value) {
      setInsertedUserID(ApiResponse.completed(value));
      context.go('/mainmenu');
    }).onError((error, stackTrace) {
      setInsertedUserID(ApiResponse.error(error.toString()));
      _showErrorToast(error.toString());
    }).whenComplete(() {
      setLoading(false);
    });
  }

  ApiResponse<User> userData = ApiResponse.loading();
  setUserData(ApiResponse<User> response) {
    userData = response;
    notifyListeners();
  }

  Future<dynamic> login(
      BuildContext context, String email, String password) async {
    setLoading(true);
    _authRepo.login(email, password).then((value) {
      setUserData(ApiResponse.completed(value));
      context.go('/mainmenu');
    }).onError((error, stackTrace) {
      setUserData(ApiResponse.error(error.toString()));
      _showErrorToast(error.toString());
    }).whenComplete(() {
      setLoading(false);
    });
  }

  ApiResponse<void> logoutProcess = ApiResponse.loading();
  setLogoutProcess(ApiResponse<void> response) {
    logoutProcess = response;
    notifyListeners();
  }

  Future<dynamic> logout(BuildContext context) async {
    setLoading(true);
    _authRepo.logout().then((_) {
      setLogoutProcess(ApiResponse.completed(null));
      context.go('/login');
    }).onError((error, stackTrace) {
      setLogoutProcess(ApiResponse.error(error.toString()));
      _showErrorToast(error.toString());
    }).whenComplete(() {
      setLoading(false);
    });
  }

  _showErrorToast(String error) {
    String errorMessage = _getErrorMessage(error);
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  String _getErrorMessage(String error) {
    final regex = RegExp(r'{"error":"(.*?)"}');
    final match = regex.firstMatch(error);

    if (match != null && match.group(1) != null) {
      return match.group(1)!;
    }
    return 'Unknown error';
  }
}
