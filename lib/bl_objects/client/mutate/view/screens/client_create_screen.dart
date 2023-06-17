import 'package:easyinvoice/authentication/authentication_bloc.dart';
import 'package:easyinvoice/bl_objects/client/mutate/client_mutate_cubit.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import 'package:provider/provider.dart';
import '../../../../item/mutate/view/widgets/input_field.dart';

class ModifyClientScreen extends StatelessWidget {
  const ModifyClientScreen({Key? key, required this.client}) : super(key: key);

  final Client? client;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    context.read<ClientMutateCubit>().initControllerFromClient(client);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          if (client == null) {
            context.read<ClientMutateCubit>().insertClient();
          } else {
            context.read<ClientMutateCubit>().updateClient(client!);
          }
          Future.delayed(Duration(milliseconds: 500))
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
        actions: [
          client != null
              ? InkWell(
                  onTap: () {
                    context.read<ClientMutateCubit>().deleteClient(client?.id);
                    context.pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.delete),
                  ),
                )
              : Container()
        ],
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context)
              .requestFocus(context.read<ClientMutateCubit>().unfocusNode),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField(
                      title: 'Name',
                      controller:
                          context.read<ClientMutateCubit>().nameController,
                      validator: context.read<ClientMutateCubit>().validateName,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InputField(
                      title: 'Email',
                      controller:
                          context.read<ClientMutateCubit>().emailController,
                      validator:
                          context.read<ClientMutateCubit>().validateEmail,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InputField(
                      type: TextInputType.number,
                      title: 'Phone Number',
                      controller: context
                          .read<ClientMutateCubit>()
                          .phoneNumberController,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
