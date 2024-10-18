import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrasiBloc {
  static Future<void> registrasi(
      {required String nama,
      required String email,
      required String password}) async {
    final url = Uri.parse('https://responsi.webwizards.my.id/api/registrasi');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'nama': nama,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Registrasi berhasil');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Registrasi gagal: ${response.statusCode}');
    }
  }
}
