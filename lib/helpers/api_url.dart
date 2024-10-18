class ApiUrl {
  static const String baseUrl = 'https://responsi.webwizards.my.id/api';

  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listPenulis = '$baseUrl/buku/penulis';
  static const String createPenulis = '$baseUrl/buku/penulis';

  static String updatePenulis(int id) {
    return '$baseUrl/buku/penulis/$id/update';
  }

  static String showPenulis(int id) {
    return '$baseUrl/buku/penulis/$id';
  }

  static String deletePenulis(int id) {
    return '$baseUrl/buku/penulis/$id/delete';
  }
}
