import 'package:i18n_extension/i18n_extension.dart';

// Developed by Marcelo Glasberg (Aug 2019).
// For more info, see: https://pub.dartlang.org/packages/i18n_extension

extension Localization on String {
  //

  static const _t = Translations.from("en_us", {
    "Latest": {
      "en_us": "Latest",
      "de_de": "Neueste",
    },
    "Recent Clients": {
      "en_us": "Recent Clients",
      "de_de": "Letzte Kunden",
    },
    "SHOW ALL": {
      "en_us": "SHOW ALL",
      "de_de": "ALLE ANZEIGEN",
    },
    "Recent Activity": {
      "en_us": "Recent Activity",
      "de_de": "Letzte Aktivitäten",
    },
    "Paid": {
      "en_us": "Paid",
      "de_de": "Bezahlt",
    },
    "Pending": {
      "en_us": "Pending",
      "de_de": "Ausstehend",
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
