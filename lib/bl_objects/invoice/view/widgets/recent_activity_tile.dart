import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../../../src/home/widgets/invoice_status_tag.dart';

class RecentActivityTile extends StatelessWidget {
  final InvoiceStatus status;
  final int delayInMs;
  const RecentActivityTile({
    Key? key, required this.status, required this.delayInMs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: delayInMs),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          onTap: () => _onTap(context),
          trailing: InvoiceStatusTag(status: status),
          leading: Container(
            width: 60,
            height: 60,
            child: const Icon(
              UniconsLine.user,
              size: 40,
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24)),
          ),
          title: const Text(
            "377,65 €",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Max Mustermann"),
              Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Text("25.04.2022"),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onTap(BuildContext context) {
    context.push("/invoice-detail");
  }
}