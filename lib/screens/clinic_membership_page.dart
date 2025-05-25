import 'package:flutter/material.dart';
import 'package:pati_check/screens/clinic_details_page.dart'; // Corrected project name

class ClinicMembershipPage extends StatefulWidget {
  const ClinicMembershipPage({super.key}); // Added super.key

  @override
  _ClinicMembershipPageState createState() => _ClinicMembershipPageState();
}

class _ClinicMembershipPageState extends State<ClinicMembershipPage> {
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController authorizedPersonController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() { // Added dispose method for controllers
    clinicNameController.dispose();
    taxNumberController.dispose();
    authorizedPersonController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0), // Orijinalde 72.0
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Added const
              Center(
                child: Image.asset(
                  'assets/images/klinik.png', // This will cause error if not in pubspec
                  width: 250,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) { // Added errorBuilder for robustness
                    return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(height: 20), // Added const
              const Center( // Added const
                child: Text(
                  'Yeni Klinik Üyeliği Oluşturun',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10), // Added const
              const Center( // Added const
                child: Text('Lütfen bilgilerinizi giriniz.'),
              ),
              const SizedBox(height: 20), // Added const

              TextField(
                controller: clinicNameController,
                decoration: const InputDecoration( // Added const
                  labelText: 'Klinik Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const

              TextField(
                controller: taxNumberController,
                decoration: const InputDecoration( // Added const
                  labelText: 'Vergi Numarası',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const

              TextField(
                controller: authorizedPersonController,
                decoration: const InputDecoration( // Added const
                  labelText: 'Yetkili Kişi Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration( // Added const
                  labelText: 'Parola',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const

              TextField(
                controller: emailController,
                decoration: const InputDecoration( // Added const
                  labelText: 'Mail Adresi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const
              ElevatedButton(
                onPressed: () {
                  // TODO: Add form validation and actual registration logic here
                  if (mounted) { // Good practice to check mounted
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => const ClinicDetailsPage()), // Added const
                     );
                  }
                },
                style: ElevatedButton.styleFrom( // Moved style before child
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: const EdgeInsets.symmetric(vertical: 15), // Added const
                  minimumSize: const Size(double.infinity, 50), // Added const
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text( // Added const
                  'Kayıt Ol',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
