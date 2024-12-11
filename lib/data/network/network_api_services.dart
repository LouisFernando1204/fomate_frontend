import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:fomate_frontend/data/app_exception.dart';
import 'package:fomate_frontend/data/network/base_api_services.dart';
import 'package:fomate_frontend/shared/shared.dart';

class NetworkApiServices implements BaseApiServices {
  @override
  Future<dynamic> getApiResponse(String endpoint) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.https(Const.baseUrl, endpoint),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'key': Const.apiKey
          });
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network request timeout!');
    }
  }

  @override
  Future<dynamic> postApiResponse(String endpoint, dynamic data) async {
    dynamic responseJson;
    try {
      print("DATA");
      print(data);
      final response = await http.post(
        Uri.https(Const.baseUrl, endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apiKey,
        },
        body: jsonEncode(data),
      );
      responseJson = returnResponse(response);
      print("RESPONSE");
      print(responseJson);
      return responseJson;
    } on SocketException {
      throw NoInternetException('No internet connection!');
    } on TimeoutException {
      throw FetchDataException('Network request timeout!');
    } on FormatException {
      throw FetchDataException('Invalid response format!');
    } catch (e) {
      throw FetchDataException('Unexpected error: $e');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw NotFoundException('Resource not found: ${response.body}');
      case 500:
        throw ServerErrorException('Server error: ${response.body}');
      default:
        throw FetchDataException(
            'Error occurred while communicating with server');
    }
  }
}
