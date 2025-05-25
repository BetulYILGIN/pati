import 'package:flutter/material.dart';
import 'package:pati_check/screens/blog_detail_page.dart'; // Added import

class BlogPage extends StatelessWidget {
  const BlogPage({super.key}); // Added super.key

  // Blog yazıları için örnek veri
  final List<Map<String, String>> blogPosts = const [ // Added const
    {
      'title': 'Köpeklerde Davranış Sorunları ve Çözümleri',
      'summary': 'Köpeğinizin istenmeyen davranışlarını anlamak ve düzeltmek için ipuçları.',
      'imageUrl': 'assets/images/blog1.png', // Placeholder image path
      'author': 'Dr. Pati Sever',
      'date': '15 Ekim 2023',
    },
    {
      'title': 'Kediler İçin En İyi Beslenme Yöntemleri',
      'summary': 'Kedinizin sağlıklı ve mutlu kalması için doğru beslenme stratejileri.',
      'imageUrl': 'assets/images/blog2.png', // Placeholder image path
      'author': 'Prof. Miyav Uzmanı',
      'date': '22 Ekim 2023',
    },
    {
      'title': 'Evcil Hayvanlarla Seyahat Etmenin Püf Noktaları',
      'summary': 'Tüylü dostlarınızla stressiz bir yolculuk için bilmeniz gerekenler.',
      'imageUrl': 'assets/images/blog3.png', // Placeholder image path
      'author': 'Gezgin Patiler',
      'date': '28 Ekim 2023',
    },
    // Daha fazla blog yazısı eklenebilir...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Pati Blog'), // Added const
        backgroundColor: Colors.pink[100],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          final post = blogPosts[index];
          return Card(
            margin: const EdgeInsets.all(10.0), // Added const
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), // Added const for shape
            child: InkWell(
              onTap: () {
                // Blog detay sayfasına navigasyon
                // BlogDetailPage henüz projeye eklenmediği için bu kod hata verecektir.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlogDetailPage(post: post)), // This will cause an error
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only( // Added const
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.asset(
                      post['imageUrl']!,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) { // Added errorBuilder
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0), // Added const
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['title']!,
                          style: const TextStyle( // Added const
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8), // Added const
                        Text(
                          post['summary']!,
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10), // Added const
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yazar: ${post['author']}',
                              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                            ),
                            Text(
                              post['date']!,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Placeholder for BlogDetailPage removed as it's now imported.
// class BlogDetailPage extends StatelessWidget { 
//   final Map<String, String> post;
//   const BlogDetailPage({super.key, required this.post});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: Text(post['title'] ?? "Blog Detail")));
//   }
// }
