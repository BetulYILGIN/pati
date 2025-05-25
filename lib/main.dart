import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:paticheck/database_helper.dart'; // Veritabanı sınıfını import ettik



void main() {
  runApp(PatiCheckApp());
}

class PatiCheckApp extends StatelessWidget {
  @override      
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pati-Check',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),  
      ),
      home: HomePage(), 
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 150, height: 150),
            SizedBox(height: 20),
            Text(
              'Pati-Check',
              style: GoogleFonts.lobster(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Patilerinizin sağlığında dijital destek',
              style: GoogleFonts.roboto(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.rotate(
                    angle: 0.785398,  // 45 derece
                    child: Image.asset('assets/images/walk.gif', width: 50, height: 50),
                  ),
                  SizedBox(width: 15),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 235, 146, 176),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _patiAdiController = TextEditingController();
  final TextEditingController _parolaController = TextEditingController();

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
              Image.asset('assets/images/logo.png', width: 150, height: 150),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 72.0),
                child: Column(
                  children: [
                    Text(
                      'Hoş Geldiniz!',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pati-Check’e giriş yap veya kayıt ol!',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _patiAdiController,
                      decoration: InputDecoration(
                        labelText: 'Pati Adı',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color.fromARGB(255, 120, 55, 77), width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _parolaController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Parola',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color.fromARGB(255, 120, 55, 77), width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        // Kullanıcıyı veritabanına kaydetme
                        String patiAdi = _patiAdiController.text;
                        String parola = _parolaController.text;

                        if (patiAdi.isNotEmpty && parola.isNotEmpty) {
                          User user = User(patiAdi: patiAdi, parola: parola);
                          await DatabaseHelper().insertUser(user);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kullanıcı başarıyla kaydedildi!')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lütfen tüm alanları doldurun')));
                        }
                      },
                      child: Text('Giriş Yap', style: TextStyle(color: Colors.black, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Hesabınız yok mu? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AccountTypePage()),
                            );
                          },
                          child: Text(
                            'Hemen Kayıt Ol',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 235, 146, 176),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ForgotPasswordPage extends StatelessWidget {
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
              SizedBox(height: 20),
              Text(
                'Şifre Sıfırlama',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 120, 55, 77), width: 2.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Kod gönderme işlemleri
                },
                child: Text(
                      'Kod Gönder',
                      style: TextStyle(color: Colors.black),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AccountTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50), // Sayfanın başından boşluk
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Yatay boşluk (isteğe bağlı)
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/sayfa1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Hesap Türünü Seçin',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatiMembershipPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/pati.png',
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Pati üyesi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 235, 146, 176),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClinicMembershipPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/klinik.png',
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Klinik üyesi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 235, 146, 176),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}


class ClinicDetailsPage extends StatefulWidget {
  @override
  _ClinicDetailsPageState createState() => _ClinicDetailsPageState();
}

class _ClinicDetailsPageState extends State<ClinicDetailsPage> {
  // Çalışma günleri ve hizmetler
  List<String> workingDays = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"];
  List<String> veterinaryServices = [
    'Muayene', 'Aşı', 'Ameliyat', 'Laboratuvar', 'Diş Tedavisi', 'Deri Hastalıkları',
    'Daha Fazla Aşı', 'Kan Alma ve Testler', 'Evrensel Aşılar', 'Aciliyet Müdahaleleri',
    'Röntgen ve Ultrason', 'Veteriner Fizik Tedavi', 'İç Parazit Tedavisi',
    'Dış Parazit Tedavisi', 'Sterilizasyon ve Kısırlaştırma'
  ];

