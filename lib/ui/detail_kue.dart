import 'package:deteksi_kue/model/kue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DetailKue extends StatelessWidget {
  final Kue kue;
  const DetailKue({super.key, required this.kue});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB3E283),
        title: Text(
          kue.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.network(
            kue.image,
            height: 241,
            width: size.width,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Markdown(
              data: kue.markdownData,
            ),
          ),
        ],
      ),
    );
  }
}
