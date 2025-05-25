import 'package:flutter/material.dart';
import 'package:pati_check/screens/clinic_details_page.dart'; // Corrected project name
import 'package:pati_check/db/database_helper.dart'; // Added database_helper import
// import 'package:pati_check/models/user_model.dart'; // User model is in database_helper.dart for now

// Added missing StatefulWidget class definition
class ClinicMembershipPage extends StatefulWidget {
  const ClinicMembershipPage({super.key}); 

  @override
  _ClinicMembershipPageState createState() => _ClinicMembershipPageState();
}
// Moved createState into the class above

class _ClinicMembershipPageState extends State<ClinicMembershipPage> {
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController authorizedPersonController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() { // Added dispose method for controllers
    clinicNameController.dispose();
    taxNumberController.dispose();
    authorizedPersonController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0), // Orijinalde 72.0
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Added const
              Center(
                child: Image.asset(
                  'assets/images/klinik.png', // This will cause error if not in pubspec
                  width: 250,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) { // Added errorBuilder for robustness
                    return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(height: 20), // Added const
              const Center( // Added const
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
              const SizedBox(height: 10), // Added const
              const Center( // Added const
                child: Text('Lütfen bilgilerinizi giriniz.'),
              ),
              const SizedBox(height: 20), // Added const

              TextField(
                controller: clinicNameController,
                decoration: const InputDecoration( // Added const
                  labelText: 'Klinik Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const

              TextField(
                controller: taxNumberController,
                decoration: const InputDecoration( // Added const
                  labelText: 'Vergi Numarası',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const

              TextField(
                controller: authorizedPersonController,
                decoration: const InputDecoration( // Added const
                  labelText: 'Yetkili Kişi Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration( // Added const
                  labelText: 'Parola',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const

              TextField(
                controller: emailController,
                decoration: const InputDecoration( // Added const
                  labelText: 'Mail Adresi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added const
              ElevatedButton(
                onPressed: () async {
                  // Alanların boş olup olmadığını kontrol et (isteğe bağlı ama önerilir)
                  final String email = emailController.text;
                  final String password = passwordController.text;
                  final String clinicName = clinicNameController.text; // Şimdilik sadece loglama için alalım

                  if (email.isEmpty || password.isEmpty || clinicName.isEmpty) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lütfen tüm zorunlu alanları doldurun! (Klinik Adı, Email, Parola)')),
                    );
                    return;
                  }

                  // User nesnesi oluştur
                  User newUser = User(
                    email: email,
                    password: password, // Şifre hash'lenmeden gönderilecek, DatabaseHelper halledecek
                    userType: 'klinik', // veya 'veteriner' - kullanıcıya sorulabilir veya sabitlenebilir
                  );

                  try {
                    DatabaseHelper dbHelper = DatabaseHelper();
                    await dbHelper.insertUser(newUser);

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Klinik üye kaydı başarılı: ${newUser.email}')),
                    );
                    // Başarılı kayıt sonrası ClinicDetailsPage'e yönlendirme
                    Navigator.pushReplacementNamed(context, '/clinic_details');
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Kayıt sırasında bir hata oluştu: ${e.toString()}')),
                    );
                    // Örneğin, e-posta zaten kullanımdaysa (UNIQUE constraint) özel bir mesaj verilebilir
                    if (e.toString().toLowerCase().contains('unique constraint failed')) {
                         ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Bu e-posta adresi zaten kayıtlı.')),
                        );
                    }
                  }
                },
                style: ElevatedButton.styleFrom( // Moved style before child
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: const EdgeInsets.symmetric(vertical: 15), // Added const
                  minimumSize: const Size(double.infinity, 50), // Added const
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text( // Added const
                  'Kayıt Ol',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
