import 'package:flutter/material.dart'; // Added import

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key}); // Added constructor with key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/unuttum.png', width: 150, height: 150),
              const SizedBox(height: 20), // Added const
              const Text( // Added const
                'Şifre Sıfırlama',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10), // Added const
              const TextField( // Added const for TextField itself, assuming no controller for now
                decoration: InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 120, 55, 77), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Added const
              ElevatedButton(
                onPressed: () {
                  // Kod gönderme işlemleri
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
                      'Kod Gönder',
                      style: TextStyle(color: Colors.black),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
