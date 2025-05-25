import 'package:flutter/material.dart';

// BlogPost sınıfı tanımı
class BlogPost {
  final String title;
  final String author;
  final String date;
  final String content; // İçerik için yeni bir alan
  final String imageUrl; // Resim URL'si için yeni bir alan

  const BlogPost({ // Added const constructor
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    required this.imageUrl,
  });
}

// BlogDetailPage sınıfı tanımı
class BlogDetailPage extends StatelessWidget {
  final Map<String, String> post; // BlogPage'den gelen veri Map<String, String> idi.
                                  // BlogPost class'ını kullanmak için BlogPage'in de güncellenmesi gerekir.
                                  // Şimdilik Map<String, String> olarak bırakıyorum,
                                  // Bir sonraki adımda BlogPage'deki veri yapısını BlogPost'a çevirebiliriz.

  const BlogDetailPage({super.key, required this.post}); // Added super.key

  @override
  Widget build(BuildContext context) {
    // Örnek içerik oluşturma (post Map'inden BlogPost'a dönüştürme)
    // Bu idealde BlogPage'den doğrudan BlogPost nesnesi olarak gelmeli.
    final blogPostData = BlogPost(
      title: post['title'] ?? 'Başlık Yok',
      author: post['author'] ?? 'Yazar Yok',
      date: post['date'] ?? 'Tarih Yok',
      imageUrl: post['imageUrl'] ?? 'assets/images/placeholder.png', // Varsayılan resim
      content: post['summary'] ?? // `summary` alanını `content` olarak kullanıyoruz şimdilik.
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
          "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
          "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
          "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
          "\n\n"
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, "
          "totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. "
          "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. "
          "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, "
          "sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
    );


    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(blogPostData.title),
        backgroundColor: Colors.pink[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Added const
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect( // Added ClipRRect for rounded corners on image
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                blogPostData.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) { // Added errorBuilder
                    return Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    );
                  },
              ),
            ),
            const SizedBox(height: 16.0), // Added const
            Text(
              blogPostData.title,
              style: const TextStyle( // Added const
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 120, 55, 77),
              ),
            ),
            const SizedBox(height: 8.0), // Added const
            Row( // Added Row for author and date
              children: [
                Icon(Icons.person_outline, size: 16.0, color: Colors.grey[700]),
                const SizedBox(width: 4.0), // Added const
                Text(
                  blogPostData.author,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
                const SizedBox(width: 16.0), // Added const
                Icon(Icons.calendar_today_outlined, size: 16.0, color: Colors.grey[700]),
                const SizedBox(width: 4.0), // Added const
                Text(
                  blogPostData.date,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 20.0), // Added const
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16.0, height: 1.5, color: Colors.black87),
                children: <TextSpan>[
                  // Burada DividerTextSpan kullanılabilir veya doğrudan TextSpan'lar
                  // Şimdilik doğrudan TextSpan kullanıyorum. DividerTextSpan'ı da ekleyeceğim.
                  TextSpan(text: blogPostData.content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DividerTextSpan sınıfı tanımı
class DividerTextSpan extends TextSpan {
  DividerTextSpan({
    super.style,
    String text = '\n\n', // Varsayılan olarak boşluk bırakır
    List<InlineSpan>? children, // children parametresi eklendi
  }) : super(
          text: text,
          children: children, // children parametresi TextSpan'a iletildi
        );
}
