import 'package:easyinvoice/src/common_widgets/widgets/headline_text.dart';
import 'package:flutter/material.dart';

import '../../../../src/common_widgets/widgets/activity_update.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Invoice"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 10,
                      backgroundImage: const NetworkImage("https://i.pravatar.cc/150?img=13"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                    child: Text("Max Mustermann", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),),
                  ),
                  const Text("max@mustermann.de")
                ],
              ),
            ),
            const HeadlineText(
              padding: EdgeInsets.only(top: 16),
                text: "Invoice"),
            Column(
              children: [
                ListTile(
                  leading: Container(
                    decoration: BoxDecoration(),
                    child:
                    Text("2x", style: Theme.of(context).textTheme.titleLarge),
                  ),
                  title: Text("Logo Design"),
                  trailing: Text(
                    "\$100.29",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Theme(
                  data: Theme.of(context),
                  child: Divider(
                    height: 8,
                    indent: 64,),
                ),
                ListTile(
                  leading: Container(
                    decoration: BoxDecoration(),
                    child:
                    Text("21x", style: Theme.of(context).textTheme.titleLarge),
                  ),
                  title: Text("Screens"),
                  subtitle: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et."),
                  trailing: Text(
                    "\$22.29",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Theme(
                  data: Theme.of(context),
                  child: Divider(),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: const HeadlineText(text: "Activity"),
            ),
            const ActivityUpdate(highlight: true,title: "Rechnung bezahlt",subtitle: "24.05.2022",),
            const ActivityUpdate(title: "Rechnung fällig",subtitle: "23.05.2022",),
            const ActivityUpdate(showLine: false,title: "Rechnung erstellt",subtitle: "02.05.2022",),


          ],
        ),
      ),
    );
  }
}

