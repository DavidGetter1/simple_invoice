import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationAuthenticated extends AuthenticationState {
  final String id;

  AuthenticationAuthenticated({required this.id}) : assert(id != null) {}

  @override
  List<Object> get props => [id];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  const AuthenticationFailure({required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];
}

// abstract class AuthenticationState {
//   const AuthenticationState();
// }
//
// class UnauthenticatedState extends AuthenticationState {
//   @override
//   String toString() {
//     return "UnauthenticatedState";
//   }
// }
//
// class AuthenticatingState extends AuthenticationState {
//   @override
//   String toString() {
//     return "AuthenticatingState";
//   }
// }
//
// class AuthenticatedState extends AuthenticationState {
//   final String id;
//   const AuthenticatedState({required this.id});
//
//   @override
//   String toString() {
//     return "AuthenticatedState";
//   }
// }
