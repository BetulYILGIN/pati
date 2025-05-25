import 'package:flutter/material.dart';
import 'package:pati_check/screens/account_type_page.dart'; // Added import
// import 'package:pati_check/database_helper.dart'; // To be added later
// import 'package:pati_check/user_model.dart'; // To be added later

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // String email = _emailController.text;
      // String password = _passwordController.text;

      // TODO: Implement actual login logic using DatabaseHelper
      // This will initially cause errors as DatabaseHelper is not imported.
      // For now, simulate a successful login and navigate.
      print('Login attempt with Email: ${_emailController.text}, Password: ${_passwordController.text}');
      
      // Placeholder for navigation to AccountTypePage
      // This will cause an error until AccountTypePage is created and imported.
      // For now, simulate a successful login and navigate.
      // The user model and actual DB check would go here.
      // If login is successful:
      // For now, just print. Actual navigation to a post-login screen or DB interaction will be handled later.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login attempt: Email: ${_emailController.text}')),
      );
      // IMPORTANT: Navigation to AccountTypePage was removed from here.
      // It will be handled by a separate UI element (e.g., a "Create Account" button).
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 20), // Added space
              GestureDetector(
                onTap: () {
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountTypePage()),
                  );
                },
                child: const Text(
                  'Don\'t have an account? Create one',
                  style: TextStyle(
                    color: Colors.pink, // Example color
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

// Placeholder for AccountTypePage to allow code to be structured.
// Remove when account_type_page.dart is properly created.
// class AccountTypePage extends StatelessWidget {
//  const AccountTypePage({super.key});
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(appBar: AppBar(title: const Text("Account Type Placeholder")));
//  }
// }
