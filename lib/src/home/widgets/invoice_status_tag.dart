import 'package:easyinvoice/src/home/i18n/home_screen.i18n.dart';
import 'package:flutter/material.dart';

enum InvoiceStatus {
  Pending,
  Overdue,
  Paid,
}

class InvoiceStatusTag extends StatelessWidget {
  final InvoiceStatus status;

  const InvoiceStatusTag({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case InvoiceStatus.Paid:
        color = Colors.green;
        text = "Paid".i18n;
        break;
      case InvoiceStatus.Overdue:
        color = Colors.red;
        text = "Overdue".i18n;
        break;
      case InvoiceStatus.Pending:
        color = Colors.orange;
        text = "Pending".i18n;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24)),
    );
  }
}
