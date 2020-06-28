import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _DemoLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return DemoLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<MaterialLocalizations> old) {
    return false;
  }
}

class DemoLocalizations extends DefaultMaterialLocalizations {
  const DemoLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate = _DemoLocalizationsDelegate();

  static Future<MaterialLocalizations> load(Locale locale) {
    return SynchronousFuture<MaterialLocalizations>(const DemoLocalizations());
  }

  @override
  String get rowsPerPageTitle => '每页:';

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    return '共选中$selectedRowCount条';
  }
}
