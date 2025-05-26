import 'package:flutter/material.dart';
import 'package:pati_check/db/database_helper.dart';
import 'package:pati_check/screens/patitagram_page.dart';
import 'package:pati_check/screens/account_type_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Parola gizleme durumu için değişken
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun!')),
      );
      return;
    }

    DatabaseHelper dbHelper = DatabaseHelper();
    User? user = await dbHelper.loginUser(email, password);

    if (!mounted) return;

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı! Hoş geldiniz ${user.email}. Kullanıcı Türü: ${user.userType}')),
      );
      Navigator.pushReplacementNamed(context, '/patitagram');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giriş bilgileri hatalı veya kullanıcı bulunamadı.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 114, 158),
        title: const Text('Login'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 16),
              const Text(
                'Hoşgeldiniz',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'PatiCheck\'e giriş yap veya kaydol',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Pati veya Klinik Adı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kullanıcı adınızı girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword, // Gizleme durumu buraya bağlı
                decoration: InputDecoration(
                  labelText: 'Parola',
                  border: const OutlineInputBorder(),
                  // Parola göster/gizle ikonu
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword; // Durumu tersine çevir
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen parolanızı girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          bool rememberMe = false;
                          return Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                          );
                        },
                      ),
                      const Text('Beni Hatırla'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: const Text(
                      'Parolamı Unuttum?',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50), // Genişlik: TextFormField ile aynı
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/account_type');
                },
                child: const Text(
                  'Hesabınız yok mu? Hemen kaydolun',
                  style: TextStyle(
                    color: Colors.pink,
                    decoration: TextDecoration.underline,
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
