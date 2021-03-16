import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app_finaltest/screens/thirdScreen.dart';
import 'package:flutter_app_finaltest/utils/customer_picker/customize_picker.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:flutter_svg/flutter_svg.dart';

import '../l10n/localize.dart';

// ignore: camel_case_types
class All2 extends StatefulWidget {

  All2(this.language, this.distinction, this.sport, this.year,
      {this.finishYearData, this.startYearData});
  final String language;
  final String distinction;
  final String sport;
  final int finishYearData;
  final int startYearData;
  String year;

  @override
  _All2State createState() => _All2State();
}

class _All2State extends State<All2> {
  bool _buttonArrowUpVisible = true;
  bool _buttonArrowDownVisible = true;
  List<int> listYears = new List();

  @override
  void initState() {
    super.initState();
    for (int i = widget.startYearData; i <= widget.finishYearData; i++) {
      listYears.add(i);
    }
    indexSelect = listYears.length - 1;
    scrollController =
        FixedExtentScrollController(initialItem: listYears.length - 1);
  }

  Future<String> _getInfo() async {
    String jsonString = await rootBundle.loadString(
        "assets/data/ranking_data/" +
            widget.sport +
            "/" +
            widget.sport +
            "_" +
            widget.distinction +
            "_" +
            widget.year +
            ".json");
    return jsonString;
  }

  FixedExtentScrollController scrollController;

  ///select index ( index 5== 2020 , index 4 ==2019....)
  int indexSelect = 5;
  double itemExtent = 40.0;

  ///if type==1 Move Up, type ==0 Move Down
  void _controllerSelect(int type) {
    int indexMove = indexSelect + 1;
    if (type == 1) {
      indexMove = indexSelect - 1;
    }
    scrollController.animateTo(itemExtent * (indexMove),
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  Widget textYearsHightLight(String name) {
    return Container(
        alignment: Alignment.center,
        child: Container(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 33,
              fontWeight: FontWeight.w900,
              fontFamily: "DSEG7 Bold",
              shadows: [
                Shadow(
                  blurRadius: 15.0,
                  color: Colors.yellow,
                  offset: Offset.zero,
                ),
                Shadow(
                  blurRadius: 40.0,
                  color: Colors.yellow,
                  offset: Offset.zero,
                ),
              ],
            ),
          ),
        ));
  }

