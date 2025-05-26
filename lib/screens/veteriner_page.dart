import 'package:flutter/material.dart';
import 'dart:math';

class Veteriner {
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Veteriner({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

// Örnek veteriner listesi
final List<Veteriner> veterinerler = [
  Veteriner(
    name: 'Veteriner Klinik A',
    address: 'Adres A',
    latitude: 40.7128,
    longitude: -74.0060,
  ),
  Veteriner(
    name: 'Veteriner Klinik B',
    address: 'Adres B',
    latitude: 40.730610,
    longitude: -73.935242,
  ),
  Veteriner(
    name: 'Veteriner Klinik C',
    address: 'Adres C',
    latitude: 40.755,
    longitude: -73.98,
  ),
];

// Kullanıcının örnek sabit konumu (örnek: New York merkez)
const double userLat = 40.730610;
const double userLng = -73.935242;

// Mesafe hesaplamak için Haversine formülü
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371; // KM
  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
      sin(dLon / 2) * sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadius * c;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

class EnYakinVeterinerlerPage extends StatelessWidget {
  const EnYakinVeterinerlerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mesafeye göre sıralama
    final sortedVeterinerler = List<Veteriner>.from(veterinerler);
    sortedVeterinerler.sort((a, b) {
      double distA = calculateDistance(userLat, userLng, a.latitude, a.longitude);
      double distB = calculateDistance(userLat, userLng, b.latitude, b.longitude);
      return distA.compareTo(distB);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('En Yakın Veterinerler'),
        backgroundColor: Colors.pink[100],
      ),
      body: ListView.builder(
        itemCount: sortedVeterinerler.length,
        itemBuilder: (context, index) {
          final vet = sortedVeterinerler[index];
          final distance = calculateDistance(userLat, userLng, vet.latitude, vet.longitude);

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.pink),
              title: Text(vet.name),
              subtitle: Text('${vet.address}\n${distance.toStringAsFixed(2)} km uzaklıkta'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
