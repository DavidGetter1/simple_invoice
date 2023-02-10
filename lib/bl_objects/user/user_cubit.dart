import 'package:easyinvoice/bl_objects/user/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:invoice_api_client/users/models/userDTOSend.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bl_objects_repository/user/index.dart'
    show UserRepository, UserResponse;
part 'user_cubit.g.dart';
part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit(this._userRepository): super(InitialState());


  //was machen mit userList so wie beim client_cubit und test schreiben
  final UserRepository _userRepository;
  List<UserDTOReceive> _userList = [];
  int _skip = 0;

  Future<void> updateUser(UserDTOReceive user) async {

    emit(LoadingState());

    try {
      await _userRepository.updateUser(user);

      emit(UserUpdatedState());
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchUser(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      final user = await _userRepository.getUser(id);
      final userSend = UserDTOSend.fromDTOReceive(user);
      final userEntity = User.fromUserDTOSend(userSend);
      emit(UserFetchedState(user: userEntity));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> deleteUser(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      await _userRepository.deleteUser(id);
      emit(UserDeletedState());
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchUsers({Map<String, String>? query = const {}, bool pagination = false}) async {
    if (query == null) return;
    query['skip'] = '$_skip';
    emit(LoadingState());
    if(!pagination){
      _skip = 0;
      _userList = [];
    }
    try {
      UserResponse response = await _userRepository.getUsers(query);
      if(pagination){
        _skip = response.lastN;
      }
      if(response.userList.isEmpty){
        emit(NoMoreResultsState());
        return;
      }
      _userList += response.userList;
      emit(UserListFetchedState(userList: _userList, lastN: response.lastN));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> insertUser(User user) async {

    emit(LoadingState());

    try {
      final String id = await _userRepository.insertUser(user);

      emit(UserCreatedState(id: id));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    switch (json["state"]){
      case "InitialState": return InitialState();
      case "LoadingState": return LoadingState();
      case "UserDeletedState": return UserDeletedState();
      case "UserUpdatedState": return UserUpdatedState();
      case "UserFetchedState": return UserFetchedState.fromJson(json["class"]);
      case "UserCreatedState": return UserCreatedState.fromJson(json["class"]);
      case "UserListFetchedState": return UserListFetchedState.fromJson(json["class"]);
      case "FailureState": return FailureState.fromJson(json["class"]);
    }
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    switch (state.runtimeType){
      case UserCreatedState : return {"state": "UserCreatedState", "class": (state as UserCreatedState).toJson()};
      case UserFetchedState : return {"state": "UserFetchedState", "class": (state as UserFetchedState).toJson()};
      case UserListFetchedState : return {"state": "UserListFetchedState", "class":(state as UserListFetchedState).toJson()};
      case InitialState : return {"state": "InitialState"};
      case LoadingState : return {"state": "LoadingState"};
      case UserDeletedState : return {"state": "UserDeletedState"};
      case UserUpdatedState : return {"state": "UserUpdatedState"};
      case FailureState : return {"state": "FailureState", "class":(state as FailureState).toJson()};

      default : return {};
    }
  }
}
