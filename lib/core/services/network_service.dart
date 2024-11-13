import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'user_storage.dart';

@immutable
final class ClientService {
  static const ClientService _service = ClientService._internal();

  const ClientService._internal();

  factory ClientService() => _service;

  static const String _meteoVersion = '/api:ZzNr7zwf';
  static const String _englishVersion = '/api:deqobAO8';
  static const String _newsVersion = '/api:eJPRAz5p';
  static const String _baseUrl = 'x8ki-letl-twmt.n7.xano.io';

  static const String apiGetMeteo = '$_meteoVersion/meteo';
  static const String apiGetEnglish = '$_englishVersion/english';
  static const String apiGetNews = '$_newsVersion/news';

  static Future<String?> get({
    required String api,
    bool isAuthHeaderNeeded = false,
    Map<String, dynamic>? param,
  }) async {
    final token = isAuthHeaderNeeded
        ? await UserStorage.load(key: StorageKey.token)
        : null;
    final httpClient = HttpClient();
    try {
      final url = Uri.https(_baseUrl, api, param);
      debugPrint(">>>>>>>>>>>>>>>>>>URL....$url>>>>>>>>>>>>>>>>>>>>");
      final request = await httpClient.getUrl(url);
      request.headers.set('Content-Type', 'application/json');
      if (isAuthHeaderNeeded) {
        request.headers.set(
          'Authorization',
          'Bearer $token',
        );
      }
      final response = await request.close();

      debugPrint(
          "\n<<<<<<<<<<<<<<<<<<<<<<<<<<${response.statusCode}>>>>>>>>>>>>>>>>>>>>>>>>");
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        return null;
      }
    } finally {
      httpClient.close();
    }
  }

  static Future<String?> post({
    required String api,
    Map<String, Object?>? data,
    bool isAuthHeaderNeeded = false,
    bool isFormData = false,
  }) async {
    final token = isAuthHeaderNeeded
        ? await UserStorage.load(key: StorageKey.token)
        : null;
    final httpClient = HttpClient();
    try {
      final url = Uri.https(_baseUrl, api);
      final request = await httpClient.postUrl(url);

      if (isAuthHeaderNeeded) {
        request.headers.set('Content-Type', 'application/json');
        request.headers.set('Authorization', 'Bearer $token');
      }

      if (isFormData) {
        const boundary = '----dart_http_boundry';
        request.headers
            .set('Content-Type', 'multipart/form-data; boundary=$boundary');
        final body = _encodeFormData(data, boundary);
        request
          ..contentLength = utf8.encode(body).length
          ..write(body);
      } else {
        request.headers.set('Content-Type', 'application/json');
        final jsonData = jsonEncode(data);
        request.add(utf8.encode(jsonData));
      }

      final response = await request.close();
      debugPrint(
          "\n<<<<<<<<<<<<<<<<<<<<<<<<<<${response.statusCode}>>>>>>>>>>>>>>>>>>>>>>>>");

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        final responseBody = await response.transform(utf8.decoder).join();
        debugPrint(
            "\n<<<<<<<<<<<<<<<<<<<<<<<<<<$responseBody>>>>>>>>>>>>>>>>>>>>>>>>");
        return responseBody;
      } else {
        return null;
      }
    } finally {
      httpClient.close();
    }
  }

  static String _encodeFormData(Map<String, Object?>? data, String boundary) {
    final buffer = StringBuffer();
    data?.forEach((key, value) {
      if (value is List<Object?>) {
        for (var item in value) {
          buffer.write('--$boundary\r\n');
          buffer.write('Content-Disposition: form-data; name="$key"\r\n\r\n');
          buffer.write('$item\r\n');
        }
      } else {
        buffer.write('--$boundary\r\n');
        buffer.write('Content-Disposition: form-data; name="$key"\r\n\r\n');
        buffer.write('$value\r\n');
      }
    });
    buffer.write('--$boundary--\r\n');
    return buffer.toString();
  }

  static Future<String?> put(
      {required String api,
      required Map<String, Object?> data,
      bool isAuthHeaderNeeded = false}) async {
    final token = isAuthHeaderNeeded
        ? await UserStorage.load(key: StorageKey.token)
        : isAuthHeaderNeeded;
    final httpClient = HttpClient();
    try {
      final url = Uri.https(_baseUrl, api);
      final request = await httpClient.putUrl(url);
      request.headers.set('Content-Type', 'application/json');
      if (isAuthHeaderNeeded) {
        request.headers.set('Authorization', 'Bearer $token');
      }
      if (isAuthHeaderNeeded) {
        request.headers.set('Accept', 'application/x-www-form-urlencoded');
      }
      request.add(utf8.encode(jsonEncode(data)));
      final response = await request.close();
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        final responseBody = await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        return null;
      }
    } finally {
      httpClient.close();
    }
  }

  Future<String?> delete({
    required String api,
    bool isAuthHeaderNeeded = false,
  }) async {
    final token = isAuthHeaderNeeded
        ? await UserStorage.load(key: StorageKey.token)
        : null;
    final httpClient = HttpClient();
    try {
      final url = Uri.https(_baseUrl, api);
      final request = await httpClient.deleteUrl(url);
      if (isAuthHeaderNeeded) {
        request.headers.set(
          'Authorization',
          'Bearer $token',
        );
      }
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode == HttpStatus.noContent ||
          response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        return null;
      }
    } finally {
      httpClient.close();
    }
  }

  static Map<String, dynamic> paramEmpty() => const <String, dynamic>{};
  static Map<String, dynamic> paramGetBookings({required String type}) =>
      <String, dynamic>{
        'type': type,
      };

  static Map<String, dynamic> paramGetMastersFreeTime(
          {required String date, required String duration}) =>
      <String, dynamic>{
        'date': date,
        'duration': duration,
      };
}
