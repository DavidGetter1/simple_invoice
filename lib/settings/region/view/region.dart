import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../i18n/region.i18n.dart';
import '../../main/language/language_cubit.dart';

class RegionScreen extends StatelessWidget {
  const RegionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RegionScreen")),
      body: Center(
        child: ListTile(
          onTap: () => Localizations.localeOf(context) == Locale("en", "US")
              ? context.read<I18nCubit>().setGermanGermany()
              : context.read<I18nCubit>().setEnglishUS(),
          title: Text("Select Region".i18n),
        ),
      ),
    );
  }
}
