import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static const _t = Translations.from("en_us", {
    "Logo": {
      "en_us": "Logo",
      "de_de": "Logo",
    }
  });

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);
}
