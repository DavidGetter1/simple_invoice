import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  const HeadlineText({Key? key, required this.text, this.padding = EdgeInsets.zero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
