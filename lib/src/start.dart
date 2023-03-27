import 'package:easyinvoice/src/common_widgets/widgets/main_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../bl_objects/client/view/screens/client_screen.dart';
import '../bl_objects/item/view/list_view/screens/item_list_view_screen.dart';
import '../settings/main/settings/view/screens/settings_screen.dart';
import 'home/screens/home_screen.dart';
import '../bl_objects/invoice/view/screens/invoice_screen.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeScreen(),
          InvoiceScreen(),
          ClientScreen(),
          ItemListViewScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: MainBottomNavBar(
          currentIndex: _selectedIndex, onTap: _onBottomNavBarTap),
    );
  }

  void _onBottomNavBarTap(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }
}
