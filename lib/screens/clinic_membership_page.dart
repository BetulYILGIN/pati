import 'package:flutter/material.dart';
import 'package:pati_check/screens/clinic_details_page.dart'; // Corrected project name
import 'package:pati_check/db/database_helper.dart'; // Added database_helper import
// import 'package:pati_check/models/user_model.dart'; // User model is in database_helper.dart for now

class ClinicMembershipPage extends StatefulWidget {
  const ClinicMembershipPage({super.key});

  @override
  _ClinicMembershipPageState createState() => _ClinicMembershipPageState();
}

class _ClinicMembershipPageState extends State<ClinicMembershipPage> {
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController authorizedPersonController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _passwordVisible = false; // Parola görünürlük durumu

  @override
  void dispose() {
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
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Geri dönüş
          },
        ),
        title: const Text(
          'Klinik Üyeliği',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'assets/images/klinik.png',
                  width: 250,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Center(
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
              const SizedBox(height: 10),
              const Center(
                child: Text('Lütfen bilgilerinizi giriniz.'),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: clinicNameController,
                decoration: const InputDecoration(
                  labelText: 'Klinik Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: taxNumberController,
                decoration: const InputDecoration(
                  labelText: 'Vergi Numarası',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: authorizedPersonController,
                decoration: const InputDecoration(
                  labelText: 'Yetkili Kişi Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Parola',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Mail Adresi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  final String email = emailController.text;
                  final String password = passwordController.text;
                  final String clinicName = clinicNameController.text;

                  if (email.isEmpty || password.isEmpty || clinicName.isEmpty) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lütfen tüm zorunlu alanları doldurun! (Klinik Adı, Email, Parola)')),
                    );
                    return;
                  }

                  if (password.length < 8) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Parola en az 8 karakter olmalıdır.')),
                    );
                    return;
                  }

                  User newUser = User(
                    email: email,
                    password: password,
                    userType: 'klinik',
                  );

                  try {
                    DatabaseHelper dbHelper = DatabaseHelper();
                    await dbHelper.insertUser(newUser);

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Klinik üye kaydı başarılı: ${newUser.email}')),
                    );
                    Navigator.pushReplacementNamed(context, '/clinic_details');
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Kayıt sırasında bir hata oluştu: ${e.toString()}')),
                    );
                    if (e.toString().toLowerCase().contains('unique constraint failed')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Bu e-posta adresi zaten kayıtlı.')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
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
