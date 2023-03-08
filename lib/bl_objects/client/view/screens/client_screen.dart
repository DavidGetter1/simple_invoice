import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../i18n/client_screen.i18n.dart';

import '../widgets/client_list_tile.dart';
import '../widgets/empty_client_button.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clients".i18n),
        leading: const Icon(Iconsax.search_normal_1),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Iconsax.profile_add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            ClientListTile(),
            ClientListTile(),
            ClientListTile(),
            ClientListTile(),
            EmptyClientButton(),
          ],
        ),
      ),
    );
  }
}
