import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TentangApp extends StatelessWidget {
  const TentangApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffB3E283),
          title: const Text(
            "Tentang",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              const Text(
                'Deskripsi Singkat Aplikasi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              const Text(
                'Aplikasi Kue Tradisional Bugis merangkul tujuan pelestarian dan pengenalan warisan kuliner Bugis melalui fitur-fitur inovatifnya. Dengan katalog yang komprehensif, pengguna dapat menjelajahi kue-kue tradisional dengan mudah memberikan pengalaman visual mendalam. Deteksi gambar kue memudahkan identifikasi, dan fitur berbagi resep membangun komunitas yang peduli akan melestarikan resep-resep kue tradisional Bugis. Aplikasi ini tidak hanya menghidupkan kembali cita rasa tradisional, tetapi juga merangkul partisipasi aktif pengguna dalam menjaga keberlanjutan warisan kuliner Bugis.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
              const Gap(24),
              const Text(
                'Teknologi yang digunakan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Image.network(
                      'https://avatars.githubusercontent.com/u/15658638?s=200&v=4',
                    ),
                    const Gap(8),
                    Image.network(
                      'https://avatars.githubusercontent.com/u/14101776?s=200&v=4',
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
