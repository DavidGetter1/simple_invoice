import 'package:easyinvoice/src/home/i18n/home_screen.i18n.dart';
import 'package:flutter/material.dart';

import 'invoice_status_tag.dart';
import '../../../bl_objects/invoice/view/widgets/recent_activity_tile.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Recent Activity".i18n,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: Text("SHOW ALL".i18n)),
            ],
          ),
        ),
        const RecentActivityTile(status: InvoiceStatus.Pending, delayInMs: 0),
        const RecentActivityTile(status: InvoiceStatus.Pending, delayInMs: 1000),
        const RecentActivityTile(status: InvoiceStatus.Overdue, delayInMs: 2000),
        const RecentActivityTile(status: InvoiceStatus.Paid, delayInMs: 1500),
      ],
    );
  }
}
