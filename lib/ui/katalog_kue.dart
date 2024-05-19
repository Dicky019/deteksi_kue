import 'dart:developer';

import 'package:deteksi_kue/model/kue.dart';
import 'package:deteksi_kue/router_mixin.dart';
import 'package:deteksi_kue/ui/detail_kue.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final kues = Kues.faker(20);

class KatalogKue extends StatefulWidget {
  const KatalogKue({super.key});

  @override
  State<KatalogKue> createState() => _KatalogKueState();
}

class _KatalogKueState extends State<KatalogKue> with RouterMixin {
  late List<Kue> searchKues;
  final TextEditingController searchC = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchKues = kues.values.toList();
    searchC.addListener(search);
  }

  @override
  void dispose() {
    searchC.removeListener(search);
    searchC.dispose();
    super.dispose();
  }

  void search() {
    setState(() {
      searchKues = kues.values
          .where((kue) =>
              kue.title.toLowerCase().contains(searchC.text.toLowerCase()))
          .toList();
    });

    log('Found ${searchKues.length} results');
    log(searchKues.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB3E283),
        title: const Text(
          "Katalog Kue",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Cari Kue...',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: IconButton(
                          onPressed: search,
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Gap(8),
                itemCount: searchKues.length,
                itemBuilder: (context, index) {
                  final kue = searchKues[index];
                  return InkWell(
                    onTap: () =>
                        navigation(context, (context) => DetailKue(kue: kue)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            kue.image,
                            height: 72,
                            width: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          kue.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          kue.minides,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
