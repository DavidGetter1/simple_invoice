// import 'package:equatable/equatable.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:invoice_api/invoice_api_client.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:authentication/authentication.dart';
// import 'package:bl_objects_repository/client/index.dart'
//     show ClientRepository, ClientResponse;
//
// import 'authentication_state.dart';
//
//
// class AuthenticationCubit extends Cubit<AuthenticationState> {
//
//   final AuthenticationRepository _authenticationRepository;
//
//   AuthenticationCubit(this._authenticationRepository): super(UnauthenticatedState()){
//     _authenticationRepository.controller.stream.listen((status) {
//       if(status is AuthenticatedGoogleStatus){
//         print("bin google authenticated");
//         emit(AuthenticatedState(id: status.id));
//       }else if(status is UnauthenticatedStatus){
//         print("controller sagt ich bin unauthenticated");
//         emit(UnauthenticatedState());
//       }
//     });
//   }
//
//   loginWithGoogle() async{
//     print("logge mich ein mit google");
//     emit(AuthenticatingState());
//     await _authenticationRepository.logInWithSocialLoginGoogle();
//     print("logge mich ein mit google FERTIG");
//   }
//
//   signOut() async{
//     _authenticationRepository.signOut();
//   }
//
//
//
// }
