import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_buku/helpers/user_info.dart';
import 'package:aplikasi_manajemen_buku/ui/login_page.dart';
import 'package:aplikasi_manajemen_buku/ui/penulis_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const PenulisPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Buku',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Aplikasi Manajemen Buku',
//       debugShowCheckedModeBanner: false,
//       home: PenulisPage(), // Langsung ke PenulisPage untuk debugging
//     );
//   }
// }
