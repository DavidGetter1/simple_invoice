import 'package:flutter/material.dart';

class CreateInvoiceProgressIndicator extends StatelessWidget {
  const CreateInvoiceProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomAppBarColor,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          _ProgressSection(index: 1, title: "Details", isActive: true,),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(),
          )),
          _ProgressSection(index: 2, title: "Optional"),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(),
          )),
          _ProgressSection(index: 1, title: "Customize"),
        ],
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final int index;
  final String title;
  final bool isActive;

  const _ProgressSection(
      {Key? key,
      required this.index,
      required this.title,
      this.isActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(isActive) CircleAvatar(
          radius: 10,
          child: Text(
            "$index",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        )
        else
          CircleAvatar(
            backgroundColor: Theme.of(context).disabledColor,
            radius: 10,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              radius: 8,
              child: Text(
                "$index",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(title,
              style: TextStyle(
                  fontSize: 12,
                  color: !isActive ? Theme.of(context).disabledColor : null)),
        ),
      ],
    );
  }
}
