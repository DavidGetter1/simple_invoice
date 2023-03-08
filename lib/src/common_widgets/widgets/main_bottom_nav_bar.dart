import 'package:easyinvoice/src/common_widgets/i18n/main_bottom_nav_bar.i18n.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MainBottomNavBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final int currentIndex;
  const MainBottomNavBar({Key? key, required this.onTap, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      onTap: onTap,
      currentIndex: currentIndex,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(label: "Home".i18n, icon: const Icon(Iconsax.home)),
        BottomNavigationBarItem(
            label: "Invoices".i18n, icon: const Icon(Iconsax.bill)),
        BottomNavigationBarItem(
            label: "Clients".i18n, icon: const Icon(Iconsax.people)),
        BottomNavigationBarItem(
            label: "Items".i18n, icon: const Icon(Iconsax.receipt_item)),
        BottomNavigationBarItem(
          label: "Settings".i18n,
          icon: const Icon(Iconsax.setting),
        ),
      ],
    );
  }
}
