// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  int _isPlayingIndex2 = -1;
  bool _played = false;
  VideoPlayerController? _controller;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/videoinfo.json')
        .then((value) {
      setState(() {
        videoInfo = jsonDecode(value);
      });
    });
  }

  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //The Whole Page
      body: Container(
        //Code for the gradient
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      color.AppColor.gradientFirst.withOpacity(0.8),
                      color.AppColor.gradientSecond
                    ],
                    begin: const FractionalOffset(0.0, 0.4),
                    end: Alignment.topRight),
              )
            : BoxDecoration(color: color.AppColor.gradientSecond),
        //Code for the main column [All rows/elements]
        child: Column(
          children: [
            //Top Portion [Course Info]
            _playArea == false
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 70, left: 30, right: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor),
                            Expanded(child: Container()),
                            Icon(Icons.info_outline,
                                size: 20,
                                color: color.AppColor.secondPageIconColor),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Legs Toning',
                          style: TextStyle(
                              fontSize: 25,
                              color: color.AppColor.secondPageTitleColor),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'and Glutes Workout',
                          style: TextStyle(
                              fontSize: 25,
                              color: color.AppColor.secondPageTitleColor),
                        ),
                        SizedBox(height: 50),
                        Row(
                          children: [
                            //Button 1 on top of the page
                            Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      color.AppColor
                                          .secondPageContainerGradient1stColor,
                                      color.AppColor
                                          .secondPageContainerGradient2ndColor
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer,
                                      size: 20,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                  SizedBox(width: 5),
                                  Text(
                                    '134 min',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  )
                                ],
                              ),
                            ),

                            SizedBox(width: 20),
                            //Button 2 on top of the page
                            Container(
                              width: 210,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      color.AppColor
                                          .secondPageContainerGradient1stColor,
                                      color.AppColor
                                          .secondPageContainerGradient2ndColor
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.handyman_outlined,
                                      size: 20,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                  SizedBox(width: 5),
                                  Text(
                                    'Weights & Bands',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          padding: const EdgeInsets.only(
                              top: 50, left: 30, right: 30),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    debugPrint('tapped');
                                  },
                                  child: Icon(Icons.arrow_back_ios,
                                      size: 20,
                                      color:
                                          color.AppColor.secondPageIconColor)),
                              Expanded(child: Container()),
                              Icon(Icons.info_outline,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor),
                            ],
                          ),
                        ),
                        _playView(context),
                        _controlView(context),
                      ],
                    ),
                  ),
            //Bottom Part of the page [Videos List]
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(70))),

                //Column of rows [Row for each video card]
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    //first video card
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text('Class 1: Legs Day',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: color.AppColor.circuitsColor)),
                        Expanded(child: Container()),
                        //Right top info of the card
                        Row(
                          children: [
                            Icon(Icons.loop,
                                size: 30, color: color.AppColor.loopColor),
                            SizedBox(width: 10),
                            Text(
                              '5 sets',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: color.AppColor.setsColor),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    //The caller of videos list
                    Expanded(child: _listView()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controlView(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: color.AppColor.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () async {
              final index = _isPlayingIndex - 1;
              if (index >= 0 && videoInfo.length >= 0) {
                _onTapVideo(index);
              } else {
                Get.snackbar('Video', 'No more videos to play!');
              }
            },
            child: Icon(
              Icons.fast_rewind,
              size: 36,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {
              if (_isPlaying) {
                setState(() {
                  _isPlaying = false;
                });
                _controller?.pause();
              } else {
                setState(() {
                  _isPlaying = true;
                });
                _controller?.play();
              }
            },
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              size: 36,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {
              final index = _isPlayingIndex + 1;
              if (index >= 0 && videoInfo.length >= 0) {
                _onTapVideo(index);
              } else {
                Get.snackbar('Video', 'No more videos to play!');
              }
            },
            child: Icon(
              Icons.fast_forward,
              size: 36,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text(
            'Preparing...',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white60,
            ),
          )));
    }
  }

  var _onUpdateControllerTime;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint('Controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint('Controller can not be intitialized');
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _onTapVideo(int index) async {
    final controller =
        VideoPlayerController.network(videoInfo[index]['videoUrl']);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller.initialize().then((_) {
      old?.dispose();
      _isPlayingIndex = index;
      controller.addListener(_onControllerUpdate);
      controller.play();
      setState(() {
        videoInfo[index]['played'] = true;
      });
    });
  }

  _listView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      itemCount: videoInfo.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () {
            _onTapVideo(index);
            debugPrint(index.toString());
            setState(() {
              if (_playArea == false) {
                _playArea = true;
                _played = true;
              }
            });
          },
          child: _buildCard(index),
        );
      },
    );
  }

//The Function used to generate the list of videos
  _buildCard(int index) {
    return Container(
      height: 110,
      color: color.AppColor.homePageBackground,
      width: 200,
      child: Column(
        children: [
          //each video card design
          Row(
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: AssetImage(videoInfo[index]['thumbnail']),
                      fit: BoxFit.cover),
                ),
              ),
              //Space between video icon and title
              SizedBox(width: 10),
              Row(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoInfo[index]['title'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(videoInfo[index]['time'],
                          style: TextStyle(color: Colors.grey[500])),
                    ),
                  ],
                ),
              ]),
              Expanded(child: Container()),
              videoInfo[index]['played'] == true
                  ? Icon(Icons.check)
                  : Icon(Icons.circle_outlined)
            ],
          ),
          //The dotted splitter
          SizedBox(height: 15),
          //Break circle box
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFFeaeefc),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    '15s rest',
                    style: TextStyle(color: Color(0xFF839fed)),
                  ),
                ),
              ),
              //Dotted line
              Row(
                children: [
                  for (int i = 0; i < 90; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                                color: Color(0xFF839fed),
                                borderRadius: BorderRadius.circular(2)),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2)),
                          ),
                ],
              ),
            ],
          ),
        ],
      ),
    ); ////
  }
}
