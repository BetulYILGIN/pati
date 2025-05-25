import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // PatiCheckApp theme'de kullanılıyor
import 'package:pati_check/screens/home_page.dart'; // Proje adı pati_check olarak düzeltildi

void main() {
  runApp(const PatiCheckApp());
}

class PatiCheckApp extends StatelessWidget {
  const PatiCheckApp({super.key}); // Added key to constructor

  @override      
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pati-Check',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),  
      ),
      home: const HomePage(), // Burası artık screens/home_page.dart'tan gelecek
    );
  }
}
