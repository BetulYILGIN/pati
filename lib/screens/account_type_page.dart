import 'package:flutter/material.dart';
import 'package:pati_check/screens/pati_membership_page.dart'; // Added import
import 'package:pati_check/screens/clinic_membership_page.dart'; // Added import

class AccountTypePage extends StatelessWidget {
  const AccountTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Geri dönüş
          },
        ),
        title: const Text(
          'Hesap Türü',
          style: TextStyle(color: Colors.black),
        ),
      
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/sayfa1.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Hesap Türünü Seçin',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            const SizedBox(height: 30), 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register_pati');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/pati.png',
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.pets, size: 40, color: Colors.black54);
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Pati üyesi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register_clinic');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/klinik.png',
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.local_hospital, size: 40, color: Colors.black54);
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Klinik üyesi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
