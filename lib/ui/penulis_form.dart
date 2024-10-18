import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_buku/bloc/penulis_bloc.dart';
import 'package:aplikasi_manajemen_buku/model/penulis.dart';
import 'package:aplikasi_manajemen_buku/ui/penulis_page.dart';
import 'package:aplikasi_manajemen_buku/widget/warning_dialog.dart';

class PenulisForm extends StatefulWidget {
  final Penulis? penulis;

  const PenulisForm({super.key, this.penulis});

  @override
  _PenulisFormState createState() => _PenulisFormState();
}

class _PenulisFormState extends State<PenulisForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _judul = "Tambah Penulis";
  String _tombolSubmit = "Simpan";

  final _authorNameController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _birthYearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isUpdate();
  }

  @override
  void dispose() {
    _authorNameController.dispose();
    _nationalityController.dispose();
    _birthYearController.dispose();
    super.dispose();
  }

  void _isUpdate() {
    if (widget.penulis != null) {
      setState(() {
        _judul = "Ubah Penulis";
        _tombolSubmit = "Ubah";
        _authorNameController.text = widget.penulis!.authorName ?? '';
        _nationalityController.text = widget.penulis!.nationality ?? '';
        _birthYearController.text = widget.penulis!.birthYear.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _judul,
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
      ),
      body: Container(
        height: screenHeight,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _authorNameTextField(),
                  const SizedBox(height: 15),
                  _nationalityTextField(),
                  const SizedBox(height: 15),
                  _birthYearTextField(),
                  const SizedBox(height: 30),
                  _buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _authorNameTextField() {
    return _buildTextField(
      label: "Nama Penulis",
      controller: _authorNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama penulis harus diisi";
        }
        return null;
      },
    );
  }

  Widget _nationalityTextField() {
    return _buildTextField(
      label: "Kebangsaan",
      controller: _nationalityController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kebangsaan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _birthYearTextField() {
    return _buildTextField(
      label: "Tahun Lahir",
      controller: _birthYearController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tahun Lahir harus diisi";
        }
        if (int.tryParse(value) == null) {
          return "Tahun Lahir harus berupa angka";
        }
        return null;
      },
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: 'Verdana', color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.black12,
      ),
      style: const TextStyle(fontFamily: 'Verdana', color: Colors.white),
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              _tombolSubmit,
              style: const TextStyle(
                fontFamily: 'Verdana',
                fontSize: 14,
              ),
            ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (!_isLoading) {
            if (widget.penulis != null) {
              _ubahPenulis();
            } else {
              _simpanPenulis();
            }
          }
        }
      },
    );
  }

  Future<void> _simpanPenulis() async {
    // Pastikan loading aktif
    setState(() {
      _isLoading = true;
    });

    // Validasi input secara manual sebelum membuat objek Penulis
    if (_authorNameController.text.trim().isEmpty) {
      _showWarningDialog("Nama penulis tidak boleh kosong.");
      setState(() {
        _isLoading = false;
      });
      return; // Berhenti eksekusi jika validasi gagal
    }

    if (_nationalityController.text.trim().isEmpty) {
      _showWarningDialog("Kebangsaan tidak boleh kosong.");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (_birthYearController.text.trim().isEmpty ||
        int.tryParse(_birthYearController.text) == null) {
      _showWarningDialog(
          "Tahun Lahir harus berupa angka dan tidak boleh kosong.");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Buat objek Penulis baru dengan data valid
    Penulis newPenulis = Penulis(
      authorName: _authorNameController.text.trim(),
      nationality: _nationalityController.text.trim(),
      birthYear: int.parse(_birthYearController.text.trim()),
    );

    try {
      print("Memanggil API untuk menambahkan penulis...");

      // Panggil API melalui PenulisBloc
      bool status = await PenulisBloc.addPenulis(penulis: newPenulis);
      print("Status Penyimpanan: $status");

      if (status) {
        // Jika berhasil, navigasi ke halaman PenulisPage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PenulisPage()),
        );
      } else {
        // Tampilkan pesan jika gagal menyimpan
        _showWarningDialog("Gagal menyimpan data penulis. Cek input Anda.");
      }
    } catch (e) {
      // Tangani error dan tampilkan dialog peringatan
      _showWarningDialog("Error: ${e.toString()}");
    } finally {
      // Pastikan loading berhenti
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _ubahPenulis() async {
    setState(() {
      _isLoading = true;
    });

    Penulis updatedPenulis = Penulis(
      id: widget.penulis!.id,
      authorName: _authorNameController.text,
      nationality: _nationalityController.text,
      birthYear: int.parse(_birthYearController.text),
    );

    try {
      bool status = await PenulisBloc.updatePenulis(penulis: updatedPenulis);
      if (status) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PenulisPage()),
        );
      } else {
        _showWarningDialog("Gagal mengubah data penulis.");
      }
    } catch (e) {
      _showWarningDialog("Error: ${e.toString()}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WarningDialog(description: message),
    );
  }
}
