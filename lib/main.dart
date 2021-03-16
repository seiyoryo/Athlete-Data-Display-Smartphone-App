import 'package:flutter/material.dart';
import 'package:flutter_app_finaltest/screens/splash_screen/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/widgets.dart';

import 'l10n/delegate.dart';
import 'screens/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Athlete Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'World Athlete Time'),
      localizationsDelegates: [
        const SampleLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ja', ''),
      ],
      // routes: <String, WidgetBuilder>{
      //   "/": (BuildContext context) => SplashPage(),
      // },
      home: SplashPage(),
    );
  }
}
