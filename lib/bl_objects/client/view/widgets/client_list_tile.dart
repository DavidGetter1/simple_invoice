import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unicons/unicons.dart';
import '../../i18n/client_screen.i18n.dart';

class ClientListTile extends StatelessWidget {
  const ClientListTile({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.arrow_forward_ios_rounded),
        ),
        leading: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          child: Text("Ma", style: Theme.of(context).textTheme.headline5,),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24)),
        ),
        title: const Text(
          "Max Mustermann",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Last invoice".i18n + ": 05.06.2022"),
      ),
    );
  }
}