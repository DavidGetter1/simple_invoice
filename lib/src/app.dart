import 'package:authentication/authentication.dart';
import 'package:bl_objects_repository/client/index.dart';
import 'package:bl_objects_repository/invoice/repository.dart';
import 'package:bl_objects_repository/item/repository.dart';
import 'package:bl_objects_repository/user/repository.dart';
import 'package:easyinvoice/authentication/authentication_cubit.dart';
import 'package:easyinvoice/src/features/invoices/presentation/screens/create_invoice_screen.dart';
import 'package:easyinvoice/src/features/invoices/presentation/screens/invoice_detail_screen.dart';
import 'package:easyinvoice/src/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../authentication/authentication_bloc.dart';
import '../bl_objects/client/client_cubit.dart';
import '../bl_objects/item/item_cubit.dart';
import '../bl_objects/invoice/invoice_cubit.dart';
import '../bl_objects/user/user_cubit.dart';
class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.authenticationRepository, required this.itemRepository, required this.clientRepository, required this.invoiceRepository, required this.userRepository}) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final InvoiceRepository invoiceRepository;
  final ItemRepository itemRepository;
  final ClientRepository clientRepository;
  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Start();
        },
      ),
      GoRoute(
        path: '/invoice-detail',
        builder: (BuildContext context, GoRouterState state) =>
            const InvoiceDetailScreen(),
      ),
      GoRoute(
        path: '/create-invoice',
        builder: (context, state) => const CreateInvoiceScreen(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider<ItemRepository>(
        create: (context) => ItemRepository(),
        ),
        RepositoryProvider<ClientRepository>(
          create: (context) => ClientRepository(),
        ),
        RepositoryProvider<InvoiceRepository>(
          create: (context) => InvoiceRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(authenticationRepository: context.read<AuthenticationRepository>(), userRepository: context.read<UserRepository>()),
        ),
        BlocProvider<ItemCubit>(
          create: (BuildContext context) => ItemCubit(context.read<ItemRepository>()),
        ),
        BlocProvider<ClientCubit>(
          create: (BuildContext context) => ClientCubit(context.read<ClientRepository>()),
        ),
        BlocProvider<InvoiceCubit>(
          create: (BuildContext context) => InvoiceCubit(context.read<InvoiceRepository>()),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(context.read<UserRepository>()),
        ),
      ],
      child: MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Invoice',
      theme: ThemeData(
        textTheme: GoogleFonts.signikaNegativeTextTheme(),
        //GoogleFonts.rubikTextTheme(),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        primarySwatch: Colors.deepPurple,
      ),
    )
    )
    );
  }
}
