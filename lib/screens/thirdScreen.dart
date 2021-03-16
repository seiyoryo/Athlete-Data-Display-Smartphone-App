

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/localize.dart';


class ThirdScreen extends StatelessWidget {

  ThirdScreen(this.language,this.sport, this.player_name, this.citizenship, this.birthday, this.pic_url, this.bloodtype, this.flag, this.pic_name);
  final String language;
  final String sport;
  final String player_name;
  final String citizenship;
  final String birthday;
  final String pic_url;
  final String bloodtype;
  final String flag;
  final String pic_name;

  Future<String> _getAthleteInfo() async {
    String jsonString = await rootBundle.loadString(
        "assets/data/athlete_data/" + sport + "_" + language + ".json");
    return jsonString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.only(top:18, left:10),
              child: Text(
                  Localized.localizedValues[language]["back"],
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
              ),
            ),
          ),
          centerTitle: true,
          title: Text(player_name),
        ),
        body:Container(
          height: double.infinity,
          width: double.infinity,
          decoration:new BoxDecoration(
            image: new DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
              image: new AssetImage("assets/images/bcgimg/trophy2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder(
            future: _getAthleteInfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("No Data", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                );
              }else{
                var jsonResponse = json.decode(snapshot.data);
                Map wantedAthlete = jsonResponse[player_name];
                List<String> yearList = ["2020", "2019", "2018", "2017", "2016", "2015"];
                String sal = "";
                if(sport == "boxing"){
                  sal = Localized.localizedValues[language]["boxing_salary"];
                }else{
                  sal = Localized.localizedValues[language]["salary"];
                }

                return SingleChildScrollView(
                    child: Center(
                        child: Column(
                            children: [
                              Container(
                                child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          Localized.of(context).subtitle,
                                          style: TextStyle(fontSize: 14, color: Colors.white,),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: Text(
                                          Localized.localizedValues[language][sport],
                                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, right: 50, left: 50),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color.fromRGBO(238, 179, 0, 0.8),
                                                    width: 10)
                                            ),
                                            child: Image.asset("assets/images/picture/" + sport +  "/" + pic_name +".png")
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16.0, bottom:4.0),
                                        child: Text(Localized.of(context).name + " : " + player_name,style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(Localized.of(context).nationality + " : " + citizenship,style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(Localized.of(context).birthday + " : " + birthday,style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(Localized.of(context).bloodtype + " : " + bloodtype,style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                      ),
                                    ]
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10, left: 20, right: 10, bottom: 105.0),
                                child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        DataTable(
                                          columns: <DataColumn>[
                                            DataColumn(label: Text(Localized.localizedValues[language]["year"], style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),),
                                            DataColumn(label: Text(sal, style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),),
                                          ],
                                          rows: <DataRow>[
                                            for (var year in yearList)
                                              DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text(year, style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),),
                                                  DataCell(Text(wantedAthlete[year], style: TextStyle(fontSize: 22, color: Colors.yellow, fontWeight: FontWeight.bold),),),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              )
                            ]
                        )
                    )
                );
              }
            },
          ),
        )
    );
  }
}

