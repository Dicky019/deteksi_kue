import 'package:deteksi_kue/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.lightGreen,
    );
    return MaterialApp(
      title: 'Deteksi Kue',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Home(),
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 3)
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 40
    ..boxShadow = [
      BoxShadow(
        color: Colors.lightGreen.shade100.withOpacity(0.2),
        spreadRadius: 3,
        blurRadius: 10,
        offset: const Offset(0, 1), // changes position of shadow
      ),
    ]
    ..progressColor = Colors.lightGreen
    ..backgroundColor = Colors.lightGreen.shade100
    ..indicatorColor = Colors.lightGreen.shade900
    ..textColor = Colors.black
    ..maskColor = Colors.lightGreen.shade100.withOpacity(0.3);
}
