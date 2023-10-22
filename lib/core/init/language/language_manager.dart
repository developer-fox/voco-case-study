
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// The [LanguageManager] class makes language-dependent content operations more efficient and manageable over a single instance.
/// 
/// The local keys.g.dart file needs to be regenerated when data is added to the language pack.
/// The script below does this automatically.
//? flutter pub run easy_localization:generate  -O lib/core/init/language -f keys -o locale_keys.g.dart -S asset/language
// 
class LanguageManager{
  static LanguageManager? _instance =  LanguageManager._init();
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final trLocale = const Locale('tr');
  List<Locale> get supportedLocales => [trLocale,];

  Future<void> changeLocale(BuildContext context, Languages language) async{
    await EasyLocalization.of(context)?.setLocale(language.toLocale);
  }

  Languages getCurrentLanguage(BuildContext context){
    var currentLocale = EasyLocalization.of(context)!.currentLocale!;
    return Languages.toLanguage(currentLocale);
  }


  Set<Languages> get supportedLanguages => Languages.values.toSet();

}

enum Languages{
  turkish;

  @override
  String toString(){
    switch (this) {
      case Languages.turkish:
        return "Türkçe";
    }
  }

  Locale get toLocale{
    switch (this) {
      case Languages.turkish:
        return LanguageManager.instance.trLocale;
    }
  }

  static Languages toLanguage(Locale locale){
    switch (locale.countryCode) {
      case "TR":
        return Languages.turkish;
      default:
        throw Exception("not handled locale");
    }
  }

}
