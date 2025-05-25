import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // CarouselSlider için
import 'package:pati_check/screens/profile_page.dart'; // Added import for ProfilePage
import 'package:pati_check/screens/blog_page.dart'; // Added import for BlogPage

final List<String> images = [
  'assets/images/patitagram1.png',
  'assets/images/patitagram2.png',
  'assets/images/patitagram3.png',
  'assets/images/patitagram4.png',
];

class PatitagramPage extends StatelessWidget {
  const PatitagramPage({super.key}); // Added super.key

  Widget _buildSquareButton(BuildContext context, String imagePath, String label, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.all(4.0), // Added const
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // Added const
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 60, // Adjusted size for better fit if needed
                height: 60,
                errorBuilder: (context, error, stackTrace) { // Added errorBuilder
                  return const Icon(Icons.error, size: 50, color: Colors.red);
                },
              ),
              const SizedBox(height: 8), // Added const
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Patitagram'), // Added const
        backgroundColor: Colors.pink[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: images.map((item) => Container(
                margin: const EdgeInsets.all(5.0), // Added const
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)), // Added const
                  child: Image.asset(
                    item, 
                    fit: BoxFit.cover, 
                    width: 1000.0,
                    errorBuilder: (context, error, stackTrace) { // Added errorBuilder
                      return Container(color: Colors.grey, child: const Icon(Icons.image_not_supported, size: 50));
                    },
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 20), // Added const
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Added const
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSquareButton(context, 'assets/images/profil.png', 'Profilim', () {
                    // ProfilePage'e navigasyon
                    Navigator.pushNamed(context, '/profile');
                  }),
                  _buildSquareButton(context, 'assets/images/blog.png', 'Blog', () {
                    // BlogPage'e navigasyon
                    Navigator.pushNamed(context, '/blog');
                  }),
                ],
              ),
            ),
            const SizedBox(height: 10), // Added const
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Added const
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSquareButton(context, 'assets/images/patiilan.png', 'Pati İlanları', () {
                    // Pati İlanları sayfasına navigasyon
                  }),
                  _buildSquareButton(context, 'assets/images/esbul.png', 'Eş Bul', () {
                    // Eş Bul sayfasına navigasyon
                  }),
                ],
              ),
            ),
            const SizedBox(height: 10), // Added const
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Added const
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSquareButton(context, 'assets/images/kayip.png', 'Kayıp İlanı', () {
                    // Kayıp İlanı sayfasına navigasyon
                  }),
                  _buildSquareButton(context, 'assets/images/sorusor.png', 'Soru Sor', () {
                    // Soru Sor sayfasına navigasyon
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20), // Added const
          ],
        ),
      ),
    );
  }
}

// Placeholders for pages that PatitagramPage might navigate to.
// These will be replaced by actual page files later or when those features are implemented.
// class ProfilePage extends StatelessWidget {
// Removed placeholder ProfilePage class
// Removed placeholder BlogPage class
