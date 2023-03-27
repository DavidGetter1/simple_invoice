import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invoice_api_client/invoice_api_client.dart';

/// Exception thrown when locationSearch fails.
class UserIdRequestFailure implements Exception {
  String message;
  UserIdRequestFailure(this.message);
}

class UserApiClient {
  UserApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  // If you want to test it locally, then the _baseUrl is = 'localhost:5001' for example
  // otherwise for deployment its us-central1-invoice-c63dc.cloudfunctions.net
  // also if you doing it locally, change the Uri.https to http if needed.
  // the path looks like this then: '/invoice-c63dc/us-central1/ms_bl_objects/v1/bl_objects/user
  // when deploying its simply 'api/v1/bl_objects/user'
  // dont forget to adjust http correctly
  static const _baseUrl =
      '10.0.2.2:5001/invoice-c63dc/us-central1/ms_bl_objects';
  final http.Client _httpClient;

  getOrCreateUser(String id) async {
    final userRequest = Uri.parse(
        'http://' + _baseUrl + '/v1/bl_objects/user_find_or_create/$id');
    final userResponse = await _httpClient.get(userRequest);

    if (userResponse.statusCode != 200) {
      throw UserIdRequestFailure(userResponse.body.toString());
    }

    final userJson = jsonDecode(userResponse.body);
    print(userJson);

    if (userJson == {}) {
      throw new Exception('No users found');
    }

    try {
      UserDTO user = UserDTO.fromJson(userJson as Map<String, dynamic>);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  /**
   * Deletes an [UserDTO] by ID.
   */
  deleteUser(String id) async {
    final userRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/user/$id',
    );
    final userResponse = await _httpClient.delete(userRequest);
    if (userResponse.statusCode != 200) {
      throw Exception(userResponse.body);
    }

    final userJson = jsonDecode(userResponse.body);

    if (userJson["deletedCount"] != 1) {
      throw new Exception('No users deleted');
    }
  }

  /**
   * Fetches an [UserDTO] by ID.
   */
  dynamic getUserById(String id) async {
    final userRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/user/$id',
    );
    final userResponse = await _httpClient.get(userRequest);

    print(userResponse.body);
    if (userResponse.statusCode != 200) {
      throw UserIdRequestFailure(userResponse.body.toString());
    }

    final userJson = jsonDecode(userResponse.body);
    print(userJson);

    if (userJson == {}) {
      throw new Exception('No users found');
    }

    try {
      UserDTO user = UserDTO.fromJson(userJson as Map<String, dynamic>);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  /**
   * Queries the DB for users.
   */
  dynamic getUsers(Map<String, String> query) async {
    jsonEncode(query);
    final userRequest = Uri.https(_baseUrl, '/api/v1/bl_objects/user', query);
    final userResponse = await _httpClient.get(userRequest);
    if (userResponse.statusCode != 200) {
      throw new Exception(userResponse.body);
    }

    final userJson = jsonDecode(userResponse.body);
    if (userJson["data"].isEmpty) {
      throw new Exception('No users found');
    }
    try {
      List<UserDTO> userList = List<UserDTO>.from(
          userJson["data"].map((user) => UserDTO.fromJson(user)).toList());
      return {"userList": userList, "lastN": userJson["lastN"]};
    } catch (e) {
      print(e.toString());
    }
  }

  /**
   * Inserts the [UserDTO] into the DB.
   */
  insertUser(UserDTO user) async {
    final userRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/user',
    );
    String userJson = jsonEncode(user.toJson());
    final userResponse = await _httpClient.put(userRequest,
        body: userJson, headers: {"Content-Type": "application/json"});
    print(userResponse.body);
    if (userResponse.statusCode != 201) {
      throw Exception(userResponse.body);
    }
    final decodedResponse = jsonDecode(userResponse.body);
    return decodedResponse["upsertedId"];
  }

  /**
   * Inserts the [UserDTO] into the DB.
   */
  updateUser(UserDTO user) async {
    final userRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/user',
    );
    String userJson = jsonEncode(user.toJson());
    final userResponse = await _httpClient.put(userRequest,
        body: userJson, headers: {"Content-Type": "application/json"});
    if (userResponse.statusCode != 200) {
      throw Exception(userResponse.body);
    }

    final responseJson = jsonDecode(userResponse.body);
    final bool updated = responseJson["modifiedCount"] == 1;
    if (!updated) {
      throw new Exception('No users updated');
    }
  }
}
