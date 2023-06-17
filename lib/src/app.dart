import 'package:authentication/authentication.dart';
import 'package:bl_objects_repository/client/index.dart';
import 'package:bl_objects_repository/invoice/repository.dart';
import 'package:bl_objects_repository/item/repository.dart';
import 'package:bl_objects_repository/user/repository.dart';
import 'package:easyinvoice/bl_objects/client/mutate/view/screens/client_create_screen.dart';
import 'package:easyinvoice/settings/customize_invoice/view/customize_invoice_screen.dart';
import 'package:easyinvoice/src/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import 'package:invoice_api_client/items/models/item.dart';

import '../authentication/authentication_bloc.dart';
import '../bl_objects/client/mutate/client_mutate_cubit.dart';
import '../bl_objects/client/query/client_query_cubit.dart';
import '../bl_objects/client/query/view/screens/client_list_view.dart';
import '../bl_objects/invoice/mutate/invoice_modify_cubit.dart';
import '../bl_objects/invoice/mutate/view/create_invoice_screen.dart';
import '../bl_objects/invoice/view/screens/invoice_detail_screen.dart';
import '../bl_objects/invoice/invoice_cubit.dart';
import '../bl_objects/item/mutate/item_modify_cubit.dart';
import '../bl_objects/item/mutate/view/item_modify_screen/item_modify_screen.dart';
import '../bl_objects/item/query/item_cubit.dart';
import '../settings/account/profile/user_cubit.dart';
import '../settings/account/login_tiles/view/login_tiles_screen.dart';
import '../settings/account/profile/view/screens/profile_screen.dart';
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
        path: '/client-list',
        builder: (context, state) {
          return I18n(child: const ClientListViewScreen());
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
        path: '/profile',
        builder: (context, state) => I18n(child: const ProfileScreen()),
      ),
      GoRoute(
        path: '/create-item',
        builder: (context, state) =>
            I18n(child: ModifyItemScreen(item: state.extra as Item?)),
      ),
      GoRoute(
        path: '/create-client',
        builder: (context, state) =>
            I18n(child: ModifyClientScreen(client: state.extra as Client?)),
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
          RepositoryProvider.value(
              value: clientRepository
                ..setAuthenticationRepository(authenticationRepository)),
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
              BlocProvider<ClientQueryCubit>(
                create: (BuildContext context) =>
                    ClientQueryCubit(context.read<ClientRepository>()),
              ),
              BlocProvider<ClientMutateCubit>(
                create: (BuildContext context) =>
                    ClientMutateCubit(context.read<ClientRepository>()),
              ),
              BlocProvider<InvoiceCubit>(
                create: (BuildContext context) =>
                    InvoiceCubit(context.read<InvoiceRepository>()),
              ),
              BlocProvider<InvoiceModifyCubit>(
                create: (BuildContext context) =>
                    InvoiceModifyCubit(context.read<InvoiceRepository>()),
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
                routerConfig: _router,
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
