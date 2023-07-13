import 'package:flutter/material.dart';
import 'package:news/providers/auth_provider.dart';
import 'package:news/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);
            authProvider.googleSignIn().then(
                  (value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  ),
                );
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
