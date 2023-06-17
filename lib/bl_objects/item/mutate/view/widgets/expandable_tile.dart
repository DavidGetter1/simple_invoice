import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableTile extends StatelessWidget {
  const ExpandableTile({Key? key, required this.widgetList}) : super(key: key);

  final List<Widget> widgetList;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Expandable(
        // <-- Driven by ExpandableController from ExpandableNotifier
        collapsed: ExpandableButton(
          child: Container(
              height: 25,
              child: Center(
                child: Text(
                  'advanced options',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )),
        ), // <-- Expands when tapped on the cover photo
        expanded: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          ...widgetList,
          ExpandableButton(
            // <-- Collapses when tapped on
            child: Text(
              'show less',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
