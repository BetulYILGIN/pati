import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 146, 176),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 146, 176),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              'Patilerinizin sağlığında dijital destek',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: const Color.fromARGB(255, 245, 166, 196),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Transform.rotate(
                  angle: 0.785398,
                  child: Image.asset(
                    'assets/images/walk.gif',
                    width: 80,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
