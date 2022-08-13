import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  int? selectedValue = 0;
  List<Widget> widgetSelection = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoices"),
        actions: [
          IconButton(onPressed: () => context.push("/create-invoice"), icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: CupertinoSlidingSegmentedControl(
              children: const {
                0: Text("Invoices"),
                1: Text("Offers"),
                2: Text("Overdue")
              },
              onValueChanged: (int? value)
              {
                setState(() {
                  selectedValue = value;
                });
              },
              groupValue: selectedValue,
            ),
          )
        ],
      ),
    );
  }
}
