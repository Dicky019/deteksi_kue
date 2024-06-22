import 'package:deteksi_kue/helper/prediksi_kue_service.dart';
import 'package:deteksi_kue/model/prediksi_kue.dart';
import 'package:deteksi_kue/router_mixin.dart';
import 'package:deteksi_kue/ui/button.dart';
import 'package:deteksi_kue/ui/katalog_kue.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class DeteksiKue extends StatefulWidget {
  const DeteksiKue({super.key});

  @override
  State<DeteksiKue> createState() => _DeteksiKueState();
}

class _DeteksiKueState extends State<DeteksiKue> with RouterMixin {
  final prediksiKueService = PrediksiKueService();
  PrediksiKueModel? presiksiKue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB3E283),
        title: const Text(
          "Deteksi Kue",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          presiksiKue?.image == null
              ? SizedBox(
                  height: size.height * 0.4,
                  child: const Placeholder(),
                )
              : Image.file(
                  presiksiKue!.image,
                  height: size.height * 0.4,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
          const Gap(40),
          Deteksidescripsi(
            presiksiKue: presiksiKue,
          ),
          const Gap(40),
          Row(
            children: [
              const Gap(12),
              Expanded(
                child: Button(
                  icon: Icons.camera_alt_rounded,
                  text: "Ambil Gambar",
                  onPressed: () async {
                    presiksiKue = await prediksiKueService
                        .predictImage(ImageSource.camera);

                    setState(() {});
                  },
                ),
              ),
              const Gap(12),
              Expanded(
                child: Button(
                  icon: Icons.image_rounded,
                  text: "Ambil Galery",
                  onPressed: () async {
                    presiksiKue = await prediksiKueService
                        .predictImage(ImageSource.gallery);

                    setState(() {});
                  },
                ),
              ),
              const Gap(12),
            ],
          ),
          const Gap(20),
          if (presiksiKue?.image != null)
            Button(
              icon: Icons.library_books,
              text: "Katalog Kue Tradisional Bugis",
              onPressed: () {
                navigation(context, (context) => const KatalogKue());
              },
            ),
        ],
      ),
    );
  }
}

class Deteksidescripsi extends StatelessWidget {
  final PrediksiKueModel? presiksiKue;
  const Deteksidescripsi({
    super.key,
    this.presiksiKue,
  });

  @override
  Widget build(BuildContext context) {
    final isPresiksiKue = presiksiKue != null;
    final color = isPresiksiKue
        ? const Color.fromARGB(255, 155, 219, 90)
        : Colors.transparent;
    final predictedClass = isPresiksiKue ? presiksiKue!.predictedClass : "...";
    final confidenceScore =
        isPresiksiKue ? presiksiKue!.confidenceScore : "...";
    final predicted = isPresiksiKue ? presiksiKue!.predicted : true;

    return Column(
      children: !predicted
          ? [
              Center(
                child: Text(
                  "Diklasifikasikan Sebagai Bukan Kue ",
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: color,
                  ),
                ),
              ),
            ]
          : [
              Center(
                child: Text(
                  "Diklasifikasikan sebagai : ",
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              Center(
                child: Text(
                  predictedClass,
                  style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.bold, fontSize: 24, color: color),
                ),
              ),
              Center(
                child: Text(
                  "Tingkat Keyakinan Model : ",
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              Center(
                child: Text(
                  confidenceScore,
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: color,
                  ),
                ),
              ),
            ],
    );
  }
}
