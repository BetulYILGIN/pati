import 'package:flutter/material.dart';
import 'package:pati_check/screens/blog_detail_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  final List<Map<String, String>> blogPosts = const [
        {
      'title': 'Kedilerde Kusma: Sebepleri ve Çözümleri',
      'summary': 'Kediniz neden kusuyor? Ne zaman endişelenmelisiniz? İşte detaylar...',
      'imageUrl': 'assets/images/5.png',
      'author': 'Dr. Pati Sever',
      'date': '15 Ekim 2023',
    },
    {
      'title': 'Köpeklerde Davranış Sorunları ve Çözümleri',
      'summary': 'Köpeğinizin istenmeyen davranışlarını anlamak ve düzeltmek için ipuçları.',
      'imageUrl': 'assets/images/1.png',
      'author': 'Dr. Pati Sever',
      'date': '15 Ekim 2023',
    },
    {
      'title': 'Kediler İçin En İyi Beslenme Yöntemleri',
      'summary': 'Kedinizin sağlıklı ve mutlu kalması için doğru beslenme stratejileri.',
      'imageUrl': 'assets/images/8.png',
      'author': 'Prof. Miyav Uzmanı',
      'date': '22 Ekim 2023',
    },
    {
      'title': 'Evcil Hayvanlarla Seyahat Etmenin Püf Noktaları',
      'summary': 'Tüylü dostlarınızla stressiz bir yolculuk için bilmeniz gerekenler.',
      'imageUrl': 'assets/images/6.png',
      'author': 'Gezgin Patiler',
      'date': '28 Ekim 2023',
    },

    {
      'title': 'Kedi ve Köpeklerde Mevsimsel Alerjiler',
      'summary': 'Evcil hayvanlarınızda mevsim değişikliklerinden kaynaklanan alerji belirtileri ve çözümleri.',
      'imageUrl': 'assets/images/11.png',
      'author': 'Dr. Alerji Uzmanı',
      'date': '12 Kasım 2023',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Pati Blog'),
        backgroundColor: Colors.pink[100],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          final post = blogPosts[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlogDetailPage(post: post)),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.asset(
                      post['imageUrl']!,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post['summary']!,
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
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
