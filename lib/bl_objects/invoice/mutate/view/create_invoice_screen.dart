import 'package:easyinvoice/bl_objects/invoice/mutate/client_bloc/client_select_cubit.dart';
import 'package:easyinvoice/bl_objects/invoice/mutate/invoice_modify_cubit.dart';
import 'package:easyinvoice/src/common_widgets/widgets/headline_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import 'package:invoice_api_client/items/models/item.dart';
import '../../view/widgets/create_invoice_progress_indicator.dart';
import '../../view/widgets/create_invoice_section.dart';
import '../items_bloc/item_management_bloc.dart';

class CreateInvoiceScreen extends StatelessWidget {
  const CreateInvoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool clientIsSelected = false;

    return BlocProvider(
      create: (_) => ClientSelectCubit(),
      child: BlocProvider(
        create: (_) => ItemManagementCubit(),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                          clientIsSelected = true;
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
                      CreateInvoiceSection(
                        completed: true,
                        titleText: "Items",
                        children: [
                          BlocBuilder<ItemManagementCubit, ItemManagementState>(
                              builder: (context, state) {
                            if (state is ItemAddedState ||
                                state is ItemDeletedState) {
                              print("Rebuilding item list");
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: context
                                            .read<ItemManagementCubit>()
                                            .items
                                            .length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: Container(
                                              decoration: const BoxDecoration(),
                                              child: Text("21x",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge),
                                            ),
                                            title: const Text("Screens"),
                                            subtitle: const Text(
                                                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et."),
                                            trailing: const Text(
                                              "\$22.29",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        }),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Item? item =
                                          await context.push('/item-list');
                                      if (item != null) {
                                        context
                                            .read<ItemManagementCubit>()
                                            .addItem(item);
                                      }
                                    },
                                    child: const Text("Add Item"),
                                  ),
                                ],
                              );
                            } else {
                              return TextButton(
                                onPressed: () async {
                                  Item? item = await context.push('/item-list');
                                  if (item != null) {
                                    context
                                        .read<ItemManagementCubit>()
                                        .addItem(item);
                                  }
                                },
                                child: const Text("Add Item"),
                              );
                            }
                          }),
                          Theme(
                            data: Theme.of(context),
                            child: const Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "122,58",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CreateInvoiceSection(
                        titleText: "Details",
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8, top: 8),
                                child: Text(
                                  "Invoice Date",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.color),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12)),
                                child: const ListTile(
                                  trailing: Icon(Icons.calendar_today_outlined),
                                  title: Text(
                                    "16.05.2022",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8, top: 32),
                                child: Text(
                                  "Payment Due",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.color),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12)),
                                child: const ListTile(
                                  trailing: Icon(Icons.calendar_today_outlined),
                                  title: Text(
                                    "16.05.2022",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      CreateInvoiceSection(
                        titleText: "Attachments",
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.attach_circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Add Attachment",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
