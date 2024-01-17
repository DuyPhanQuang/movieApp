import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:retry/retry.dart';

import '../exception/exception.dart';
import 'config.dart';

const defaultErrorJson = '{"data": {"message": "Error occurred while '
    'Communication with Server with StatusCode"}}';

typedef AuthorizationCallback = Authorization? Function();

abstract class BaseRemote {
  late Client _client;
  late HeaderConfig _config;
  AuthorizationCallback? _getAuthorization;

  BaseRemote({
    Client? client,
    required HeaderConfig config,
    AuthorizationCallback? getAuthorization,
  }) {
    _client = client ?? Client();
    _config = config;
    _getAuthorization = getAuthorization;
  }

  Uri _getParsedUrl({
    required String method,
    required String path,
    Map<String, dynamic>? params,
  }) {
    if (method == 'GET') {
      return Uri.parse(path).replace(queryParameters: params);
    }

    return Uri.parse(path);
  }

  String getAuthorizationHeader(ApiHeaderType type, Request request) {
    final authorization = _getAuthorization?.call();
    switch (type) {
      case ApiHeaderType.normal:
        return 'Bearer ${_config.encodedCredentials}';
      case ApiHeaderType.withToken:
        return 'Bearer ${authorization?.accessToken}';
      case ApiHeaderType.withoutToken:
        return request.headers[HttpHeaders.authorizationHeader] ?? '';
    }
  }

  Future<dynamic> _call(
      String method,
      String path,
      ApiHeaderType type, {
        Map<String, String>? customHeader,
        dynamic data,
      }) async {
    final url = _getParsedUrl(
      method: method,
      path: path,
      params: method == 'GET' ? data : null,
    );
    debugPrint('Call API >> $method >> url: $url >> body: $data');
    dynamic responseJson;
    try {
      final request = Request(
          method,
          _getParsedUrl(
              method: method,
              path: path,
              params: method == 'GET' ? data : null));
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      request.headers[HttpHeaders.authorizationHeader] =
          getAuthorizationHeader(type, request);
      request.headers[HttpHeaders.accessControlAllowOriginHeader] = '*';
      request.headers[HttpHeaders.accessControlAllowMethodsHeader] =
      'POST, GET, OPTIONS, PUT, DELETE, HEAD';
      if (customHeader != null) {
        for (final entry in customHeader.entries) {
          request.headers[entry.key] = entry.value;
        }
      }

      final shouldPutBodyToRequest = method != 'GET' && data != null;
      if (shouldPutBodyToRequest) {
        final requestBody = data as Map<String, Object?>;
        request.body = jsonEncode(requestBody);
      }

      responseJson = await retry(() async {
        final response = await _client
            .send(request)
            .timeout(const Duration(seconds: 120))
            .then(Response.fromStream);
        return _returnResponse(response);
      }, retryIf: (e) async {
        /// TODO: handle logic refresh token,re-fetch api, etc here

        return false;
      });
    } on SocketException {
      debugPrint('No Internet connection');
      throw const SocketException('Operation timed out');
    }

    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    debugPrint('HTTP response\n'
        'Status: ${response.statusCode}\n'
        'Request: ${response.request}\n'
        'Data: ${response.body}');

    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        final responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        return null;
      case 400:
        final responseJson = jsonDecode(response.body);
        throw BadRequestException(responseJson);
      case 403:
        final responseJson = jsonDecode(response.body);
        throw ForbiddenException(responseJson);
      case 404:
        final responseJson = jsonDecode(response.body);
        throw NotFoundException(responseJson);
      case 500:
        final responseJson = jsonDecode(response.body);
        throw ServerErrorException(responseJson);
      default:
        final responseJson = jsonDecode(defaultErrorJson);
        throw FetchDataException(responseJson);
    }
  }

  dynamic get(String url, ApiHeaderType type,
      {Map<String, String>? customHeader, dynamic data}) async {
    return await _call('GET', url, type,
        customHeader: customHeader, data: data);
  }

  @override
  String toString() => 'BaseRemoteDataSource';
}
