import 'package:easyinvoice/bl_objects/item/i18n/item_screen.i18n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);

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
    );
  }
}
