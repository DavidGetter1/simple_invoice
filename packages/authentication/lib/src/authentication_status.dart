abstract class AuthenticationStatus {
  const AuthenticationStatus();

}

class UnauthenticatedStatus extends AuthenticationStatus {}

class AuthenticatingStatus extends AuthenticationStatus {}

class AuthenticatedAppleStatus extends AuthenticationStatus {
  final String id;
  const AuthenticatedAppleStatus({required this.id});
}

class AuthenticatedGoogleStatus extends AuthenticationStatus {
  final String id;
  const AuthenticatedGoogleStatus({required this.id});
}

class AuthenticatedWithEmailAndPasswordStatus extends AuthenticationStatus {}
