import 'package:flutter/material.dart';
import '../i18n/customize_invoice.i18n.dart';

class CustomizeInvoiceScreen extends StatelessWidget {
  const CustomizeInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CustomizeInvoiceScreen")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 64, 0, 0),
            child: ListTile(
              tileColor: Colors.red,
              onTap: () => Navigator.of(context).pop(),
              title: Text("Logo".i18n),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            alignment: Alignment.centerLeft,
            child: Text("Company".i18n,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
