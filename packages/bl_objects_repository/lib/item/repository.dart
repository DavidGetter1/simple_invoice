import 'package:invoice_api_client/items/item_api_client.dart';
import 'package:invoice_api_client/items/models/item.dart';

import '../repository/repository.dart';

/// Repository for [Item]s.
/// Injecting APiClient for testing purposes
class ItemRepository extends Repository<Item> {
  ItemRepository(ItemApiClient? itemApiClient)
      : super(apiClient: ItemApiClient());
}
