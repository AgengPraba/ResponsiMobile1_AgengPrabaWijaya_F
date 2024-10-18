import 'dart:convert';
import 'package:aplikasi_manajemen_buku/helpers/api.dart';
import 'package:aplikasi_manajemen_buku/model/penulis.dart';

class PenulisBloc {
  static const String baseUrl = 'http://103.196.155.42/api/buku/penulis';

  // Mendapatkan list semua penulis
  static Future<List<Penulis>> getPenuliss() async {
    try {
      var response = await Api().get(baseUrl);

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);

        if (jsonObj.containsKey('data')) {
          List<dynamic> listPenulis = jsonObj['data'];
          List<Penulis> penuliss =
              listPenulis.map((e) => Penulis.fromJson(e)).toList();
          return penuliss;
        } else {
          throw Exception('Respons API tidak valid: Key data tidak ditemukan.');
        }
      } else {
        throw Exception(
            'Gagal mendapatkan data penulis. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error saat mendapatkan data penulis: $e");
      rethrow; // Tangani kesalahan di level UI
    }
  }

  // Menambahkan penulis baru
  static Future<bool> addPenulis({required Penulis penulis}) async {
    var body = jsonEncode({
      "author_name": penulis.authorName,
      "nationality": penulis.nationality,
      "birth_year": penulis.birthYear.toString(),
    });

    try {
      var response = await Api().post(baseUrl, body, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        return jsonObj['status'] == true;
      } else {
        throw Exception(
            'Gagal menambahkan penulis. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error saat menambahkan penulis: $e");
      return false;
    }
  }

  // Memperbarui penulis
  static Future<bool> updatePenulis({required Penulis penulis}) async {
    String url = '$baseUrl/${penulis.id}/update';
    var body = jsonEncode({
      "author_name": penulis.authorName,
      "nationality": penulis.nationality,
      "birth_year": penulis.birthYear.toString(),
    });

    try {
      var response = await Api().put(url, body, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        return jsonObj['status'] == true;
      } else {
        throw Exception(
            'Gagal memperbarui penulis. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error saat memperbarui penulis: $e");
      return false;
    }
  }

  // Menghapus penulis
  static Future<bool> deletePenulis({required int id}) async {
    String url = '$baseUrl/$id/delete';

    try {
      var response = await Api().delete(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        return jsonObj['status'] == true;
      } else {
        throw Exception(
            'Gagal menghapus penulis. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error saat menghapus penulis: $e");
      return false;
    }
  }
}
