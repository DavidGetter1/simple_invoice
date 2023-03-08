import 'package:i18n_extension/i18n_extension.dart';

// Developed by Marcelo Glasberg (Aug 2019).
// For more info, see: https://pub.dartlang.org/packages/i18n_extension

extension Localization on String {
  //

  static const _t = Translations.from("en_us", {
    "Invoices": {
      "en_us": "Invoices",
      "de_de": "Rechnungen",
    },
    "Offers": {
      "en_us": "Offers",
      "de_de": "Angebote",
    },
    "Overdue": {
      "en_us": "Overdue",
      "de_de": "Überfällig",
    }
  });



  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);
}
