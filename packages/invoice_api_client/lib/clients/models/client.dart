import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../complementary_models/address.dart';

part 'client.g.dart';

@JsonSerializable(explicitToJson: true)
class Client extends Equatable {
  final String? id;
  final String? userId;
  final String? name;
  final Address? address;
  final String? phoneNumber;
  final String? email;
  final DateTime? creationDate;
  final DateTime? modifiedDate;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  Client(
      {this.userId,
      this.name,
      this.address,
      this.phoneNumber,
      this.email,
      this.creationDate,
      this.modifiedDate,
      this.id});

  Client copyWth(
      {String? userId,
      String? id,
      String? name,
      String? streetName,
      String? streetNumber,
      String? zipCode,
      String? city,
      String? phoneNumber,
      DateTime? creationDate,
      DateTime? modifiedDate,
      String? email}) {
    return Client(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        creationDate: this.creationDate,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email);
  }

  @override
  List<Object?> get props =>
      [userId, name, phoneNumber, email, modifiedDate, creationDate, id];
}
