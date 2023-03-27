import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/items/models/itemDTO.dart';

class ItemResponse extends Equatable {
  final List<ItemDTO> itemList;
  final int lastN;
  ItemResponse({required this.itemList, required this.lastN});

  @override
  List<Object?> get props => [itemList, lastN];
}
