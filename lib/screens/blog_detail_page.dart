import 'package:flutter/material.dart';

class BlogPost {
  final String title;
  final String author;
  final String date;
  final String content;
  final String imageUrl;

  const BlogPost({
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    required this.imageUrl,
  });
}

class BlogDetailPage extends StatelessWidget {
  final Map<String, String> post;

  const BlogDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final blogPostData = BlogPost(
      title: post['title'] ?? 'Başlık Yok',
      author: post['author'] ?? 'Yazar Yok',
      date: post['date'] ?? 'Tarih Yok',
      imageUrl: post['imageUrl'] ?? 'assets/images/13.png',
      content: _getContent(post['title'] ?? ''),
    );

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(blogPostData.title),
        backgroundColor: Colors.pink[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                blogPostData.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              blogPostData.title,
              style: const TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 120, 55, 77),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.person_outline, size: 16.0, color: Colors.grey[700]),
                const SizedBox(width: 4.0),
                Text(
                  blogPostData.author,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
                const SizedBox(width: 16.0),
                Icon(Icons.calendar_today_outlined, size: 16.0, color: Colors.grey[700]),
                const SizedBox(width: 4.0),
                Text(
                  blogPostData.date,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              blogPostData.content,
              style: const TextStyle(fontSize: 16.0, height: 1.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // Başlık bazlı zengin içerik
  static String _getContent(String title) {
    switch (title) {
      case 'Kedilerde Kusma: Sebepleri ve Çözümleri':
        return '''
   
    "Kediniz neden kusuyor? Ne zaman endişelenmelisiniz? İşte detaylar...",
    "Evcil hayvan sahipleri için hazırladığımız bu yazımızda, kedinizin neden kustuğunu, kusmanın sebeplerini ve bu durumda ne yapmanız gerektiğini açıklıyoruz. Eğer kediniz sık sık öğürüyorsa veya yediği her şeyi çıkarıyorsa, ciddi bir sağlık sorununun belirtisi olabilir ve bir veteriner hekime danışmanız önemlidir.\n\n"
    "🐾 **Tüy Yumakları:** Kediler, kendilerini temizlerken yuttukları tüyleri zaman zaman çıkarırlar. Haftada bir veya iki kez tüy yumağı kusmaları normaldir. Ancak, sık sık kusuyorsa veya çıkarmakta zorlanıyorsa, mide-bağırsak tıkanıklığı riski olabilir.\n\n"
    "🌿 **Zehirli Maddeler:** Kediniz zehirli bitkiler, bozulmuş mamalar, bazı ilaçlar veya zararlı yiyecekleri (çikolata, soğan vb.) yutmuş olabilir.\n\n"
    "🦠 **Parazitler:** Bağırsak parazitleri, kusmaya neden olabilir. Kedinizin dışkısında anormallikler varsa veteriner kontrolü gereklidir.\n\n"
    "🧩 **Bağırsak Tıkanıklıkları:** İplik, yün, plastik, paket lastiği gibi yabancı cisimler mide veya bağırsakları tıkayarak kusmaya yol açabilir.\n\n"
    "🩺 **Hastalıklar:**\n"
    "- **Gastrointestinal rahatsızlıklar:** Kabızlık, inflamatuvar bağırsak hastalığı veya tümörler kusmaya neden olabilir.\n"
    "- **Böbrek hastalığı, diyabet, hipertroidizm:** Metabolik hastalıklar kusmaya eşlik edebilir.\n"
    "- **Mide Ülseri:** Kusmukta taze kırmızı kan varsa mide ülseri belirtisi olabilir.\n\n"
    "👃 **Koku & Renk Analizi:** Kusmukta aşırı mukus varsa bağırsak iltihabı olabilir. Kahverengi, kahve telvesi gibi görünüyorsa bağırsak problemleri göstergesidir. Kötü kokulu kusmuk, bağırsak tıkanıklığı işareti olabilir.\n\n"
    "---\n\n"
    "✅ **Kedinizin Kusma Sıklığını Takip Edin:** Haftada birden fazla kusuyorsa, nedeni araştırılmalıdır.\n"
    "✅ **Beslenmesini Değiştirin:** Kolay sindirilebilen mama kullanarak sindirim sistemini rahatlatabilirsiniz.\n"
    "✅ **Su Kaybına Dikkat Edin:** Kusma sonrası kediniz sıvı kaybedebilir. Bol su içmesini sağlayın.\n"
    "✅ **Veteriner Kontrolü:** Kusma sık tekrar ediyorsa veya kan içeriyorsa, vakit kaybetmeden veteriner hekime başvurun.\n\n"
    "---\n\n"
    "📌 **Unutmayın!** Kusmayı önleyici ilaçlar yalnızca belirtileri bastırır. Esas nedenin tespit edilerek tedavi edilmesi hayati önem taşır. 🐱💙"
 ''';
      case 'Köpeklerde Davranış Sorunları ve Çözümleri':
        return '''
Köpeklerde davranış sorunları, sabır ve doğru eğitim yöntemleriyle çözülebilir. 
Dişi ve erkek köpeklerde farklı davranış kalıpları gözlemlenebilir. 
Ödüllendirme yöntemiyle olumlu davranış pekiştirilmeli, ceza yerine pozitif eğitim tercih edilmelidir. 
Davranış sorunlarının temelinde genellikle korku, stres veya sosyalizasyon eksikliği vardır.
''';
      case 'Kediler İçin En İyi Beslenme Yöntemleri':
        return '''
Kediler etobur olduklarından protein ağırlıklı beslenmelidir. 
Kuru ve yaş mama dengeli kullanılmalı, su tüketimi artırılmalıdır. 
Aşırı beslenmeden kaçınılmalı ve düzenli veterinere kontroller yaptırılmalıdır. 
Doğal beslenme seçenekleri ve ev yapımı mamalar konusunda veterinerinizle görüşebilirsiniz.
''';
      case 'Evcil Hayvanlarla Seyahat Etmenin Püf Noktaları':
        return '''
Evcil hayvanlarla seyahat öncesi veteriner kontrolü önemlidir. 
Küçük molalar verilmeli ve hayvanların rahatlığı için uygun taşıma çantaları kullanılmalıdır. 
Yolculuk sırasında sakinleştirici ilaçlar veteriner önerisi ile verilmelidir. 
Seyahat esnasında su ve yiyecek ihtiyacı düzenli karşılanmalıdır.
''';
      case 'Kedi ve Köpeklerde Mevsimsel Alerjiler':
        return '''
Mevsim geçişlerinde kedi ve köpeklerde cilt kaşıntısı, tüy dökümü ve hapşırma görülebilir. 
Alerji testleri yapılmalı ve alerjenlerden kaçınılmalıdır. 
Veteriner tarafından önerilen antihistaminikler ve özel şampuanlar kullanılabilir. 
Düzenli bakım ve beslenme, bağışıklık sistemini güçlendirir.
''';
      default:
        return '''
Evcil hayvanlarınızın sağlığı için düzenli veteriner kontrolleri ve dengeli beslenme çok önemlidir. 
Sevgi ve ilgi ile büyüyen hayvanlar daha sağlıklı ve mutlu olurlar. 
Her zaman veterinerinizin önerilerine kulak verin ve hayvanlarınızın ihtiyaçlarını ön planda tutun.
''';
    }
  }
}
