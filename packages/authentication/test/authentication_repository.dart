// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:authentication/src/credential_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:authentication/authentication.dart';
import 'package:authentication/authentication.dart' as auth_repo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:test/test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth{}
class MockUser extends Mock implements User{}
class MockGoogleSignIn extends Mock implements GoogleSignIn{}
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount{}
class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication{}
class MockGoogleCredentialProvider extends Mock implements GoogleCredentialProvider{}
class MockAuthCredential extends Mock implements AuthCredential{}
class MockUserCredential extends Mock implements UserCredential{}
class MockAuthorizationCredentialAppleID extends Mock implements AuthorizationCredentialAppleID{}
class MockAppleCredentialProvider extends Mock implements AppleCredentialProvider{}
class MockOAuthCredential extends Mock implements OAuthCredential{}
class MockOAuthProvider extends Mock implements OAuthProvider{}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('ClientRepository', () {

    late auth_repo.AuthenticationRepository authRepo;
    late BehaviorSubject<auth_repo.AuthenticationStatus> streamController;
    late MockFirebaseAuth firebaseAuth;
    late MockGoogleSignIn googleSignIn;

    setUp(() async {
      firebaseAuth = new MockFirebaseAuth();
      googleSignIn = new MockGoogleSignIn();
      authRepo = auth_repo.AuthenticationRepository(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn
      );
    });

    group('currentUser mocks', () {

      test('isSignedIn is correct', () async {
        when(() => firebaseAuth.currentUser).thenReturn(MockUser());
        bool isSignedIn = await authRepo.isSignedIn();
        expect(isSignedIn, true);
      });

      test('getUser is correct', () async {
        User mockedUser = new MockUser();
        when(() => firebaseAuth.currentUser).thenReturn(mockedUser);
        User returnedUser = await authRepo.getUser();
        expect(returnedUser, mockedUser);
      });
    });

    group('sign ins work', () {

      test('googleSignIn works correctly', () async {
        GoogleSignInAccount googleSignInAccount = new MockGoogleSignInAccount();
        GoogleSignInAuthentication googleSignInAuthentication = new MockGoogleSignInAuthentication();
        CredentialProvider credentialProvider = new MockGoogleCredentialProvider();
        AuthCredential authCredential = new MockAuthCredential();
        UserCredential userCredential = new MockUserCredential();
        when(() => googleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);
        when(() => googleSignInAccount.authentication).thenAnswer((_) async => googleSignInAuthentication);
        if(credentialProvider is GoogleCredentialProvider) {
          when(() =>
              credentialProvider.credentialGoogle(
                  accessToken: any(named: "accessToken"),
                  idToken: any(named: "idToken"))).thenAnswer((
              _) => authCredential);
        } when(() => firebaseAuth.signInWithCredential(authCredential)).thenAnswer((_) async => userCredential);
        when(() => userCredential.user).thenReturn(new MockUser());
        User user = await authRepo.logInWithSocialLoginGoogle(credentialProvider);
        expect(user, isNotNull);
      });

      test('appleSignIn works correctly', () async {
        AuthorizationCredentialAppleID appleIdCredential = new MockAuthorizationCredentialAppleID();
        CredentialProvider credentialProvider = new MockAppleCredentialProvider();
        OAuthCredential oAuthCredential = new MockOAuthCredential();
        UserCredential userCredential = new MockUserCredential();

        if (credentialProvider is AppleCredentialProvider) {
          when(() =>
              credentialProvider.credentialApple(
                  email: AppleIDAuthorizationScopes.email,
                  fullName: AppleIDAuthorizationScopes.fullName)).thenAnswer(
                  (_) => Future.value(appleIdCredential));
        }
        OAuthProvider oAuthProvider = new MockOAuthProvider();
        if (credentialProvider is AppleCredentialProvider) {
          when(() => credentialProvider.oAuthCredential(
              identityToken: any(named: "identityToken"),
              authorizationCode: any(named: "authorizationCode"),
              provider: oAuthProvider)).thenAnswer((_) => oAuthCredential);
        }
        when(() => appleIdCredential.identityToken).thenReturn("1");
        when(() => appleIdCredential.authorizationCode).thenReturn("2");
        when(() => firebaseAuth.signInWithCredential(oAuthCredential)).thenAnswer((_) async => userCredential);
        when(() => userCredential.user).thenReturn(new MockUser());

        User user = await authRepo.logInWithSocialLoginApple(credentialProvider, oAuthProvider);

        if (credentialProvider is AppleCredentialProvider) {
          verify(() => credentialProvider.oAuthCredential(identityToken: '1', provider: oAuthProvider, authorizationCode: '2')).called(1);
        }

        expect(user, isNotNull);
      });
      group('log out work', () {
        test('googleSignIn works correctly', () {
          when(() => firebaseAuth.signOut()).thenAnswer((_) => Future.delayed(Duration(seconds: 1)));
          authRepo.logOut();
          verify(() => firebaseAuth.signOut()).called(1);
        });
      });
    });

  });
}
