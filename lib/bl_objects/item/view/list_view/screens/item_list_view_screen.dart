import 'package:bl_objects_repository/item/models/item.dart';
import 'package:easyinvoice/bl_objects/item/i18n/item_screen.i18n.dart';
import 'package:easyinvoice/bl_objects/item/modify/item_modify_cubit.dart'
    as item_modify_cubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../crud/item_cubit.dart';

class ItemListViewScreen extends StatelessWidget {
  const ItemListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ItemCubit>().refreshItemList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Items".i18n),
          actions: [
            InkWell(
              onTap: () {
                context
                    .read<item_modify_cubit.ItemModifyCubit>()
                    .resetControllers();
                context.push("/create-item");
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Iconsax.profile_add),
              ),
            )
          ],
        ),
        body: BlocListener<item_modify_cubit.ItemModifyCubit,
            item_modify_cubit.ItemModifyState>(
          bloc: context.read<item_modify_cubit.ItemModifyCubit>(),
          listener: (context, state) {
            if (state is item_modify_cubit.ItemModifiedState) {
              context.read<ItemCubit>().refreshItemList();
            }
          },
          child: BlocBuilder<ItemCubit, ItemState>(
              bloc: context.read<ItemCubit>(),
              builder: (context, state) {
                if (state is InitialState) {
                  return Container();
                }
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is OperationCompletedState) {
                  return ListView.builder(
                      itemCount: state.itemList.length,
                      itemBuilder: (context, index) {
                        final Item item = state.itemList[index];
                        return ListTile(
                            title: Text(item.title),
                            subtitle:
                                Text(item.description ?? "No description"),
                            onTap: () =>
                                context.push("/create-item", extra: item));
                      });
                }
                return Container();
              }),
        ));
  }
}
