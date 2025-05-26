import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pati_check/screens/reminder_page.dart';
import 'package:pati_check/screens/veteriner_page.dart';

final List<String> images = [
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
  'assets/images/4.png',
];

class PatitagramPage extends StatelessWidget {
  const PatitagramPage({super.key});

  Widget _buildSquareButton(BuildContext context, IconData iconData, String label, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 50, color: Colors.pink[300]),
              const SizedBox(height: 8),
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
        title: const Text('Patitagram'),
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
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: 1000.0,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSquareButton(context, Icons.alarm_add, 'Hatırlatma Ekle', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ReminderPage()),);
                  }),
                  _buildSquareButton(context, Icons.help_outline, 'Size Nasıl Yardımcı Olabilirim?', () {

                  }),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSquareButton(context, Icons.pets, 'Patitagram', () {
                    Navigator.pushNamed(context, '/profile');
                  }),
                  _buildSquareButton(context, Icons.local_hospital, 'En Yakın Veteriner', () {
                    Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => const EnYakinVeterinerlerPage()),
);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSquareButton(context, Icons.account_circle, 'Pati Profili', () {
                    
                  }),
                  _buildSquareButton(context, Icons.article, 'Blog Sayfası', () {
                    Navigator.pushNamed(context, '/blog');
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
