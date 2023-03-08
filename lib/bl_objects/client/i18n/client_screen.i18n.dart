import 'package:i18n_extension/i18n_extension.dart';

// Developed by Marcelo Glasberg (Aug 2019).
// For more info, see: https://pub.dartlang.org/packages/i18n_extension

extension Localization on String {
  //

  static const _t = Translations.from("en_us", {
    "Clients": {
      "en_us": "Clients",
      "de_de": "Kunden",
    },
    "Last invoice": {
      "en_us": "Last invoice",
      "de_de": "Letzte Rechnung",
    },
    "Add client": {
      "en_us": "Add client",
      "de_de": "Kunden hinzufügen",
    },
    "Tap here or on the top right": {
      "en_us": "Tap here or on the top right",
      "de_de": "Hier tippen oder rechts oben in der Ecke",
    }
  });



  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);
}
