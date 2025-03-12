import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Для входа через Google
import 'package:sign_in_with_apple/sign_in_with_apple.dart'; // Для входа через Apple

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Инициализация FirebaseAuth

  // Поток для отслеживания состояния аутентификации
  Stream<User?> get userStream => _auth.authStateChanges();

  // Вход через Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }


  // Вход через Apple
  Future<void> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final OAuthProvider oAuthProvider = OAuthProvider("apple.com");
    final OAuthCredential oAuthCredential = oAuthProvider.credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );
    await _auth.signInWithCredential(oAuthCredential); // Используйте _auth
  }

  // Выход из системы
  Future<void> signOut() async {
    await _auth.signOut(); // Используйте _auth
  }
}