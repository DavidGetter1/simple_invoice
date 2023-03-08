import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../i18n/client_screen.i18n.dart';

class EmptyClientButton extends StatelessWidget {
  const EmptyClientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: [8, 6],
        color: Colors.grey,
        radius: const Radius.circular(24),
        child:  ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: ListTile(
            title: Text(
              "Add client".i18n,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Tap here or on the top right".i18n),
          ),
        ),
      ),
    );
  }
}
