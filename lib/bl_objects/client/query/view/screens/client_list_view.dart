import 'package:easyinvoice/bl_objects/client/mutate/client_mutate_cubit.dart'
    as client_mutate_cubit;
import 'package:easyinvoice/bl_objects/client/query/client_query_cubit.dart';
import 'package:easyinvoice/bl_objects/item/i18n/item_screen.i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:invoice_api_client/clients/models/client.dart';

class ClientListViewScreen extends StatelessWidget {
  const ClientListViewScreen({Key? key, this.source}) : super(key: key);
  final String? source;
  @override
  Widget build(BuildContext context) {
    context.read<ClientQueryCubit>().refreshClientList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Clients".i18n),
          actions: [
            InkWell(
              onTap: () {
                context
                    .read<client_mutate_cubit.ClientMutateCubit>()
                    .resetControllers();
                context.push("/create-client");
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Iconsax.profile_add),
              ),
            )
          ],
        ),
        body: BlocListener<client_mutate_cubit.ClientMutateCubit,
            client_mutate_cubit.ClientMutateState>(
          bloc: context.read<client_mutate_cubit.ClientMutateCubit>(),
          listener: (context, state) {
            if (state is client_mutate_cubit.ClientMutatedState) {
              context.read<ClientQueryCubit>().refreshClientList();
            }
          },
          child: BlocBuilder<ClientQueryCubit, ClientQueryState>(
              bloc: context.read<ClientQueryCubit>(),
              builder: (context, state) {
                if (state is InitialState) {
                  return Container();
                }
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is OperationCompletedState) {
                  return ListView.builder(
                      itemCount: state.clientList.length,
                      itemBuilder: (context, index) {
                        final Client client = state.clientList[index];
                        return ListTile(
                            title: Text(client.name ?? "No name"),
                            subtitle: Text(client.email ?? "No mail"),
                            onTap: () {
                              if (context.canPop()) {
                                context.pop(client);
                              } else {
                                context.push("/create-client", extra: client);
                              }
                            });
                      });
                }
                return Container();
              }),
        ));
  }
}
