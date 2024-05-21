/*
 * Copyright 2023 The TensorFlow Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *             http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:developer';
import 'dart:io';
import 'package:deteksi_kue/router_mixin.dart';
import 'package:deteksi_kue/ui/button.dart';
import 'package:deteksi_kue/ui/katalog_kue.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import '../helper/image_classification_helper.dart';

class DeteksiKue extends StatefulWidget {
  const DeteksiKue({super.key});

  @override
  State<DeteksiKue> createState() => _DeteksiKueState();
}

class _DeteksiKueState extends State<DeteksiKue> with RouterMixin {
  ImageClassificationHelper? imageClassificationHelper;
  final imagePicker = ImagePicker();
  String? imagePath;

  var title = '';
  var percent = '';

  @override
  void initState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
    super.initState();
  }

  // Clean old results when press some take picture button
  void cleanResult() {
    imagePath = null;
    setState(() {});
  }

  // Process picked image
  Future<void> processImage() async {
    if (imagePath != null) {
      // Read image bytes from file
      final imageData = File(imagePath!).readAsBytesSync();

      // Decode image using package:image/image.dart (https://pub.dev/image)
      setState(() {});
      final classification = await imageClassificationHelper
          ?.inferenceImage(img.decodeImage(imageData)!);

      final result = classification?.entries.toList();

      result?.sort(
        (a, b) => b.value.compareTo(a.value),
      );

      title = result?.first.key ?? "-";
      // percent = ( * 100).toStringAsExponential(2);

      double decimalNumber = (result?.first.value ?? 0);
      double percentage = decimalNumber * 100;

      // Formatting to 2 decimal places
      percent = percentage.toStringAsFixed(2);

      log(result.toString(), name: "result");
      log(classification?.toString() ?? "dasdasd", name: "result");
      setState(() {});
    }
  }

  @override
  void dispose() {
    imageClassificationHelper?.close();
    super.dispose();
  }

  camera() async {
    cleanResult();
    final result = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    imagePath = result?.path;
    setState(() {});
    await processImage();
  }

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
          imagePath == null
              ? SizedBox(
                  height: size.height * 0.4,
                  child: const Placeholder(),
                )
              : Image.file(
                  File(imagePath!),
                  height: size.height * 0.4,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
          const Gap(40),
          Deteksidescripsi(
            isImageNotNull: imagePath != null,
            percent: percent,
            title: title,
          ),
          const Gap(40),
          Button(
            icon: Icons.camera_alt_rounded,
            text: "Ambil Gambar",
            onPressed: () async {
              await camera();
            },
          ),
          const Gap(20),
          if (imagePath != null)
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
  final bool isImageNotNull;
  final String percent;
  final String title;
  const Deteksidescripsi({
    super.key,
    required this.isImageNotNull,
    required this.percent,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            "Onde-Onde",
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: isImageNotNull
                  ? const Color.fromARGB(255, 155, 219, 90)
                  : Colors.transparent,
            ),
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
            "$percent%",
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: isImageNotNull
                  ? const Color.fromARGB(255, 155, 219, 90)
                  : Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
