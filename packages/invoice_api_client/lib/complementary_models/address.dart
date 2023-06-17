import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address extends Equatable {
  final String? streetName;
  final String? streetNumber;
  final String? zipCode;
  final String? city;
  final String? state;
  final String? country;
  final DateTime? creationDate;
  final List<DateTime>? modifiedDates;

  Address({
    this.streetName,
    this.streetNumber,
    this.zipCode,
    this.city,
    this.state,
    this.country,
    this.creationDate,
    this.modifiedDates,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [
        city,
        zipCode,
        streetName,
        streetNumber,
        state,
        country,
        creationDate,
        modifiedDates
      ];
}
