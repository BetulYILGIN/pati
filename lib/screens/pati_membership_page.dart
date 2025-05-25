import 'package:flutter/material.dart';
import 'package:pati_check/screens/patitagram_page.dart'; // Added import
import 'package:pati_check/db/database_helper.dart'; // Added DatabaseHelper import

class PatiMembershipPage extends StatefulWidget { // Changed to StatefulWidget
  const PatiMembershipPage({super.key});

  @override
  _PatiMembershipPageState createState() => _PatiMembershipPageState(); // Added createState
}

class _PatiMembershipPageState extends State<PatiMembershipPage> { // Created State class
  final _formKey = GlobalKey<FormState>(); // Added GlobalKey for Form validation

  // Added TextEditingControllers
  final TextEditingController _patiAdiController = TextEditingController(); // Original 'Ad Soyad'
  final TextEditingController _kullaniciAdiController = TextEditingController(); // Original 'Kullanıcı Adı'
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController(); // Original 'Telefon Numarası'


  @override
  void dispose() { // Added dispose method for controllers
    _patiAdiController.dispose();
    _kullaniciAdiController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _telefonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0),
          child: Form( // Wrapped Column with Form
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/images/pati.png',
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
                    'Pati Üyeliği Oluşturun',
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
                TextFormField( // Changed to TextFormField
                  controller: _patiAdiController, // Linked controller
                  decoration: const InputDecoration(
                    labelText: 'Ad Soyad',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen adınızı ve soyadınızı girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField( // Changed to TextFormField
                  controller: _kullaniciAdiController, // Linked controller
                  decoration: const InputDecoration(
                    labelText: 'Kullanıcı Adı',
                    border: OutlineInputBorder(),
                  ),
                   validator: (value) { // Added validator
                    if (value == null || value.isEmpty) {
                      return 'Lütfen kullanıcı adınızı girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                 TextFormField( // Changed to TextFormField
                  controller: _emailController, // Linked controller
                  decoration: const InputDecoration(
                    labelText: 'Mail Adresi',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen e-posta adresinizi girin';
                    }
                    if (!value.contains('@')) {
                      return 'Geçerli bir e-posta adresi girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField( // Changed to TextFormField
                  controller: _passwordController, // Linked controller
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Parola',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir parola belirleyin';
                    }
                    if (value.length < 6) {
                      return 'Parola en az 6 karakter olmalıdır';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                 TextFormField( // Added Confirm Password field
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Parolayı Doğrula',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen parolanızı doğrulayın';
                    }
                    if (value != _passwordController.text) {
                      return 'Parolalar eşleşmiyor';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField( // Changed to TextFormField
                  controller: _telefonController, // Linked controller
                  decoration: const InputDecoration(
                    labelText: 'Telefon Numarası (Opsiyonel)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final String email = _emailController.text;
                      final String password = _passwordController.text;
                      // final String patiName = _patiAdiController.text; // For logging or other use

                      // Note: confirmPassword check is already done by the validator
                      // No need for these checks if form validation is active and includes them:
                      // if (email.isEmpty || password.isEmpty /* || confirmPassword.isEmpty */) {
                      //   if (!mounted) return;
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Lütfen tüm zorunlu alanları doldurun!')),
                      //   );
                      //   return;
                      // }
                      // if (password != _confirmPasswordController.text) { // Validator handles this
                      //   if (!mounted) return;
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Parolalar eşleşmiyor!')),
                      //   );
                      //   return;
                      // }

                      User newUser = User(
                        email: email,
                        password: password,
                        userType: 'pati',
                      );

                      try {
                        DatabaseHelper dbHelper = DatabaseHelper();
                        await dbHelper.insertUser(newUser);

                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Pati üye kaydı başarılı: ${newUser.email}')),
                        );
                        Navigator.pushReplacementNamed(context, '/patitagram');
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
                    }
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: const EdgeInsets.symmetric(vertical: 15),
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

// Placeholder for PatitagramPage removed as it's now imported.
// class PatitagramPage extends StatelessWidget { 
//   const PatitagramPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text("Patitagram Placeholder")));
//   }
// }
