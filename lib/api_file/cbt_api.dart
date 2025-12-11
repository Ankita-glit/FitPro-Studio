import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get_connect/connect.dart';

class CbtRequest extends GetConnect {
  final String url;
  final Map<String, dynamic>? data; // Make data optional

  CbtRequest({
    required this.url,
    this.data,  // data is now optional
  });

  Dio _dio() {
    return Dio(BaseOptions(
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
      followRedirects: true,
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        'X-Requested-With': 'XMLHttpRequest',
        "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST,OPTIONS,GET,DELETE,PATCH"
      },
    ));
  }

  void getRequest({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    beforeSend();
    _dio().get(url, queryParameters: data ?? {}).then((res) {
      if (res.statusCode == 200) {
        onSuccess(res.data);
      } else {
        onError("Error: ${res.statusCode}");
      }
    }).catchError((error) {
      onError(error);
    });
  }

  void postRequest({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    beforeSend();
    _dio()
        .post(url, data: json.encode(data) ?? {})
        .then((res) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        onSuccess(res.data);
      } else {
        onError("Error: ${res.statusCode}");
      }
    }).catchError((error) {
      onError(error);
    });
  }

  void patchRequest({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    beforeSend();
    _dio()
        .patch(url, data: json.encode(data) ?? {})
        .then((res) {
      if (res.statusCode == 200) {
        onSuccess(res.data);
      } else {
        onError("Error: ${res.statusCode}");
      }
    }).catchError((error) {
      onError(error);
    });
  }

  // DELETE request method with status code check
  void deleteRequest({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    beforeSend();
    _dio()
        .delete(url, data: json.encode(data) ?? {})
        .then((res) {
      if (res.statusCode == 200 || res.statusCode == 204) {
        onSuccess(res.data);
      } else {
        onError("Error: ${res.statusCode}");
      }
    }).catchError((error) {
      onError(error);
    });
  }
}
