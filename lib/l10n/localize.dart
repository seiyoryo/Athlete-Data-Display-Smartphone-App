import 'dart:ui';

import 'package:flutter/widgets.dart';




/// アプリでの文言はこれ経由で取得する
class Localized {
  Localized(this.locale);
  Locale locale;

  static Localized of(BuildContext context) {
    return Localizations.of<Localized>(context, Localized);
  }

  String get language {
    return locale.languageCode;
  }

  String get distinction {
    if (locale.languageCode == "ja"){
      return "ja";
    }else{
      return "en";
    }
  }


  static Map<String, Map<String, dynamic>> localizedValues = _localizedValues;

  static Map<String, Map<String, dynamic>> _localizedValues = {
    'en': {
      "title": "World Athlete Time",
      "subtitle": "Patent Pending (PCT Application)",
      "all":"All",
      "baseball": "Baseball",
      "mlb": "Measure League Baseball",
      "rugby":"Rugby",
      "basketball":"Basketball",
      "soccer":"Soccer",
      "tennis":"Tennis",
      "golf":"Golf",
      "boxing":"Boxing",
      "mma":"MMA",
      "nfl":"American Football",
      "horse":"Race Horse",
      "jockey":"Jockey",
      "sumo":"Sumo",
      "f1":"F1",
      "boatrace":"Boat Racing",
      "esport":"E-sports",
      "name":"Name",
      "nationality":"Nationality",
      "birthday":"Born",
      "bloodtype":"Blood Type",
      "year":"Year",
      "salary":"Income",
      "boxing_salary":"Net Worth",
      "cricket":"Cricket",
      "back":"Back",
      "nodata":"No Data",
      "pick_the_year":"Pick the year",
      "salary_font_size":28.0

    },
    'ja': {
      "title": "世界アスリートタイム",
      "subtitle": "特許出願中(PCT出願)",
      "all":"総合",
      "baseball": "野球",
      "mlb": "メジャーリーグ",
      "rugby":"ラグビー",
      "basketball":"バスケットボール",
      "soccer":"サッカー",
      "tennis":"テニス",
      "golf":"ゴルフ",
      "boxing":"ボクシング",
      "mma":"総合格闘技",
      "nfl":"アメリカンフットボール",
      "horse":"競馬（馬）",
      "jockey":"競馬（騎手）",
      "sumo":"相撲",
      "f1":"F1",
      "boatrace":"モーターボート",
      "esport":"eスポーツ",
      "name":"名前",
      "nationality":"国籍",
      "birthday":"生年月日",
      "bloodtype":"血液型",
      "year":"年度",
      "salary":"収入",
      "boxing_salary":"総資産",
      "cricket":"クリケット",
      "back":"戻る",
      "nodata":"データ非公開",
      "pick_the_year":"年度を選んでください",
      "salary_font_size":23.0

    },
  };

  String get title {
    return _localizedValues[distinction]['title'];
  }

  String get subtitle {
    return _localizedValues[distinction]['subtitle'];
  }

  String get all {
    return _localizedValues[distinction]['all'];
  }

  String get baseball {
    return _localizedValues[distinction]['baseball'];
  }

  String get mlb {
    return _localizedValues[distinction]['mlb'];
  }

  String get rugby {
    return _localizedValues[distinction]['rugby'];
  }

  String get basketball {
    return _localizedValues[distinction]['basketball'];
  }

  String get soccer {
    return _localizedValues[distinction]['soccer'];
  }

  String get tennis {
    return _localizedValues[distinction]['tennis'];
  }

  String get golf {
    return _localizedValues[distinction]['golf'];
  }

  String get boxing {
    return _localizedValues[distinction]['boxing'];
  }

  String get mma {
    return _localizedValues[distinction]['mma'];
  }

  String get nfl {
    return _localizedValues[distinction]['nfl'];
  }

  String get horse {
    return _localizedValues[distinction]['horse'];
  }

  String get jockey {
    return _localizedValues[distinction]['jockey'];
  }

  String get sumo {
    return _localizedValues[distinction]['sumo'];
  }

  String get f1 {
    return _localizedValues[distinction]['f1'];
  }

  String get boatrace {
    return _localizedValues[distinction]['boatrace'];
  }

  String get esport {
    return _localizedValues[distinction]['esport'];
  }

  String get name {
    return _localizedValues[distinction]['name'];
  }

  String get nationality {
    return _localizedValues[distinction]['nationality'];
  }

  String get birthday {
    return _localizedValues[distinction]['birthday'];
  }

  String get bloodtype {
    return _localizedValues[distinction]['bloodtype'];
  }

  String get year {
    return _localizedValues[distinction]['year'];
  }

  String get salary {
    return _localizedValues[distinction]['salary'];
  }

  String get back {
    return _localizedValues[distinction]['back'];
  }

}
