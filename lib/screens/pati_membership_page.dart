import 'package:flutter/material.dart';
import 'package:pati_check/screens/patitagram_page.dart';
import 'package:pati_check/db/database_helper.dart';

class PatiMembershipPage extends StatefulWidget {
  const PatiMembershipPage({super.key});

  @override
  _PatiMembershipPageState createState() => _PatiMembershipPageState();
}

class _PatiMembershipPageState extends State<PatiMembershipPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _patiAdiController = TextEditingController();
  final TextEditingController _kullaniciAdiController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
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
      appBar: AppBar(
        title: const Text('Üyelik Oluştur'),
        backgroundColor:  Colors.pink[100],
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0),
          child: Form(
            key: _formKey,
            child: Column(
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
                const Text(
                  'Pati Üyeliği Oluşturun',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text('Lütfen bilgilerinizi giriniz.'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _patiAdiController,
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
                TextFormField(
                  controller: _kullaniciAdiController,
                  decoration: const InputDecoration(
                    labelText: 'Kullanıcı Adı',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen kullanıcı adınızı girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
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
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Parola',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
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
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Parolayı Doğrula',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
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
                TextFormField(
                  controller: _telefonController,
                  decoration: const InputDecoration(
                    labelText: 'Telefon Numarası (Opsiyonel)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final String email = _emailController.text;
                        final String password = _passwordController.text;

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

                          if (e.toString().toLowerCase().contains('unique constraint failed')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Bu e-posta adresi zaten kayıtlı.')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Kayıt sırasında bir hata oluştu: ${e.toString()}')),
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
                    child: const Text(
                      'Kayıt Ol',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
