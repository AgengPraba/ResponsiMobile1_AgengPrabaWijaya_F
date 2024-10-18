import 'package:flutter/material.dart';

class Consts {
  Consts._();
  static const double padding =
      24.0; // Ukuran padding diperbesar agar lebih rapi
  static const double avatarRadius = 48.0; // Ukuran avatar sedikit lebih kecil
}

class SuccessDialog extends StatelessWidget {
  final String? description;
  final VoidCallback? okClick;

  const SuccessDialog({super.key, this.description, this.okClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 10.0, // Menambahkan elevasi untuk bayangan lebih tajam
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(Consts.padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0), // Border lebih bulat
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Bayangan lebih soft
                blurRadius: 20.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 48.0), // Untuk memberi ruang bagi ikon
              const Text(
                "SUKSES",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                description ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (okClick != null) okClick!();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -Consts.avatarRadius,
          left: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: Consts.avatarRadius,
            child: const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 48.0,
            ),
          ),
        ),
      ],
    );
  }
}
