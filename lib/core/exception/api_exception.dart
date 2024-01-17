class ApiException implements Exception {
  final dynamic _data;

  ApiException(
      dynamic json, {
        String? prefix,
      }) : _data = json;

  dynamic get error => _data;
}

class FetchDataException extends ApiException {
  FetchDataException([dynamic error])
      : super(error, prefix: 'Error During Communication:');
}

class BadRequestException extends ApiException {
  BadRequestException([dynamic error])
      : super(error, prefix: 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([dynamic error])
      : super(error, prefix: 'Unauthorised: ');
}

class ForbiddenException extends ApiException {
  ForbiddenException([dynamic error]) : super(error, prefix: 'Forbidden: ');
}

class NotFoundException extends ApiException {
  NotFoundException([dynamic error]) : super(error, prefix: 'Not Found: ');
}

class ServerErrorException extends ApiException {
  ServerErrorException([dynamic error])
      : super(error, prefix: 'Server Error: ');
}
