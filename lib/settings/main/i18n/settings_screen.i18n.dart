import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static const _t = Translations.from("en_us", {
    "Settings": {
      "en_us": "Settings",
      "de_de": "Einstellungen",
    },
    "Account": {
      "en_us": "Account",
      "de_de": "Konto",
    },
    "Login": {
      "en_us": "Login",
      "de_de": "Einloggen",
    },
    "Invoice": {
      "en_us": "Invoice",
      "de_de": "Rechnung",
    },
    "Customize": {
      "en_us": "Customize",
      "de_de": "Anpassen",
    },
    "Notifications": {
      "en_us": "Notifications",
      "de_de": "Benachrichtigungen",
    },
    "Region": {
      "en_us": "Region",
      "de_de": "Region",
    },
    "Profile": {
      "en_us": "Profile",
      "de_de": "Profil",
    },
    "Upgrade": {
      "en_us": "Upgrade",
      "de_de": "Aufstufen",
    }
  });

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);
}
