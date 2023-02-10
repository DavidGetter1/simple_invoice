import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class CredentialProvider {
}

class AppleCredentialProvider implements CredentialProvider {
  Future<AuthorizationCredentialAppleID> credentialApple({
    required AppleIDAuthorizationScopes email, required AppleIDAuthorizationScopes fullName}) {
    return SignInWithApple.getAppleIDCredential(scopes: [email, fullName]);
  }

  OAuthCredential oAuthCredential({required String? identityToken, required String? authorizationCode, required OAuthProvider provider}){
    return provider.credential(idToken: identityToken, accessToken: authorizationCode);
  }
}

class GoogleCredentialProvider implements CredentialProvider {
  AuthCredential credentialGoogle({
      required String? accessToken, required String? idToken}) {
    return GoogleAuthProvider.credential(accessToken: accessToken, idToken: idToken);
  }
}