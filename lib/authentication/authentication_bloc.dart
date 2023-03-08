import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:bl_objects_repository/user/index.dart';
import 'package:easyinvoice/authentication/authentication_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_state.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  AuthenticationBloc({required this.authenticationRepository, required this.userRepository})
      : assert(authenticationRepository != null), super(AuthenticationUninitialized()){
    on<LogInWithSocialLoginGoogle>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final firebaseUser = await authenticationRepository.logInWithSocialLoginGoogle();
        emit(AuthenticationAuthenticated(id: firebaseUser.uid, callback: () => updateUserId(firebaseUser.uid)));
      } catch (error) {
        emit(AuthenticationFailure(error: error.toString()));
    }
    });
    on<AppStarted>((event, emit) async {
      final isSignedIn = await authenticationRepository.isSignedIn();
      if (isSignedIn) {
        final firebaseUser = await authenticationRepository.getUser();
        emit(AuthenticationAuthenticated(id: firebaseUser.uid, callback: () => updateUserId(firebaseUser.uid)));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
    on<LogInWithSocialLoginApple>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final firebaseUser = await authenticationRepository.logInWithSocialLoginApple();
        emit(AuthenticationAuthenticated(id: firebaseUser.uid, callback: () => updateUserId(firebaseUser.uid)));
      } catch (error) {
        emit(AuthenticationFailure(error: error.toString()));
      }
    });
    on<LogOut>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        authenticationRepository.logOut();
        emit(AuthenticationUnauthenticated());
      } catch (error) {
        emit(AuthenticationFailure(error: error.toString()));
      }
    });
  }

  final _userIdController = StreamController<String>();

  Stream<String> get UserId => _userIdController.stream;

  void updateUserId(String newUserId) {
    _userIdController.sink.add(newUserId);
  }

  void dispose() {
    _userIdController.close();
  }

}