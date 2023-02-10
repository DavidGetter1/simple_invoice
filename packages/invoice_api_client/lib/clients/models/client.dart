import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable(explicitToJson: true)
class Client extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String streetName;
  final String streetNumber;
  final String postalCode;
  final String city;
  final String phoneNumber;
  final String email;
  final DateTime creationDate;
  final DateTime modifiedDate;

  factory Client.fromJson(Map<String, dynamic> json) =>
      _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  Client({
      required this.userId,
      required this.name,
      required this.streetName,
      required this.streetNumber,
      required this.postalCode,
      required this.city,
      required this.phoneNumber,
      required this.email,
      required this.creationDate,
      required this.modifiedDate,
      required this.id
  });

  Client copyWth({
    String? userId,
    String? id,
    String? name,
    String? streetNumber,
    String? streetName,
    String? city,
    String? postalCode,
    String? phoneNumber,
    DateTime? creationDate,
    DateTime? modifiedDate,
    String? email
  }){
    return Client(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        creationDate: this.creationDate,
        name: name ?? this.name,
        streetName: streetName ?? this.streetName,
        postalCode: postalCode ?? this.postalCode,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        city: city ?? this.city,
        streetNumber: streetNumber ?? this.streetNumber,
        email: email ?? this.email
    );
}
  @override
  List<Object?> get props => [userId, name, streetName, streetNumber, postalCode, city, phoneNumber, email, modifiedDate, creationDate, id];
}