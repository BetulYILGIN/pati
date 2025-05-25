import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pati_check/screens/login_page.dart'; // Added import for LoginPage

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pati-Check Home', style: GoogleFonts.poppins()),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Pati-Check!',
              style: GoogleFonts.poppins(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // This will cause an error until LoginPage is created and imported.
                // The task explicitly states to leave this as is.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Go to Login Page (Not Yet Implemented)', style: GoogleFonts.poppins()),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for LoginPage to avoid immediate analysis errors in some environments.
// This class definition will be removed when login_page.dart is created.
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text("Login Placeholder")));
//   }
// }
