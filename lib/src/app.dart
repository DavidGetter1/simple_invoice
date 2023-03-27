import 'package:authentication/authentication.dart';
import 'package:bl_objects_repository/client/index.dart';
import 'package:bl_objects_repository/invoice/repository.dart';
import 'package:bl_objects_repository/item/models/item.dart';
import 'package:bl_objects_repository/item/repository.dart';
import 'package:bl_objects_repository/user/repository.dart';
import 'package:easyinvoice/settings/customize_invoice/view/customize_invoice_screen.dart';
import 'package:easyinvoice/src/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../authentication/authentication_bloc.dart';
import '../bl_objects/client/client_cubit.dart';
import '../bl_objects/invoice/view/screens/create_invoice_screen.dart';
import '../bl_objects/invoice/view/screens/invoice_detail_screen.dart';
import '../bl_objects/item/crud/item_cubit.dart';
import '../bl_objects/invoice/invoice_cubit.dart';
import '../bl_objects/item/modify/item_modify_cubit.dart';
import '../bl_objects/item/modify/view/item_modify_screen/item_modify_screen.dart';
import '../bl_objects/item/view/detailed_view/screens/item_screen.dart';
import '../bl_objects/user/user_cubit.dart';
import '../settings/account/login_tiles/view/login_tiles_screen.dart';
import '../settings/account/region/view/region.dart';
import '../settings/main/language/language_cubit.dart';
import '../settings/main/language/language_states.dart';

class MyApp extends StatelessWidget {
  MyApp(
      {Key? key,
      required this.authenticationRepository,
      required this.itemRepository,
      required this.clientRepository,
      required this.invoiceRepository,
      required this.userRepository})
      : super(key: key);

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
          return I18n(child: const Start());
        },
      ),
      GoRoute(
        path: '/invoice-detail',
        builder: (BuildContext context, GoRouterState state) =>
            I18n(child: const InvoiceDetailScreen()),
      ),
      GoRoute(
        path: '/create-invoice',
        builder: (context, state) => I18n(child: const CreateInvoiceScreen()),
      ),
      GoRoute(
        path: '/create-item',
        builder: (context, state) =>
            I18n(child: CreateItemScreen(item: state.extra as Item?)),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => I18n(child: const LoginTilesScreen()),
      ),
      GoRoute(
        path: '/region',
        builder: (context, state) => I18n(child: const RegionScreen()),
      ),
      GoRoute(
        path: '/customize-invoice',
        builder: (context, state) =>
            I18n(child: const CustomizeInvoiceScreen()),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authenticationRepository),
          RepositoryProvider.value(
              value: itemRepository
                ..setAuthenticationRepository(authenticationRepository)),
          RepositoryProvider.value(value: clientRepository),
          RepositoryProvider.value(value: invoiceRepository),
          RepositoryProvider.value(
              value: userRepository
                ..setAuthenticationRepository(authenticationRepository))
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (BuildContext context) => AuthenticationBloc(
                    authenticationRepository:
                        context.read<AuthenticationRepository>(),
                    userRepository: context.read<UserRepository>()),
              ),
              BlocProvider<ItemCubit>(
                  create: (BuildContext context) =>
                      ItemCubit(context.read<ItemRepository>())),
              BlocProvider<ItemModifyCubit>(
                create: (BuildContext context) =>
                    ItemModifyCubit(context.read<ItemRepository>()),
              ),
              BlocProvider<ClientCubit>(
                create: (BuildContext context) =>
                    ClientCubit(context.read<ClientRepository>()),
              ),
              BlocProvider<InvoiceCubit>(
                create: (BuildContext context) =>
                    InvoiceCubit(context.read<InvoiceRepository>()),
              ),
              BlocProvider<UserCubit>(
                lazy: false,
                create: (BuildContext context) =>
                    UserCubit(context.read<UserRepository>()),
              ),
              BlocProvider<I18nCubit>(
                create: (BuildContext context) => I18nCubit(),
              ),
            ],
            child: BlocBuilder<I18nCubit, I18nState>(
              builder: (context, state) => MaterialApp.router(
                locale: state.locale,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', "US"),
                  Locale('de', "DE"),
                ],
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
              ),
            )));
  }
}
