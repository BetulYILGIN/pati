import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pati_check/screens/home_page.dart';
import 'package:pati_check/screens/login_page.dart';
import 'package:pati_check/screens/account_type_page.dart';
import 'package:pati_check/screens/pati_membership_page.dart';
import 'package:pati_check/screens/clinic_membership_page.dart';
import 'package:pati_check/screens/clinic_details_page.dart';
import 'package:pati_check/screens/patitagram_page.dart';
import 'package:pati_check/screens/forgot_password_page.dart'; // Bu da vardı
import 'package:pati_check/screens/blog_page.dart';
import 'package:pati_check/screens/blog_detail_page.dart'; // BlogPost modelini içeriyor
import 'package:pati_check/screens/profile_page.dart';

void main() {
  runApp(const PatiCheckApp());
}

class PatiCheckApp extends StatelessWidget {
  const PatiCheckApp({super.key}); // super.key eklendi

  @override      
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pati-Check',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),  
      ),
      // home: HomePage(), // home yerine initialRoute kullanılacak
      initialRoute: '/', // Ana sayfa için '/'
      routes: {
        '/': (context) => const HomePage(), // Added const
        '/login': (context) => const LoginPage(), // Added const
        '/forgot_password': (context) => const ForgotPasswordPage(), // Added const
        '/account_type': (context) => const AccountTypePage(), // Added const
        '/register_pati': (context) => const PatiMembershipPage(), // Added const
        '/register_clinic': (context) => const ClinicMembershipPage(), // Added const
        '/clinic_details': (context) => const ClinicDetailsPage(), // Added const
        '/patitagram': (context) => const PatitagramPage(), // Added const
        '/blog': (context) => const BlogPage(), // Added const
        // BlogDetailPage için dinamik route gerekebilir (post argümanı için),
        // ama şimdilik BlogPage içinden MaterialPageRoute ile çağrılıyor, bu yeterli olabilir.
        // '/blog_detail': (context) => BlogDetailPage(), // Example if needed directly, but needs args
        '/profile': (context) => const ProfilePage(), // Added const
        // Varsa diğer sayfalar için de route'lar eklenebilir.
      },
    );
  }
}
