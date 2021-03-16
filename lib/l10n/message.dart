
import 'package:flutter/cupertino.dart';

class Message {
  Message({
    @required this.title,
    @required this.greeting,
    @required this.counter,
  });

  final String title;
  final String greeting;
  final String Function(int) counter;

  factory Message.of(Locale locale) {
    switch(locale.languageCode) {
      case 'ja': return Message.ja();
      case 'en': return Message.en();
      default: return Message.ja();
    }
  }

  factory Message.ja() => Message(
    title: "こんにちワハハハ",
    greeting: "ようこそ",
    counter: (count) => "$count回クリックされました",
  );

  factory Message.en() => Message(
    title: "Hello",
    greeting: "Welcome",
    counter: (count) => "Clicked $count times",
  );


}