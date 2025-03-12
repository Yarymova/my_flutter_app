import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class RegistrationScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Здесь можно добавить логику для обработки успешного входа через Google
        print('Google User: ${googleUser.email}');
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  Future<void> _signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // Здесь можно добавить логику для обработки успешного входа через Apple
      print('Apple User: ${credential.email}');
    } catch (error) {
      print('Apple Sign-In Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Пароль',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Подтвердите пароль',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Действие при нажатии на кнопку регистрации
              },
              child: Text('Зарегистрироваться'),
            ),
            SizedBox(height: 16.0),
            Text('Или войти через:'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/images/icons/google_icon.png'),
                  onPressed: _signInWithGoogle,
                ),
                SizedBox(width: 16.0),
                IconButton(
                  icon: Image.asset('assets/images/icons/apple_icon.png'),
                  onPressed: _signInWithApple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
