import 'package:easyinvoice/src/common_widgets/widgets/headline_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unicons/unicons.dart';

class CreateInvoiceSection extends StatelessWidget {
  final String titleText;
  final List<Widget> children;
  final bool completed;

  const CreateInvoiceSection({Key? key, required this.titleText, this.children = const [], this.completed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          expandedAlignment: Alignment.center,
          initiallyExpanded: true,
          tilePadding: const EdgeInsets.all(0),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeadlineText(text: titleText),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: completed ? Icon(
                  UniconsSolid.check_circle,
                  color: Theme.of(context).primaryColor) :
                Icon(
                  UniconsLine.check_circle,
                  color: Theme.of(context).disabledColor),
              )
            ],
          ),
          children: children,
        ),
      ),
    );
  }
}
