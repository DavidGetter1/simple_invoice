import 'package:easyinvoice/settings/account/profile/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../bl_objects/item/mutate/view/widgets/input_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserCubit>().updateUser();
          Future.delayed(const Duration(milliseconds: 100))
              .then((value) => context.pop());
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 8,
        child: const Icon(
          Icons.check,
          color: Colors.black,
          size: 24,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: const Text(
          'Erstellen',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFF1E1E1E),
            fontSize: 22,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InputField(
                  title: 'Name',
                  controller: context.read<UserCubit>().nameController,
                  validator: context.read<UserCubit>().validateName,
                ),
                const Divider(
                  thickness: 1,
                ),
                InputField(
                  title: 'Email',
                  controller: context.read<UserCubit>().emailController,
                  validator: context.read<UserCubit>().validateEmail,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
