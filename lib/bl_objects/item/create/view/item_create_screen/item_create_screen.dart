
import 'package:easyinvoice/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../item_create_cubit.dart';


class CreateItemScreen extends StatelessWidget {
  const CreateItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Making sure i always get the correct user id.
    context.read<AuthenticationBloc>().UserId.listen((id) {
      context.read<ItemCreateCubit>().setUserId(id);
    });
    return Scaffold(
      key: context.read<ItemCreateCubit>().scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ItemCreateCubit>()..insertItem();
        },
        backgroundColor: Theme
            .of(context)
            .primaryColor,
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
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 24,
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
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(context.read<ItemCreateCubit>().unfocusNode),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: context.read<ItemCreateCubit>().validateTitle,
                        controller: context
                            .read<ItemCreateCubit>()
                            .titleController,
                        autofocus: true,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'title',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),

                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: context.read<ItemCreateCubit>().validatePrice,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        controller: context
                            .read<ItemCreateCubit>()
                            .priceController,
                        autofocus: true,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'price',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: context
                            .read<ItemCreateCubit>()
                            .descriptionController,
                        autofocus: true,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'description',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Spacer(flex: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
