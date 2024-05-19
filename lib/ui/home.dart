import 'package:deteksi_kue/router_mixin.dart';
import 'package:deteksi_kue/ui/button.dart';
import 'package:deteksi_kue/ui/deteksi_kue.dart';
import 'package:deteksi_kue/ui/katalog_kue.dart';
import 'package:deteksi_kue/ui/tentang_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class Home extends StatelessWidget with RouterMixin {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg.png",
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
          ),
          // Container(),
          SafeArea(
            child: Column(
              children: [
                const Gap(60),
                const Text(
                  'Aplikasi Pengenalan Kue Tradisional Bugis \nBerbasis Android',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(size.height * 0.22),
                Button(
                  icon: Icons.camera_alt_rounded,
                  text: "Deteksi Kue Tradisional",
                  onPressed: () {
                    navigation(context, (context) => const DeteksiKue());
                  },
                ),
                const Gap(20),
                Button(
                  icon: Icons.library_books,
                  text: "Katalog Kue Tradisional Bugis",
                  onPressed: () {
                    navigation(context, (context) => const KatalogKue());
                  },
                ),
                const Gap(20),
                Button(
                  icon: Icons.info,
                  text: "Tentang Aplikasi",
                  onPressed: () {
                    navigation(context, (context) => const TentangApp());
                  },
                ),
                const Gap(20),
                Button(
                  icon: Icons.logout,
                  text: "Keluar",
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
