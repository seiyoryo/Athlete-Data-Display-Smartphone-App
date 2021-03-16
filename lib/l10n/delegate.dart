import 'package:flutter/widgets.dart';

import 'localize.dart';

class SampleLocalizationsDelegate extends LocalizationsDelegate<Localized> {
  const SampleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<Localized> load(Locale locale) async => Localized(locale);

  @override
  bool shouldReload(SampleLocalizationsDelegate old) => false;
}