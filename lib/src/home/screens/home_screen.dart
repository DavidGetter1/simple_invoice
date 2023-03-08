import 'package:easyinvoice/src/home/i18n/home_screen.i18n.dart';
import 'package:easyinvoice/src/home/widgets/recent_activity.dart';
import 'package:easyinvoice/src/home/widgets/recent_clients.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:iconsax/iconsax.dart';

import '../../../bl_objects/invoice/view/widgets/revenue_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Latest".i18n),
        leading: const Icon(Iconsax.notification),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: const RevenueChart(),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          maxRadius: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.deepPurple.withOpacity(0.2),
                          maxRadius: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.deepPurple.withOpacity(0.2),
                          maxRadius: 4,
                        ),
                      ),
                    ],
                  ),
                const RecentClients(),
                const RecentActivity()
                ],
              )
            ],
          )),
    );
  }
}
