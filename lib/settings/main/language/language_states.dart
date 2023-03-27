import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class I18nState extends Equatable {
  final Locale locale;
  const I18nState(this.locale);

  @override
  List<Object?> get props => [];
}

class EnglishUSState extends I18nState {
  const EnglishUSState() : super(const Locale("en", "US"));
}

class GermanGermanyState extends I18nState {
  const GermanGermanyState() : super(const Locale("de", "DE"));
}
