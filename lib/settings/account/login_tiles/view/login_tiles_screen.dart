import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../authentication/authentication_bloc.dart';
import '../../../../authentication/authentication_event.dart';
import '../../../../authentication/authentication_state.dart';

class LoginTilesScreen extends StatelessWidget {
  const LoginTilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginTilesScreen"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () async => context.read<AuthenticationBloc>()
              ..add(LogInWithSocialLoginGoogle()),
            title: Text("login with google"),
          ),
          ListTile(
            onTap: () async => await context.read<AuthenticationBloc>()
              ..add(LogOut()),
            title: Text("signout"),
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: context.read<AuthenticationBloc>(),
              builder: (context, state) {
                return ListTile(
                  onTap: () async => context.read<AuthenticationBloc>()
                    ..add(LogInWithSocialLoginGoogle()),
                  title: Text("Authentication status:" + state.toString()),
                );
              }),
        ],
      ),
    );
  }
}
