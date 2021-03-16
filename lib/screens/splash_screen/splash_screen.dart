import 'package:flutter/material.dart';
import 'package:flutter_app_finaltest/screens/home/home_page.dart';
import 'package:video_player/video_player.dart';




class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}



class SplashScreenState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {

  VideoPlayerController _controller;
  Widget playerWidget;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/athlete_time.mp4');
    _controller.initialize().then((_) {
      _controller.play();
    });
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration)
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => MyHomePage(true)),
                (Route<dynamic> route) => false);
    });
  }

  _getVideoBackground() {
    return  VideoPlayer(_controller);
  }

  _getContent() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/launcher/app_image.png"),
            width: 250.0,
          ),
          SizedBox(
            height: 150.0,
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
            _getContent(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}