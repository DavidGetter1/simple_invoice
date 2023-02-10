import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  static final googleSignIn = GoogleSignIn();

  static Future<OAuthCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    // print(credential);
    return credential;
  }

  static Future<OAuthCredential> signInWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken!,
      accessToken: appleIdCredential.authorizationCode,
    );
    // print(credential);
    return credential;
  }

  static Future<UserCredential> signInAnon() async {
    final credential = FirebaseAuth.instance.signInAnonymously();
    // print(credential);
    return credential;
  }

  static Future<void> signOutFromGoogle() async {
    await googleSignIn.signOut();
  }
}
