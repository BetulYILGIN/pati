import 'package:flutter/material.dart';
// import 'patitagram_page.dart'; // PatitagramPage henüz taşınmadığı için bu import şimdilik olmayacak.

class PatiMembershipPage extends StatelessWidget {
  const PatiMembershipPage({super.key}); // Added super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView( // Added SingleChildScrollView for potentially long content
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0), // Original padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Added const
              Center(
                child: Image.asset(
                  'assets/images/pati.png', // This will cause error if not in pubspec
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
                  'Pati Üyeliği Oluşturun',
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
              const TextField( // Added const, assuming no controller for now
                decoration: InputDecoration(
                  labelText: 'Ad Soyad',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const
              const TextField( // Added const, assuming no controller for now
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const
              const TextField( // Added const, assuming no controller for now
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Parola',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const
              const TextField( // Added const, assuming no controller for now
                decoration: InputDecoration(
                  labelText: 'Mail Adresi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const
              const TextField( // Added const, assuming no controller for now
                decoration: InputDecoration(
                  labelText: 'Telefon Numarası',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20), // Added const
              ElevatedButton(
                onPressed: () {
                  // Navigasyon PatitagramPage'e yapılacak.
                  // PatitagramPage henüz projeye eklenmediği için bu kod hata verecektir.
                  // Bu normaldir ve bir sonraki adımda düzeltilecektir.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatitagramPage()), // This will cause an error
                  );
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

// Placeholder for PatitagramPage to allow PatiMembershipPage to compile.
// This will be removed when PatitagramPage is properly created and imported.
class PatitagramPage extends StatelessWidget { // Added placeholder
  const PatitagramPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Patitagram Placeholder")));
  }
}
