import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key}); // Added super.key

  @override
  Widget build(BuildContext context) {
    // Örnek kullanıcı verileri (bu veriler normalde bir modelden veya servisten gelir)
    const String userName = 'Pati Sever'; // Added const
    const String userEmail = 'patisever@example.com'; // Added const
    const String profileImageUrl = 'assets/images/profil.png'; // Placeholder image path
    const int postCount = 15; // Added const
    const int followerCount = 150; // Added const
    const int followingCount = 75; // Added const

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Pati Profili'), // Added const
        backgroundColor: Colors.pink[100],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined), // Added const
            onPressed: () {
              // Profili düzenleme sayfasına navigasyon
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20), // Added const
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage(profileImageUrl), // Using AssetImage for local assets
              // child: profileImageUrl.isEmpty ? Icon(Icons.person, size: 60) : null, // Alternative if network image
               onBackgroundImageError: (exception, stackTrace) { // Added error handling for AssetImage
                print('Error loading profile image: $exception');
                // Optionally, show a placeholder icon if image fails to load
              },
            ),
            const SizedBox(height: 10), // Added const
            Text(
              userName,
              style: const TextStyle( // Added const
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userEmail,
              style: TextStyle( // Added const
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20), // Added const
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildStatColumn('Gönderiler', postCount),
                _buildStatColumn('Takipçi', followerCount),
                _buildStatColumn('Takip Edilen', followingCount),
              ],
            ),
            const SizedBox(height: 20), // Added const
            const Divider(), // Added const
            // Kullanıcının gönderilerini veya diğer profil bilgilerini listelemek için bir GridView veya ListView eklenebilir.
            // Örneğin:
            Padding(
              padding: const EdgeInsets.all(8.0), // Added const
              child: GridView.builder(
                shrinkWrap: true, // Önemli: SingleChildScrollView içinde GridView için
                physics: const NeverScrollableScrollPhysics(), // Kaydırmayı SingleChildScrollView'a bırak
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // Added const
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: 9, // Örnek gönderi sayısı
                itemBuilder: (context, index) {
                  return Image.asset(
                    'assets/images/patitagram${index % 4 + 1}.png', // Örnek gönderi resimleri
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) { // Added errorBuilder
                      return Container(color: Colors.grey[300], child: const Icon(Icons.image_not_supported));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildStatColumn(String label, int number) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          number.toString(),
          style: const TextStyle( // Added const
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4), // Added const
          child: Text(
            label,
            style: const TextStyle( // Added const
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
