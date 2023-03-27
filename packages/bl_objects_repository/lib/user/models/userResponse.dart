import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

import 'user.dart';

class UserResponse extends Equatable {
  final List<User> userList;
  final int lastN;
  UserResponse({required this.userList, required this.lastN});

  @override
  List<Object?> get props => [userList, lastN];
}
