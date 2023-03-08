import 'package:easyinvoice/src/common_widgets/widgets/headline_text.dart';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../widgets/create_invoice_progress_indicator.dart';
import '../widgets/create_invoice_section.dart';

class CreateInvoiceScreen extends StatelessWidget {
  const CreateInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Invoice"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const CreateInvoiceProgressIndicator(),
            Expanded(
              child: ListView(
                children: [
                  CreateInvoiceSection(
                    titleText: "Customer",
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Icon(Iconsax.user_cirlce_add,color: Theme.of(context).primaryColor,),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Add Customer",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),),

                        ],
                      ),
                    ],
                  ),
                  CreateInvoiceSection(
                    completed: true,
                    titleText: "Items",
                    children: [ListTile(
                        leading: Container(
                          decoration: const BoxDecoration(),
                          child:
                              Text("2x", style: Theme.of(context).textTheme.titleLarge),
                        ),
                        title: const Text("Logo Design"),
                        trailing: const Text(
                          "\$100.29",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: Theme.of(context),
                        child: const Divider(
                          height: 8,
                          indent: 64,),
                      ),
                      ListTile(
                        leading: Container(
                          decoration: const BoxDecoration(),
                          child:
                              Text("21x", style: Theme.of(context).textTheme.titleLarge),
                        ),
                        title: const Text("Screens"),
                        subtitle: const Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et."),
                        trailing: const Text(
                          "\$22.29",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(onPressed: (){}, child: const Text("Add Item",style: TextStyle(fontWeight: FontWeight.bold),)),
                      Theme(
                        data: Theme.of(context),
                        child: const Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",style: Theme.of(context).textTheme.titleLarge),
                            Text("122,58",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  CreateInvoiceSection(
                    titleText: "Details",
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Padding(
                            padding: const EdgeInsets.only(bottom: 8,top: 8),
                            child: Text("Invoice Date",style: TextStyle(color: Theme.of(context).textTheme.labelMedium?.color),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)),
                            child: const ListTile(
                              trailing: Icon(Icons.calendar_today_outlined),
                              title: Text(
                                "16.05.2022",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8,top: 32),
                            child: Text("Payment Due",style: TextStyle(color: Theme.of(context).textTheme.labelMedium?.color),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)),
                            child: const ListTile(
                              trailing: Icon(Icons.calendar_today_outlined),
                              title: Text(
                                "16.05.2022",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CreateInvoiceSection(titleText: "Attachments",children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Icon(Iconsax.attach_circle,color: Theme.of(context).primaryColor,),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Add Attachment",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),),

                      ],
                    ),
                  ],),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(onPressed: null, child: Text("Continue"),style: OutlinedButton.styleFrom(
                  backgroundColor: null,//Theme.of(context).primaryColor,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