  Map<String, bool> selectedDays = {};
  Map<String, bool> selectedServices = {};
  String? selectedStartTime;
  String? selectedEndTime;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    workingDays.forEach((day) {
      selectedDays[day] = false;
    });
    veterinaryServices.forEach((service) {
      selectedServices[service] = false;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
                      backgroundColor: Colors.grey[300],
                      child: imagePath == null
                          ? Icon(Icons.camera_alt, size: 40, color: Colors.grey[700])
                          : null,
                    ),
                    TextButton(
                      onPressed: pickImage,
                      child: Text('Profil Resmi Yükle'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Çalışma Saatleri',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedStartTime = picked.format(context);
                              });
                            }
                          },
                          child: Text(selectedStartTime ?? 'Başlangıç Saati'),
                        ),
                      ),
                      Text(" - "),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedEndTime = picked.format(context);
                              });
                            }
                          },
                          child: Text(selectedEndTime ?? 'Bitiş Saati'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Çalışma Günleri',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: workingDays.map((day) {
                      return FilterChip(
                        label: Text(day),
                        selected: selectedDays[day] ?? false,
                        onSelected: (bool value) {
                          setState(() {
                            selectedDays[day] = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Verdikleri Hizmetler',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: veterinaryServices.map((service) {
                      return FilterChip(
                        label: Text(service),
                        selected: selectedServices[service] ?? false,
                        onSelected: (bool value) {
                          setState(() {
                            selectedServices[service] = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Adresi Girin',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Adres (İl, İlçe, Sokak vs.)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Web Sitesi (Opsiyonel)',
                      hintText: 'Örnek: www.klinik.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Açıklama',
                      hintText: 'Klinik hakkında kısa bir açıklama',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Kaydetme işlemi yapılabilir
                    },
                    child: Text(
                      'Kaydet',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class ClinicMembershipPage extends StatefulWidget {
  @override
  _ClinicMembershipPageState createState() => _ClinicMembershipPageState();
}

class _ClinicMembershipPageState extends State<ClinicMembershipPage> {


  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController authorizedPersonController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 40), 
            Center(
              child: Image.asset(
                'assets/images/klinik.png',
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Yeni Klinik Üyeliği Oluşturun',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text('Lütfen bilgilerinizi giriniz.'),
            ),
              SizedBox(height: 20),

              TextField(
                controller: clinicNameController,
                decoration: InputDecoration(
                  labelText: 'Klinik Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              TextField(
                controller: taxNumberController,
                decoration: InputDecoration(
                  labelText: 'Vergi Numarası',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              TextField(
                controller: authorizedPersonController,
                decoration: InputDecoration(
                  labelText: 'Yetkili Kişi Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Parola',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Mail Adresi',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClinicDetailsPage()),
                  );
                },
                child: Text(
                  'Kayıt Ol',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class PatiMembershipPage extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 72.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40), // Sayfanın başından boşluk
            Center(
              child: Image.asset(
                'assets/images/pati.png',
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Yeni Pati Üyeliği Oluşturun',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text('Lütfen bilgilerinizi giriniz.'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72.0), 
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Pati Adı',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 120, 55, 77), width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 120, 55, 77), width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Parola',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 120, 55, 77), width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Parolayı Onayla',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 120, 55, 77), width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PatitagramPage()),
                      );
                    },
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogPost {
  final String title;
  final String excerpt;
  final String content;
  final String imagePath;

  BlogPost({
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imagePath,
  });
}


class PatitagramPage extends StatelessWidget {
  final List<String> images = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patitagram",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor:const Color.fromARGB(255, 235, 146, 176),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: images.map((imgPath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 235, 146, 176),
                            ),
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                imgPath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Text(
                                      "Resim yüklenemedi",
                                      style: TextStyle(color: const Color.fromARGB(255, 255, 86, 105)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              // Büyük kare butonlar
              GridView.count(
                crossAxisCount: 2, // İki sütun
                crossAxisSpacing: 20, // Sütunlar arası mesafe
                mainAxisSpacing: 20, // Satırlar arası mesafe
                shrinkWrap: true, // Grid'in içeriğe göre boyutlanmasını sağlar
                padding: EdgeInsets.all(16),
                children: [
                  _buildSquareButton(
                    context,
                    'Hatırlatma Ekle',
                    Icons.notifications,
                    () {
                      // Hatırlatma ekleme işlevi
                    },
                  ),
                  _buildSquareButton(
                    context,
                    'Size Nasıl Yardımcı Olabilirim?',
                    Icons.help_outline,
                    () {
                      // Yardım butonuna tıklama işlemi
                    },
                  ),
                  _buildSquareButton(
                    context,
                    'Chatbot',
                    Icons.chat_bubble_outline,
                    () {
                      // Chatbot başlatma işlemi
                    },
                  ),
                  _buildSquareButton(
                    context,
                    'En Yakın Veteriner',
                    Icons.local_hospital,
                    () {
                      // En yakın veteriner kliniklerini gösterme
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('En Yakın Veteriner Klinikleri'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Veteriner Klinik 1 - 2 km uzaklıkta'),
                                Text('Veteriner Klinik 2 - 5 km uzaklıkta'),
                                Text('Veteriner Klinik 3 - 7 km uzaklıkta'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Kapat'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  _buildSquareButton(
                    context,
                    'Pati Profili',
                    Icons.pets,
                    () {
                      // Patinin profil sayfasına gitme işlemi
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  _buildSquareButton(
                    context,
                    'Blog Sayfası',
                    Icons.article,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BlogPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kare butonları oluşturma fonksiyonu
  Widget _buildSquareButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 235, 146, 176), // Buton rengi
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: Size(150, 150), // Kare buton boyutu
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Color.fromARGB(255, 100, 17, 45)),
          SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
class BlogPage extends StatelessWidget {
  final List<Map<String, String>> blogPosts = [
  {
    "title": "Kedilerde Kusma: Sebepleri ve Çözümleri",
    "image": "assets/images/5.png",
    "summary": "Kediniz neden kusuyor? Ne zaman endişelenmelisiniz? İşte detaylar...",
    "content": "Evcil hayvan sahipleri için hazırladığımız bu yazımızda, kedinizin neden kustuğunu, kusmanın sebeplerini ve bu durumda ne yapmanız gerektiğini açıklıyoruz. Eğer kediniz sık sık öğürüyorsa veya yediği her şeyi çıkarıyorsa, ciddi bir sağlık sorununun belirtisi olabilir ve bir veteriner hekime danışmanız önemlidir.\n\n"
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
  },
    {
      "title": "Kedilerde İshal: Ne Yapmalı?",
      "image": "assets/images/6.png",
      "excerpt": "Kedinizin ishali varsa dikkat edilmesi gerekenler...",
      "content": "Kedilerde ishalin pek çok nedeni olabilir...",
    },
 {
      "title": "Köpeklerde Tuvalet Alışkanlığı",
      "image": "assets/images/7.png",
      "summary": "Köpeklerin tuvalet düzeni nasıl olmalı? Günde kaç kez dışkılamaları gerekir?",
      "content": "Köpeklerin tuvalet sıklığı yaş, diyet ve aktivite düzeyine bağlı olarak değişebilir. Yavru köpekler daha sık dışkılarken yetişkin köpekler genellikle günde 1-3 kez tuvalet ihtiyacı duyarlar."
    },
    {
      "title": "Evcil Hayvanlarda Obezite",
      "image": "assets/images/8.png",
      "summary": "Fazla kilo dostlarımız için büyük bir risk taşıyor. Obezite nasıl önlenir?",
      "content": "Obezite, evcil hayvanlarda diyabet, eklem rahatsızlıkları ve kalp hastalıkları gibi ciddi sorunlara neden olabilir. Sağlıklı bir diyet, düzenli egzersiz ve porsiyon kontrolü, kiloyu kontrol altında tutmada etkilidir."
    },
    {
      "title": "Kedi ve Köpeklerde Tüy Dökülmesi",
      "image": "assets/images/9.png",
      "summary": "Tüy dökülmesi ne zaman normaldir? Ne zaman tehlikeli hale gelir?",
      "content": "Mevsimsel tüy dökülmesi doğaldır. Ancak aşırı tüy kaybı, cilt hastalıkları, stres veya vitamin eksikliğinden kaynaklanabilir. Düzenli fırçalama ve kaliteli beslenme, tüy sağlığını korumaya yardımcı olur."
    },
    {
      "title": "Evcil Hayvanlarda Deri Problemleri",
      "image": "assets/images/10.png",
      "summary": "Kaşıntı, döküntü ve tahriş gibi cilt sorunlarına dikkat!",
      "content": "Cilt hastalıkları alerjiler, mantar enfeksiyonları veya parazitlerden kaynaklanabilir. Düzenli veteriner kontrolü ve uygun şampuanlar ile cilt sağlığı korunabilir."
    },
    {
      "title": "Solunum Yolu Enfeksiyonları",
      "image": "assets/images/11.png",
      "summary": "Öksürük, burun akıntısı gibi belirtileri önemseyin!",
      "content": "Soğuk algınlığı ve solunum yolu enfeksiyonları evcil hayvanlarda sıkça görülür. Bağışıklık sistemini destekleyen besinler ve hijyenik bir ortam sağlamak hastalıkları önlemede yardımcıdır."
    },
    {
      "title": "Evcil Hayvanlarda Diyabet",
      "image": "assets/images/12.png",
      "summary": "Diyabet belirtilerini nasıl anlarsınız? Tedavisi mümkün mü?",
      "content": "Evcil hayvanlarda diyabet, aşırı susama, kilo kaybı ve sık idrara çıkma gibi belirtilerle kendini gösterir. Diyabet yönetimi, özel beslenme ve veteriner kontrolü gerektirir."
    },
    {
      "title": "Kanser: Erken Teşhisin Önemi",
      "image": "assets/images/3.png",
      "summary": "Kanser belirtilerini erken fark etmek hayat kurtarabilir.",
      "content": "Evcil hayvanlarda kanser vakaları yaşla birlikte artabilir. Anormal şişlikler, iştah kaybı ve halsizlik gibi belirtiler erken teşhis açısından önemlidir."
    },
    {
      "title": "Üriner Sistem Hastalıkları",
      "image": "assets/images/3.png",
      "summary": "İdrar yolu enfeksiyonları kedilerde sık görülür. Ne yapmalısınız?",
      "content": "Kedilerde sık idrar yapma, zorlanma veya idrarda kan görülmesi ciddi bir sağlık sorununun habercisi olabilir. Bol su tüketimi sağlanmalı ve veteriner desteği alınmalıdır."
    },
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Sayfası"),
        backgroundColor: Color.fromARGB(255, 235, 146, 176),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          final post = blogPosts[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Image.asset(
                post["image"] ?? "assets/images/default.png",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(
                post["title"] ?? "Bilinmeyen Başlık",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(post["summary"] ?? post["excerpt"] ?? "Özet bulunamadı."),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailPage(post: post),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BlogDetailPage extends StatelessWidget {
  final Map<String, String> post;

  BlogDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post["title"]!),
        backgroundColor: Color.fromARGB(255, 235, 146, 176),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(post["image"] ?? "assets/images/default.png", width: double.infinity, height: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(post["title"]!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // RICH TEXT İLE FORMATLANMIŞ İÇERİK
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: "🐱 Kediniz sık sık kusuyorsa, altında yatan nedenleri araştırmalısınız.\n\n", style: TextStyle(fontWeight: FontWeight.bold)),
                  
                  WidgetSpan(child: SizedBox(height: 10)), // Boşluk ekler
                  
                  TextSpan(text: "🌿 **Zehirli Maddeler:** ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  TextSpan(text: "Kediniz zehirli bitkiler, bozulmuş mamalar veya zararlı yiyecekler (çikolata, soğan vb.) yutmuş olabilir.\n\n"),

                  TextSpan(text: "🦠 **Parazitler:** ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  TextSpan(text: "Bağırsak parazitleri, kusmaya neden olabilir. Kedinizin dışkısında anormallikler varsa veteriner kontrolü gereklidir.\n\n"),

                  TextSpan(text: "🚧 **Bağırsak Tıkanıklıkları:** ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                  TextSpan(text: "İplik, yün, plastik, paket lastiği gibi yabancı cisimler mide veya bağırsakları tıkayarak kusmaya yol açabilir.\n\n"),

                  TextSpan(text: "⚕️ **Hastalıklar:**\n", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
                  TextSpan(text: "- **Gastrointestinal rahatsızlıklar:** Kabızlık, inflamatuvar bağırsak hastalığı veya tümörler kusmaya neden olabilir.\n"),
                  TextSpan(text: "- **Böbrek hastalığı, diyabet, hipertroidizm:** Metabolik hastalıklar kusmaya eşlik edebilir.\n"),
                  TextSpan(text: "- **Mide Ülseri:** Kusmukta taze kırmızı kan varsa mide ülseri belirtisi olabilir.\n\n"),

                  TextSpan(text: "👃 **Koku & Renk Analizi:** ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
                  TextSpan(text: "Kusmukta aşırı mukus varsa bağırsak iltihabı olabilir. Kahverengi, kahve telvesi gibi görünüyorsa bağırsak problemleri göstergesidir.\n\n"),

                  DividerTextSpan(),

                  TextSpan(text: "✅ **Kedinizin Kusma Sıklığını Takip Edin:** ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  TextSpan(text: "Haftada birden fazla kusuyorsa, nedeni araştırılmalıdır.\n\n"),

                  TextSpan(text: "✅ **Beslenmesini Değiştirin:** ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  TextSpan(text: "Kolay sindirilebilen mama kullanarak sindirim sistemini rahatlatabilirsiniz.\n"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Özel Divider TextSpan oluşturma fonksiyonu
class DividerTextSpan extends TextSpan {
  DividerTextSpan()
      : super(
          children: [
            WidgetSpan(
              child: Divider(thickness: 1, color: Colors.grey, height: 20),
            ),
          ],
        );
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patinin Profili'),
      ),
      body: Center(
        child: Text('Patinin profil bilgileri burada yer alacak'),
      ),
    );
  }
}
