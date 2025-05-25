import 'package:flutter/material.dart';
import 'package:pati_check/screens/pati_membership_page.dart'; // Added import
import 'package:pati_check/screens/clinic_membership_page.dart'; // Added import

class AccountTypePage extends StatelessWidget {
  const AccountTypePage({super.key}); // Added key to constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50), // Added const
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Added const
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/sayfa1.png', // This will cause error if not in pubspec
                    fit: BoxFit.contain,
                     errorBuilder: (context, error, stackTrace) { // Added errorBuilder for robustness
                      return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Added const
            const Text( // Added const
              'Hesap Türünü Seçin',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30), // Added const
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72.0), // Added const
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    // PatiMembershipPage henüz taşınmadı
                    MaterialPageRoute(builder: (context) => PatiMembershipPage()),
                  );
                },
                style: ElevatedButton.styleFrom( // Moved style before child
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176), // Added const
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Added const
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/pati.png', // This will cause error if not in pubspec
                      width: 60,
                      height: 60,
                       errorBuilder: (context, error, stackTrace) { // Added errorBuilder
                        return const Icon(Icons.pets, size: 40, color: Colors.black54);
                      },
                    ),
                    const SizedBox(width: 10), // Added const
                    const Text( // Added const
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
            const SizedBox(height: 50), // Added const
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72.0), // Added const
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    // ClinicMembershipPage henüz taşınmadı
                    MaterialPageRoute(builder: (context) => ClinicMembershipPage()),
                  );
                },
                style: ElevatedButton.styleFrom( // Moved style before child
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176), // Added const
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Added const
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/klinik.png', // This will cause error if not in pubspec
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) { // Added errorBuilder
                        return const Icon(Icons.local_hospital, size: 40, color: Colors.black54);
                      },
                    ),
                    const SizedBox(width: 10), // Added const
                    const Text( // Added const
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
            const SizedBox(height: 100), // Added const
          ],
        ),
      ),
    );
  }
}

// Placeholders for PatiMembershipPage and ClinicMembershipPage to allow AccountTypePage to compile
// Removed placeholder PatiMembershipPage as it's now imported
// class PatiMembershipPage extends StatelessWidget {
//   const PatiMembershipPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text("Pati Membership Placeholder")));
//   }
// }

// Removed placeholder ClinicMembershipPage as it's now imported
// class ClinicMembershipPage extends StatelessWidget {
//   const ClinicMembershipPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text("Clinic Membership Placeholder")));
//   }
// }
