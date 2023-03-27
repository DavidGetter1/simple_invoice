import 'package:bl_objects_repository/item/models/item.dart';
import 'package:easyinvoice/authentication/authentication_bloc.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../item_modify_cubit.dart';
import '../widgets/expandable_tile.dart';
import '../widgets/input_field.dart';

class CreateItemScreen extends StatelessWidget {
  const CreateItemScreen({Key? key, required this.item}) : super(key: key);

  final Item? item;

  @override
  Widget build(BuildContext context) {
    context.read<ItemModifyCubit>().initControllersFromItem(item);
    return Scaffold(
      key: context.read<ItemModifyCubit>().scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (item == null) {
            context.read<ItemModifyCubit>().insertItem();
          } else {
            context.read<ItemModifyCubit>().updateItem(item!);
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
          item != null
              ? InkWell(
                  onTap: () {
                    context.read<ItemModifyCubit>().deleteItem(item?.id);
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
              .requestFocus(context.read<ItemModifyCubit>().unfocusNode),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InputField(
                    title: 'Title',
                    controller: context.read<ItemModifyCubit>().titleController,
                    validator:
                        context.read<ItemModifyCubit>().validateDescription,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  InputField(
                    title: 'Price',
                    controller: context.read<ItemModifyCubit>().priceController,
                    validator: context.read<ItemModifyCubit>().validatePrice,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  InputField(
                    title: 'Description',
                    controller:
                        context.read<ItemModifyCubit>().descriptionController,
                    validator:
                        context.read<ItemModifyCubit>().validateDescription,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Expanded(
                    child: ExpandableTile(
                      widgetList: expandableTileContents(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> expandableTileContents(BuildContext context) {
  return [
    InputField(
      title: 'Tax',
      controller: context.read<ItemModifyCubit>().taxController,
      validator: context.read<ItemModifyCubit>().validateTax,
    ),
    InputField(
      title: 'Discount',
      controller: context.read<ItemModifyCubit>().discountController,
      validator: context.read<ItemModifyCubit>().validateDiscount,
    ),
  ];
}
