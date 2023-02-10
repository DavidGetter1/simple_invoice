import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

class ItemResponse extends Equatable {
  final List<Item> itemList;
  final int lastN;
  ItemResponse({required this.itemList, required this.lastN});

  @override
  List<Object?> get props => [itemList, lastN];
}