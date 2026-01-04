import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/theme_constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final account = await googleSignIn.signIn();
      if (account == null) return;

      final auth = await account.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      // Splash will handle next screen
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: ThemeConstants.primaryBlue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.group_rounded,
                      size: 120,
                      color: ThemeConstants.primaryBlue,
                    ),
                  ).animate().fadeIn(duration: 600.ms).scale(),
                  const SizedBox(height: 32),
                  const Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: ThemeConstants.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleGoogleSignIn,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Sign in with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
