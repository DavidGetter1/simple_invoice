import 'package:flutter/material.dart';

class ActivityUpdate extends StatelessWidget {
  final bool highlight;
  final bool showLine;
  final String title;
  final String subtitle;
  const ActivityUpdate({
    Key? key, this.highlight = false, required this.title, required this.subtitle, this.showLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                /*
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                 */
                child: highlight ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 6,
                  shadowColor: Theme.of(context).primaryColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 8,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 5,
                    ),
                  ),
                ) : const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 6,
                  ),
                ),
              ),
              if(showLine)
              Expanded(child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 2,
                decoration: highlight ? BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).disabledColor,
                      Theme.of(context).primaryColor.withOpacity(0.5),
                      Theme.of(context).primaryColor,
                    ],
                  )
                ) : const BoxDecoration(
                  color: Colors.grey,
                ),
              ))
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text(subtitle,style: Theme.of(context).textTheme.bodyText2,),
                  const Padding(padding: EdgeInsets.all(32)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}