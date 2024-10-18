import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplikasi_manajemen_buku/bloc/penulis_bloc.dart';
import 'package:aplikasi_manajemen_buku/model/penulis.dart';
import 'package:aplikasi_manajemen_buku/ui/penulis_form.dart';
import 'package:aplikasi_manajemen_buku/ui/penulis_page.dart';
import 'package:aplikasi_manajemen_buku/widget/warning_dialog.dart';

class PenulisDetail extends StatelessWidget {
  final Penulis penulis;

  const PenulisDetail({super.key, required this.penulis});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          penulis.authorName ?? 'Detail Penulis',
          style: const TextStyle(fontFamily: 'Verdana', fontSize: 24),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PenulisForm(penulis: penulis),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth, // Pastikan mengambil seluruh lebar layar
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.lightBlueAccent,
              Colors.cyanAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Isi seluruh lebar layar
            children: [
              _buildText('Nama: ${penulis.authorName}', 20, FontWeight.bold),
              const SizedBox(height: 8.0),
              _buildText('Kewarganegaraan: ${penulis.nationality}', 16),
              const SizedBox(height: 8.0),
              _buildText('Tahun Lahir: ${penulis.birthYear}', 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text, double fontSize,
      [FontWeight fontWeight = FontWeight.normal]) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Verdana',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.white,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Konfirmasi Hapus',
          style: TextStyle(fontFamily: 'Verdana', color: Colors.white),
        ),
        content: const Text(
          'Apakah Anda yakin ingin menghapus penulis ini?',
          style: TextStyle(fontFamily: 'Verdana', color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(fontFamily: 'Verdana', color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {
              _deletePenulis(context);
            },
            child: const Text(
              'Hapus',
              style: TextStyle(fontFamily: 'Verdana', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _deletePenulis(BuildContext context) async {
    try {
      bool status = await PenulisBloc.deletePenulis(id: penulis.id!);
      if (status) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PenulisPage()),
          (route) => false,
        );
      } else {
        _showWarningDialog(context, 'Gagal menghapus data penulis.');
      }
    } catch (e) {
      _showWarningDialog(context, 'Error: ${e.toString()}');
    }
  }

  void _showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WarningDialog(description: message),
    );
  }
}
