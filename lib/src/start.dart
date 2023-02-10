import 'package:easyinvoice/authentication/authentication_cubit.dart';
import 'package:easyinvoice/bl_objects/item/item_cubit.dart';
import 'package:easyinvoice/src/common_widgets/main_bottom_nav_bar.dart';
import 'package:easyinvoice/src/features/clients/presentation/screens/client_screen.dart';
import 'package:easyinvoice/src/features/invoices/presentation/screens/home_screen.dart';
import 'package:easyinvoice/src/features/invoices/presentation/screens/invoice_screen.dart';
import 'package:easyinvoice/src/features/items/presentation/screens/item_screen.dart';
import 'package:easyinvoice/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

import '../bl_objects/client/client_cubit.dart';
import '../bl_objects/invoice/invoice_cubit.dart';
import '../bl_objects/user/user_cubit.dart';

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
          ItemScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: MainBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavBarTap),
    );
  }

  void _onBottomNavBarTap(int index) async{

    setState(() {
      _selectedIndex = index;
    });
  }
}
