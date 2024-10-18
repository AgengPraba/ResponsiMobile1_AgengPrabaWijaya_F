import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_buku/bloc/logout_bloc.dart';
import 'package:aplikasi_manajemen_buku/bloc/penulis_bloc.dart';
import 'package:aplikasi_manajemen_buku/model/penulis.dart';
import 'package:aplikasi_manajemen_buku/ui/login_page.dart';
import 'package:aplikasi_manajemen_buku/ui/penulis_detail.dart';
import 'package:aplikasi_manajemen_buku/ui/penulis_form.dart';

class PenulisPage extends StatefulWidget {
  const PenulisPage({super.key});

  @override
  _PenulisPageState createState() => _PenulisPageState();
}

class _PenulisPageState extends State<PenulisPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Penulis',
          style: TextStyle(fontFamily: 'Verdana', fontSize: 24),
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
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(
                Icons.add,
                size: 26.0,
                color: Colors.white, // Warna putih untuk ikon tambah
              ),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PenulisForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.indigo,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.red,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              const DrawerHeader(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontFamily: 'Verdana',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.white),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Verdana',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        await LogoutBloc.logout().then((value) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
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
        child: FutureBuilder<List>(
          future: PenulisBloc.getPenuliss(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontFamily: 'Verdana', fontSize: 16),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak ada penulis tersedia.',
                  style: TextStyle(fontFamily: 'Verdana', fontSize: 16),
                ),
              );
            }
            return ListPenulis(list: snapshot.data! as List<Penulis>);
          },
        ),
      ),
    );
  }
}

class ListPenulis extends StatelessWidget {
  final List<Penulis> list;

  const ListPenulis({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return ItemPenulis(penulis: list[i]);
      },
    );
  }
}

class ItemPenulis extends StatelessWidget {
  final Penulis penulis;

  const ItemPenulis({super.key, required this.penulis});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PenulisDetail(penulis: penulis),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 4,
        child: ListTile(
          title: Text(
            penulis.authorName ?? 'Unknown Author',
            style: const TextStyle(
              fontFamily: 'Verdana',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Lahir: ${penulis.birthYear ?? 'N/A'}',
            style: const TextStyle(fontFamily: 'Verdana', fontSize: 16),
          ),
        ),
      ),
    );
  }
}
