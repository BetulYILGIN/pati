import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key}); // Added super.key

  @override
  Widget build(BuildContext context) {
    // Örnek kullanıcı verileri (bu veriler normalde bir modelden veya servisten gelir)
    const String userName = 'Pati Sever'; // Added const
    const String userEmail = 'patisever@example.com'; // Added const
    const String profileImageUrl = 'assets/images/17.png'; // Placeholder image path
    const int postCount = 10; // Added const
    const int followerCount = 150; // Added const
    const int followingCount = 75; // Added const

    // Gönderi resimleri listesi (14.png - 20.png)
    final List<String> patitagramImages = [
      'assets/images/14.png',
      'assets/images/15.png',
      'assets/images/16.png',
      'assets/images/17.png',
      'assets/images/18.png',
      'assets/images/19.png',
      'assets/images/1.png',
      'assets/images/2.png',
      'assets/images/3.png',
      'assets/images/4.png',
    ];

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
              backgroundImage: const AssetImage(profileImageUrl),
              onBackgroundImageError: (exception, stackTrace) {
                print('Error loading profile image: $exception');
              },
            ),
            const SizedBox(height: 10),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildStatColumn('Gönderiler', postCount),
                _buildStatColumn('Takipçi', followerCount),
                _buildStatColumn('Takip Edilen', followingCount),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: patitagramImages.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    patitagramImages[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
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
