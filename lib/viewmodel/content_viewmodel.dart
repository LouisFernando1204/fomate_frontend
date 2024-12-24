import 'package:flutter/material.dart';
import 'package:fomate_frontend/data/response/api_response.dart';
import 'package:fomate_frontend/model/model.dart';
import 'package:fomate_frontend/repository/content_repository.dart';

class ContentViewModel with ChangeNotifier {
  final _contentRepo = ContentRepository();

  ApiResponse<List<Content>> contentList = ApiResponse.loading();
  setContentList(ApiResponse<List<Content>> response) {
    contentList = response;
    notifyListeners();
  }

  Future<dynamic> getContentList() async {
    _contentRepo.fetchAllContent().then((value) {
      setContentList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setContentList(ApiResponse.error(error.toString()));
    });
  }
}
