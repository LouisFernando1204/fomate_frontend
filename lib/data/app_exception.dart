class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    // TODO: implement toString
    return '$_message $_prefix';
  }
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);

  @override
  String toString() => 'FetchDataException: $message';
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException(this.message);

  @override
  String toString() => 'NoInternetException: $message';
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);

  @override
  String toString() => 'BadRequestException: $message';
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}

class ServerErrorException implements Exception {
  final String message;
  ServerErrorException(this.message);

  @override
  String toString() => 'ServerErrorException: $message';
}
