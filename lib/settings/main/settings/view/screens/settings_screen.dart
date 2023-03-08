import 'dart:io';

import 'package:easyinvoice/authentication/authentication_bloc.dart';
import 'package:easyinvoice/authentication/authentication_event.dart';
import 'package:easyinvoice/authentication/authentication_state.dart';
import 'package:easyinvoice/settings/main/i18n/settings_screen.i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../language/language_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Localizations.localeOf(context));
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".i18n),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      value: 1,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                      value: 0.6,
                    ),
                  ),
                  CircleAvatar(
                    maxRadius: MediaQuery.of(context).size.width / 3 / 2 - 16,
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150?img=13"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text("60 %",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.deepPurple)),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.centerLeft,
              child: Text("Settings".i18n,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.centerLeft,
              child: Text("Account".i18n,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              tileColor: Colors.red,
              onTap: () => context.push("/profile"),
              title: Text("Profile".i18n),
            ),
            ListTile(
              onTap: () => context.push("/login"),
              title: Text("Login".i18n),
            ),
            ListTile(
              onTap: () => context.push("/region"),
              title: Text("Region".i18n),
            ),
            ListTile(
              tileColor: Colors.red,
              onTap: () => context.push("/notifications"),
              title: Text("Notifications".i18n),
            ),
            ListTile(
              tileColor: Colors.red,
              onTap: () => context.push("/upgrade"),
              title: Text("Upgrade".i18n),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.centerLeft,
              child: Text("Invoice".i18n,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              onTap: () => context.push("/customize-invoice"),
              title: Text("Customize".i18n),
            ),
          ],
        ),
      ),
    );
  }
}
