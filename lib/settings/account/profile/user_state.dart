
part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class InitialState extends UserState {}

class LoadingState extends UserState {}

class UserDeletedState extends UserState {}

class UserUpdatedState extends UserState {}

class NoMoreResultsState extends UserState {}

@JsonSerializable()
class UserCreatedState extends UserState{

  final String id;
  const UserCreatedState({required this.id});

  factory UserCreatedState.fromJson(Map<String, dynamic> json) =>
      _$UserCreatedStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreatedStateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFetchedState extends UserState {
  final User user;
  const UserFetchedState({required this.user});

  factory UserFetchedState.fromJson(Map<String, dynamic> json) =>
      _$UserFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserFetchedStateToJson(this);

  @override
  List<Object?> get props => [user];
}

@JsonSerializable(explicitToJson: true)
class UserListFetchedState extends UserState {
  final int lastN;
  final List<User> userList;
  const UserListFetchedState({required this.userList, required this.lastN});

  factory UserListFetchedState.fromJson(Map<String, dynamic> json) =>
      _$UserListFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserListFetchedStateToJson(this);

  @override
  List<Object?> get props => [userList];
}

@JsonSerializable()
class FailureState extends UserState {
  final String errorMessage;
  const FailureState({required this.errorMessage});

  factory FailureState.fromJson(Map<String, dynamic> json) =>
      _$FailureStateFromJson(json);

  Map<String, dynamic> toJson() => _$FailureStateToJson(this);
}

