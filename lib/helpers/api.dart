import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_manajemen_buku/helpers/user_info.dart';
import 'app_exception.dart';

class Api {
  // Fungsi POST dengan headers
  Future<http.Response> post(String url, dynamic data,
      {Map<String, String>? headers}) async {
    var token = await UserInfo().getToken();
    headers = headers ?? {}; // Inisialisasi jika null
    headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
        headers: headers,
      );
      _logResponse(response);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // Fungsi GET dengan headers
  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    var token = await UserInfo().getToken();
    headers = headers ?? {};
    headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      _logResponse(response);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // Fungsi PUT dengan headers
  Future<http.Response> put(String url, dynamic data,
      {Map<String, String>? headers}) async {
    var token = await UserInfo().getToken();
    headers = headers ?? {};
    headers[HttpHeaders.authorizationHeader] = "Bearer $token";
    headers[HttpHeaders.contentTypeHeader] = "application/json";

    try {
      final response = await http.put(
        Uri.parse(url),
        body: data,
        headers: headers,
      );
      _logResponse(response);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // Fungsi DELETE dengan headers
  Future<http.Response> delete(String url,
      {Map<String, String>? headers}) async {
    var token = await UserInfo().getToken();
    headers = headers ?? {};
    headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      _logResponse(response);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // Fungsi logging respons untuk debugging
  void _logResponse(http.Response response) {
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
  }

  // Fungsi untuk menangani error berdasarkan status code
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communicating with server. Status Code: ${response.statusCode}');
    }
  }
}
