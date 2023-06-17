import 'package:easyinvoice/bl_objects/invoice/mutate/invoice_modify_cubit.dart';
import 'package:easyinvoice/src/common_widgets/widgets/headline_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import '../../view/widgets/create_invoice_progress_indicator.dart';
import '../../view/widgets/create_invoice_section.dart';
import '../client_bloc/client_select_cubit.dart';

class CreateInvoiceScreen extends StatelessWidget {
  const CreateInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientSelectCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Invoice"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const CreateInvoiceProgressIndicator(),
              Expanded(
                child: ListView(
                  children: [
                    CreateInvoiceSection(
                      titleText: "Customer",
                      children: [
                        BlocBuilder<ClientSelectCubit, ClientSelectState>(
                          builder: (context, state) {
                            if (state is ClientSetState) {
                              // Render UI when client is added
                              return Column(
                                children: [
                                  Text(
                                    "Client: ${state.client.name}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  // Add more client-specific UI elements here
                                ],
                              );
                            } else {
                              // Render UI when client is not added
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.user_cirlce_add,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Client? client =
                                          await context.push('/client-list');
                                      if (client != null) {
                                        context
                                            .read<ClientSelectCubit>()
                                            .setClient(client);
                                      }
                                    },
                                    child: const Text(
                                      "Add Customer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    // Rest of your code...
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: null,
                  child: Text("Continue"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: null, //Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