  Widget textYears(String name) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
          ),
        ],
      ),
    );
  }

  Widget listViewSelectYear() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 178,
                    height: 100,
                    // color: Colors.grey[850].withOpacity(0.2),
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    child: cupetinoSearchView())
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget arrowSelect() {
    return Container(
      margin: EdgeInsets.only(right: 0),
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 40,
            child: Visibility(
              visible: _buttonArrowUpVisible,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // index==6 ( year==2015)
                    if (indexSelect == 0) {
                      return;
                    }

                    widget.year = (int.parse(widget.year) - 1).toString();
                    if (!_buttonArrowDownVisible)
                      _buttonArrowDownVisible = true;
                    _controllerSelect(1);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 22),
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: AssetImage("assets/images/arrows/arrow_up.png"),
                    height: 20,
                    width: 25,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: Visibility(
              visible: _buttonArrowDownVisible,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // index==6 ( year==2020)
                    if (indexSelect == listYears.length - 1) {
                      return;
                    }

                    widget.year = (int.parse(widget.year) + 1).toString();
                    if (!_buttonArrowUpVisible) _buttonArrowUpVisible = true;
                    _controllerSelect(0);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 22),
                  height: 30,
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: AssetImage("assets/images/arrows/arrow_down.png"),
                    height: 20,
                    width: 25,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PickerController controller = PickerController(count: 1);

  Widget cupetinoSearchView() {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                  height: 95,
                  alignment: Alignment.center,
                  // color: Colors.grey[800].withOpacity(0.2),
                  child: PickerView(
                    itemExtent: 40,
                    controller: controller,
                    fixedExtentScrollController: scrollController,
                    numberofRowsAtSection: (section) {
                      return listYears.length;
                    },
                    backgroundColor: Colors.transparent,
                    onSelectRowChanged: (section, row) {
                      setState(() {
                        widget.year = (widget.startYearData + row).toString();
                      });
                      indexSelect = row;
                    },
                    itemBuilder: (int section, int row) {
                      // row = int.parse(widget.year) - 2015;
                      if (widget.year ==
                          (widget.startYearData + row).toString())
                        return Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                textYearsHightLight(widget.year.toString()),
                                // Text((2015 + row).toString())
                              ],
                            ));
                      return textYears((widget.startYearData + row).toString());
                    },
                  )),
            ],
          ),
          Container(
            height: 270,
            alignment: Alignment.centerRight,
            child: arrowSelect(),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(top: 18, left: 10),
              child: Column(
                children: [
                  Text(Localized.localizedValues[widget.language]["back"],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
          centerTitle: true,
          title: Text(Localized.localizedValues[widget.distinction]["title"]),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.darken),
              image: new AssetImage("assets/images/bcgimg/victory.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder(
            future: _getInfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Column(
                  children: [
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(children: <Widget>[
                            Text(
                                Localized.localizedValues[widget.distinction]
                                [widget.sport],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                )),
                          ]),
                        ),
                      ),
                    ),
                    listViewSelectYear(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.year,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 3,
                      color: Colors.white,
                      indent: 16,
                      endIndent: 16,
                    ),
                    SizedBox(height: 200),
                    Container(
                      child: Center(
                        child: Text(
                          Localized.localizedValues[widget.language]["nodata"],
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                var jsonResponse = json.decode(snapshot.data);
                Map nameData = jsonResponse['player_name'];
                Map citizenData = jsonResponse['citizenship'];
                Map birthdayData = jsonResponse['birthday'];
                Map pic_urlData = jsonResponse['pic_url'];
                Map salaryData = jsonResponse['salary'];
                Map flagData = jsonResponse['flag'];
                Map bloodtypeData = jsonResponse["bloodtype"];
                Map pic_nameData = jsonResponse["pic_name"];
                Map sportData = jsonResponse['sport'];

                return Padding(
                  padding: const EdgeInsets.only(top: 8, left: 2.0, right: 2.0),
                  child: Column(
                    children: [
                      Container(
                        child: Center(
                          child: Column(children: <Widget>[
                            Text(
                                Localized.localizedValues[widget.distinction]
                                [widget.sport],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                )),
                          ]),
                        ),
                      ),
                      listViewSelectYear(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: widget.year,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " TOP" + nameData.length.toString(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 10,
                        thickness: 3,
                        color: Colors.white,
                        indent: 16,
                        endIndent: 16,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: nameData.length,
                          // ignore: missing_return
                          itemBuilder: (BuildContext context, int index) {
                            String rank = (index + 1).toString();
                            // print(rank);
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ThirdScreen(
                                        widget.language,
                                        sportData[rank],
                                        nameData[rank],
                                        citizenData[rank],
                                        birthdayData[rank],
                                        pic_urlData[rank],
                                        bloodtypeData[rank],
                                        flagData[rank],
                                        pic_nameData[rank]),
                                  ),
                                );
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, right: 18),
                                        child: SvgPicture.asset(
                                          "assets/flag/" +
                                              flagData[rank] +
                                              ".svg",
                                          semanticsLabel: 'flag',
                                          width: 32,
                                          height: 30,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, right: 8.0),
                                            child: Text(
                                              nameData[rank],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, right: 35),
                                          child: RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'No.',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: rank,
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text(
                                          salaryData[rank],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                              Localized.localizedValues[
                                              widget.distinction]
                                              ["salary_font_size"],
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 10,
                                    thickness: 3,
                                    color: Colors.white,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Text(""),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}





