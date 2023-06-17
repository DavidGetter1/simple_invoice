import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

import 'models/user.dart';
import 'models/userResponse.dart';

class UserFailure implements Exception {}

class UserRepository {
  UserRepository({UserApiClient? userApiClient})
      : _userApiClient = userApiClient ?? UserApiClient() {}

  late User _currentUser;

  User get currentUser => _currentUser;

  final UserApiClient _userApiClient;
  late AuthenticationRepository _authenticationRepository;

  String _id = 'uninitialized';

  void setAuthenticationRepository(
      AuthenticationRepository authenticationRepository) {
    _authenticationRepository = authenticationRepository;
    _authenticationRepository.userId.listen(_onUserIdChanged);
  }

  Future<void> _onUserIdChanged(String id) async {
    if (_id == id) return;
    _id = id;
    _currentUser = await getOrCreateUser(_id);
  }

  Future<User> getUser(String id) async {
    UserDTO user = await _userApiClient.getUserById(id);
    User transformedUser = User.fromUserDTO(user);
    return transformedUser;
  }

  Future<User> getOrCreateUser(String id) async {
    UserDTO user = await _userApiClient.getOrCreateUser(id);
    User transformedUser = User.fromUserDTO(user);
    return transformedUser;
  }

  Future<UserResponse> getUsers(Map<String, String> query) async {
    Map<String, dynamic> responseMap = await _userApiClient.getUsers(query);
    UserResponse userResponse = UserResponse(
        userList:
            responseMap["userList"].map((e) => User.fromUserDTO(e)).toList(),
        lastN: responseMap["lastN"]);
    return userResponse;
  }

  deleteUser(String id) async {
    await _userApiClient.deleteUser(id);
  }

  Future<String> insertUser(
      String id,
      String name,
      BillingInformation billingInformation,
      Locale locale,
      String email,
      bool hasPremium) async {
    UserDTO userDTO = UserDTO(
        id: id,
        name: name,
        billingInformation: billingInformation,
        locale: locale,
        email: email,
        hasPremium: hasPremium);
    String insertedId = await _userApiClient.insertUser(userDTO);
    return insertedId;
  }

  updateBillingInformation(
      String id, BillingInformation billingInformation) async {
    await _userApiClient.updateBillingInformation(id, billingInformation);
  }

  updateUser(String id, String name, String email) async {
    UserDTO userDTO = UserDTO(id: id, name: name, email: email);
    await _userApiClient.updateUser(userDTO);
  }
}
