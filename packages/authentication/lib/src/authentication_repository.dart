import 'dart:async';

import 'package:authentication/src/authentication_service.dart';
import 'package:authentication/src/credential_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'authentication_status.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  AuthenticationRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance, _googleSignIn = googleSignIn ?? GoogleSignIn();

  final googleCredentialProvider = new GoogleCredentialProvider();

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser!;
    return currentUser != null;
  }

  Future<User> getUser() async {
    return await _firebaseAuth.currentUser!;
  }

  Future<User> logInWithSocialLoginGoogle([CredentialProvider? credentialProvider]) async {
    if(credentialProvider == null){
      credentialProvider = new GoogleCredentialProvider();
    }
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw new Error();
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // nullable, because it might be theoretically null, however it wont be.
    AuthCredential? credential;
    // CredentialProvider is an abstract class which has subtypes for both google and
    // apple sign in.
    if(credentialProvider is GoogleCredentialProvider){
       credential = credentialProvider.credentialGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    }

    final UserCredential result = await _firebaseAuth.signInWithCredential(credential!);
    return result.user!;
  }

  Future<User> logInWithSocialLoginApple([CredentialProvider? credentialProvider, OAuthProvider? oAuthProvider]) async {
    if(credentialProvider == null){
      credentialProvider = new AppleCredentialProvider();
    }
    if(oAuthProvider == null){
      oAuthProvider = new OAuthProvider("apple.com");
    }
    // nullable, because it might be theoretically null, however it wont be.
    AuthorizationCredentialAppleID? appleIdCredential;

    if(credentialProvider is AppleCredentialProvider){
      appleIdCredential = await credentialProvider.credentialApple(
        email: AppleIDAuthorizationScopes.email,
        fullName: AppleIDAuthorizationScopes.fullName,
      );
    }


    OAuthCredential? credential;
    if(credentialProvider is AppleCredentialProvider) {
      credential = credentialProvider.oAuthCredential(identityToken: appleIdCredential!.identityToken, authorizationCode: appleIdCredential.authorizationCode, provider: oAuthProvider);
    }
    final UserCredential result = await _firebaseAuth.signInWithCredential(credential!);
    return result.user!;
  }

  void logOut() async {
    return await _firebaseAuth.signOut();
  }
}

// class AuthenticationRepository {
//   AuthenticationRepository({WrapFirebase? firebase})
//       : firebase = firebase ?? WrapFirebase();
//
//   final StreamController<AuthenticationStatus> controller = StreamController<AuthenticationStatus>();
//   final WrapFirebase firebase;
//
//   Stream<AuthenticationStatus> get status async* {
//     controller.add(UnauthenticatedStatus());
//     FirebaseAuth.instance.authStateChanges().listen((user) {
//       if(user == null){
//         controller.add(UnauthenticatedStatus());
//       }else{
//         controller.add(AuthenticatedGoogleStatus(id: FirebaseAuth.instance.currentUser!.uid));
//       }
//     });
//   }
//
//   Future<void> logInWithSocialLoginGoogle() async {
//       OAuthCredential? credentials;
//       credentials = await firebase.signInWithGoogle();
//       print(credentials);
//       try {
//         final userCredential = await FirebaseAuth.instance.currentUser
//             ?.linkWithCredential(credentials!);
//       } on FirebaseAuthException catch (e) {
//         switch (e.code) {
//           case "provider-already-linked":
//             print("The provider has already been linked to the user.");
//             break;
//           case "invalid-credential":
//             print("The provider's credential is not valid.");
//             break;
//           case "credential-already-in-use":
//             print("The account corresponding to the credential already exists, "
//                 "or is already linked to a Firebase User.");
//             break;
//         // See the API reference for the full list of error codes.
//           default:
//             print("Unknown error.");
//         }
//       }
//       firebaseSignIn(credentials);
//   }
//
//
//
//   void firebaseSignIn(credentials) async {
//     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credentials);
//     print("user credentials:");
//     print(userCredential);
//     if(FirebaseAuth.instance.currentUser != null){
//       controller.add(AuthenticatedGoogleStatus(id: FirebaseAuth.instance.currentUser!.uid));
//     }
//   }
//
//   void signOut() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//     }catch(e){
//       throw new Exception(e);
//     }
//     controller.add(UnauthenticatedStatus());
//   }
//
//   void dispose() => controller.close();
// }
//
// class WrapFirebase{
//   Future<OAuthCredential?> signInWithGoogle(){
//     return AuthService.signInWithGoogle();
//   }
// }
