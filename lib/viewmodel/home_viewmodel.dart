part of 'viewmodel.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepository = HomeRepository();

  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  ApiResponse<String> successUpdateHealth = ApiResponse.loading();
  setSuccessUpdateHealth(ApiResponse<String> response) {
    successUpdateHealth = response;
    notifyListeners();
  }

  Future<dynamic> updateHealth(String userId, int newHealth) async {
    setLoading(true);
    _homeRepository.updateHealth(userId, newHealth).then((value) {
      setSuccessUpdateHealth(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSuccessUpdateHealth(ApiResponse.error(error.toString()));
      _showErrorToast(error.toString());
    }).whenComplete(() {
      setLoading(false);
    });
  }

  ApiResponse<String> successAddSchedule = ApiResponse.loading();
  setSuccessAddSchedule(ApiResponse<String> response) {
    successAddSchedule = response;
    notifyListeners();
  }

  Future<dynamic> addSchedule(String userId, String appName, String startTime,
      String endTime, int timer) async {
    setLoading(true);
    _homeRepository
        .addSchedule(userId, appName, startTime, endTime, timer)
        .then((value) {
      setSuccessAddSchedule(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSuccessAddSchedule(ApiResponse.error(error.toString()));
      _showErrorToast(error.toString());
    }).whenComplete(() {
      setLoading(false);
    });
  }

  ApiResponse<List<App>> appList = ApiResponse.loading();
  setAppList(ApiResponse<List<App>> response) {
    appList = response;
    notifyListeners();
  }

  ApiResponse<int> userHealth = ApiResponse.loading();
  setUserHealth(ApiResponse<int> response) {
    userHealth = response;
    notifyListeners();
  }

  ApiResponse<List<Schedule>> scheduleList = ApiResponse.loading();
  setScheduleList(ApiResponse<List<Schedule>> response) {
    scheduleList = response;
    notifyListeners();
  }

  Future<dynamic> getHomeData(String userId) async {
    setLoading(true);

    _homeRepository.getAppList().then((value) {
      setAppList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setAppList(ApiResponse.error(error.toString()));
      _showErrorToast(error.toString());
    });

    _homeRepository.getHealth(userId).then((value) {
      setUserHealth(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserHealth(ApiResponse.error(error.toString()));
      _showErrorToast(error.toString());
    });

    _homeRepository.getScheduleList(userId).then((value) {
      setScheduleList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setScheduleList(ApiResponse.error(error.toString()));
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
