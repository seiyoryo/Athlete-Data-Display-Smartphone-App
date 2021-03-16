import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_finaltest/l10n/localize.dart';
import 'package:flutter_app_finaltest/screens/allSecondScreen.dart';
import 'package:flutter_app_finaltest/screens/secondScreen.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage(this.isPlaying);
  bool isPlaying;
  AppLifecycleState state;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  Locale jpLocale = Locale('ja', '');
  Locale enLocale = Locale('en', '');

  AudioCache audioCache = new AudioCache();
  AudioPlayer advancedPlayer;
  bool isPlaying;

// 広告関連
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // インスタンスを初期化
    if (Platform.isIOS)
      FirebaseAdMob.instance
          .initialize(appId: 'ca-app-pub-4020313737457548~9669618680');
    else
      FirebaseAdMob.instance
          .initialize(appId: 'ca-app-pub-4020313737457548~3781693723');
    // バナー広告を表示する
    myBanner
      ..load()
      ..show(
        // ボトムからのオフセットで表示位置を決定
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
    widget.isPlaying = true;
    audioPlayerPlay();
  }

  audioPlayerPlay() async {
    advancedPlayer = await audioCache.loop("music/bgm.mp3");
  }

  @override
  Widget build(BuildContext context) {
    String language = Localized.of(context).language;
    String distinction = Localized.of(context).distinction;
    List<Map<String, dynamic>> sportList = [
      {
        "pushPageType": "All2",
        "itemType": "all",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "baseball",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "mlb",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "rugby",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "basketball",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "soccer",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "tennis",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "cricket",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "golf",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "boxing",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "mma",
        "year": "2019",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "nfl",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "horse",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "jockey",
        "year": "2019",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "sumo",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "f1",
        "year": "2020",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "boatrace",
        "year": "2019",
      },
      {
        "pushPageType": "SecondScreen",
        "itemType": "esport",
        "year": "2020",
      },
    ];

    return WillPopScope(
      onWillPop: () async {
        advancedPlayer.stop();
        advancedPlayer.dispose();
        WidgetsBinding.instance.removeObserver(this);
        return true;
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.15), BlendMode.darken),
              image: new AssetImage("assets/images/bcgimg/medal.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 80),
                        RaisedButton(
                          child: Text("Japanese",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          padding: EdgeInsets.symmetric(vertical: 0),
                          color: Colors.white.withOpacity(0),
                          shape: StadiumBorder(
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              Localized.of(context).locale = jpLocale;
                              // S.load(Locale('en', ''));
                            });
                          },
                        ),
                        SizedBox(width: 30),
                        RaisedButton(
                          child: Text("English",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          padding: EdgeInsets.symmetric(vertical: 0),
                          color: Colors.white.withOpacity(0),
                          shape: StadiumBorder(
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              Localized.of(context).locale = enLocale;
                              // S.load(Locale('en', ''));
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        if (widget.isPlaying)
                          IconButton(
                              icon: Icon(Icons.volume_up),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  advancedPlayer.stop();
                                  widget.isPlaying = false;
                                });
                              })
                        else
                          IconButton(
                            icon: Icon(Icons.volume_off),
                            color: Colors.white,
                            onPressed: () {
                              advancedPlayer.resume();
                              setState(() {
                                widget.isPlaying = true;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      Localized.localizedValues[language]["subtitle"],
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      Localized.of(context).title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                  Divider(
                    height: 40,
                    thickness: 3,
                    color: Colors.white,
                    indent: 8,
                    endIndent: 8,
                  ),
                  for (var data in sportList)
                    FlatButton(
                      onPressed: () {
                        int finishYear;
                        int startYear;
                        if (data["itemType"] == "boatrace" || data["itemType"] == "mma" ) {
                          finishYear = 2019;
                          startYear = 2015;
                        } else if (data["itemType"] == "nfl" || data["itemType"] == "f1" || data["itemType"] == "cricket") {
                          finishYear = 2020;
                          startYear = 2017;
                        } else if(data["itemType"] == "jockey") {
                          finishYear = 2019;
                          startYear = 2016;
                        } else if(data["itemType"] == "soccer") {
                          finishYear = 2020;
                          startYear = 2016;
                        } else {
                          finishYear = 2020;
                          startYear = 2015;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => data["pushPageType"] == "All2"
                                ? All2(
                                language,
                                distinction,
                                data["itemType"],
                                data["year"],
                                finishYearData: finishYear,
                                startYearData: startYear,
                            )
                                : SecondScreen(
                              language,
                              distinction,
                              data["itemType"],
                              data["year"],
                              finishYearData: finishYear,
                              startYearData: startYear,
                            ),
                          ),
                        );
                      },
                      child: Text(
                          Localized.localizedValues[distinction]
                          [data["itemType"]],
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              shadows: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(1.0),
                                    offset: Offset(0, 0),
                                    blurRadius: 30),
                              ])),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Text(""),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    advancedPlayer.stop();
    advancedPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (widget.isPlaying) {
      if (state == AppLifecycleState.paused) {
        advancedPlayer.pause();
      } else if (state == AppLifecycleState.resumed) {
        advancedPlayer.resume();
      }
    }
  }
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or female, unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // テスト用のIDを使用
  // リリース時にはIDを置き換える必要あり
  adUnitId: BannerAd.testAdUnitId,
  size: AdSize.fullBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    // 広告の読み込みが完了
    print("BannerAd event is $event");
  },
);
