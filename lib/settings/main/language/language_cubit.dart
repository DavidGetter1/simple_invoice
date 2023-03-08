

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'language_states.dart';

class I18nCubit extends HydratedCubit<I18nState> {
  I18nCubit() : super(EnglishUSState());

  void setEnglishUS() {
    emit(EnglishUSState());
  }

  void setGermanGermany() {
    emit(GermanGermanyState());
  }

  @override
  fromJson(Map<String, dynamic> json) {
    switch (json["state"]){
      case "EnglishUSState": return EnglishUSState();
      case "GermanGermanyState": return GermanGermanyState();
    }
  }

  @override
  Map<String, dynamic>? toJson(state) {
    switch(state.runtimeType){
      case EnglishUSState : return {"state": "EnglishUSState"};
      case GermanGermanyState : return {"state": "GermanGermanyState"};
      default : return {};
    }
  }
}