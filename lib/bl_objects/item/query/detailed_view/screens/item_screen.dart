import 'package:easyinvoice/bl_objects/item/i18n/item_screen.i18n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:invoice_api_client/items/models/item.dart';

class ItemScreen extends StatelessWidget {
  final Item item;

  const ItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items".i18n),
        actions: [
          InkWell(
            onTap: () => context.push("/create-item"),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Iconsax.profile_add),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Price per unit: ${item.pricePerUnit ?? '-'}",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Description: ${item.description ?? '-'}",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Tax: ${item.tax ?? '-'}",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Discount: ${item.discount ?? '-'}",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
