import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LogInWithSocialLoginGoogle extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LogInWithSocialLoginApple extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LogOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}