import 'dart:ui';

class Translation{

  static const String _pathTranslate = 'assets/languages';

  static const List<Locale> _listLanguageSupport = [Locale('en', 'US')];

  static String get pathTranslate => _pathTranslate;

  static List<Locale> get listLanguageSupport => _listLanguageSupport;

}