import 'package:dotted_border/dotted_border.dart';
import 'package:easyinvoice/src/home/i18n/home_screen.i18n.dart';
import 'package:flutter/material.dart';

class RecentClients extends StatelessWidget {
  const RecentClients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Recent Clients".i18n,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: Text("SHOW ALL".i18n)),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              child: DottedBorder(
                borderType: BorderType.Circle,
                padding: const EdgeInsets.all(16),
                strokeWidth: 2,
                dashPattern: const [4,8],
                strokeCap: StrokeCap.round,
                color: Colors.grey,
                child: const Icon(Icons.add),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                minRadius: 30,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=13"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                minRadius: 30,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=17"),
              ),
            ),
            /*
                      Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(left: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: NetworkImage("https://i.pravatar.cc/150?img=8"))
                        ),
                      ),

                       */
          ],
        ),
      ],
    );
  }
}
