import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_manajemen_buku/model/login.dart';

class LoginBloc {
  /// Fungsi untuk login dengan email dan password.
  static Future<Login> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
        'https://responsi.webwizards.my.id/api/login'); // Mengambil URL login

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        var jsonObj = jsonDecode(response.body);
        return Login.fromJson(jsonObj); // Parsing respons ke model Login
      } else {
        throw Exception('Login gagal: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      rethrow; // Lempar ulang error agar bisa ditangani di UI
    }
  }
}
