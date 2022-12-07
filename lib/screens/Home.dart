import 'package:bwtk/widgets/Compass.dart';
import 'package:bwtk/widgets/PictoMatcher.dart';
import 'package:flutter/material.dart';

// Custom Widgets
import '../widgets/VideoApp.dart';
//import '../widgets/PowerChart.dart';
import '../widgets/TurbineGauge.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {

  int pageIndex = 1;
  bool requestActive = false;
  final pages = [
    const LicensePage(applicationVersion: "0.1b", applicationName: "ASU REI Dashboard",),
    const Wind(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Theme buildBottomNavBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent
      ),
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xff3C3F42),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                Icons.info,
                color: Color(0xffedd711),
                size: 35,
              )
              : const Icon(
                Icons.info_outline,
                color: Color(0xffedd711),
                size: 35,
              ),
            ),
            IconButton(onPressed: () {
              setState(() {
              requestActive = !requestActive;
              if (requestActive) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                  return WillPopScope(
                    onWillPop: () async {
                      setState(() {
                        requestActive = false;
                      });
                      return true;
                    },
                    child: AlertDialog (
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            left: 0,
                            top: 10,
                            child: InkResponse(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            enableFeedback: false,
                            onTap: () {
                              Navigator.of(context).pop();
                              setState(() {
                                requestActive = false;
                              });
                            },
                            child:  const Icon(
                                Icons.close,
                                size: 25,
                                color: Color(0xff3C3F42),
                              ),
                          ),
                          )
                        ],
                      ),
                    ),
                  );
                });
              }
            });
            },
              icon: requestActive ?
              const Icon(
                Icons.lightbulb,
                color: Color(0xffedd711),
                size: 35,
              )
              : const Icon (
              Icons.lightbulb_outline,
              color: Color(0xffedd711),
              size: 35,
            )
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                Icons.wind_power,
                color: Color(0xffedd711),
                size: 35,
              )
              : const Icon(
                Icons.wind_power_outlined,
                color: Color(0xffedd711),
                size: 35,
              ),
            ),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: buildBottomNavBar(context),
      backgroundColor: const Color(0xff1B2430),
      body: pages[pageIndex],
    );
  }
}

class Wind extends StatefulWidget {
  const Wind({Key? key}) : super(key: key);
  static int rightIndex = 0;
  @override
  State<StatefulWidget> createState() => WindState();

}

class WindState extends State<Wind> {

  double fontSize = 13.0;
  var fontColor = Colors.white;
  late Icon playIcon;
  late VideoApp videoApp;
  final GlobalKey<VideoAppState> _videoAppState = GlobalKey<VideoAppState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playIcon = const Icon(
      Icons.play_arrow_outlined,
      color: Color(0xffedd711),
    );
    videoApp = VideoApp(key: _videoAppState);

  }

  void updatePlayIcon() {
    setState(() {
      if (!_videoAppState.currentState!.getConroller().value.isPlaying) {
        playIcon = const Icon(
          Icons.play_arrow_outlined,
          color: Color(0xffedd711),
        );
      }
      else {
        playIcon = const Icon(
          Icons.pause_circle_filled_outlined,
          color: Color(0xffedd711),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () => _videoAppState.currentState!.getConroller().addListener(() {updatePlayIcon();}));
    return Row(children: [
      Expanded(child: Container(), flex: 1),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    width: 300,
                    height: 450,
                    child: Compass()
                ),
                Column(
                  children:[
                    Expanded(child: Container(), flex: 1,),
                    const Expanded(
                        flex: 14,
                        child:
                        SizedBox(
                            height: 390,
                            width: 500,
                            child:
                            TurbineGauge()
                        )
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
                Column(
                  children: [
                    Expanded(child: Container(), flex: 1),
                    //Container(child: TurnSignal()),
                    SizedBox(
                      height: 390,
                      width: 560,
                      child: IndexedStack(
                        index: Wind.rightIndex,
                        children: [
                          PictoMatcher(),
                          Column(
                            children: [
                              SizedBox(
                                height: 390,
                                width: 500,
                                child: Container(),
                              ),
                              Container(height: 10),
                              Text("7 Day Power Output (kW)", style: TextStyle(decoration: TextDecoration.none,
                                  color: fontColor, fontSize: fontSize),),
                            ],
                          ),
                          SizedBox(
                            height: 390,
                            width: 560,
                            child: videoApp,
                          ),
                        ],
                      ),
                    ),
                    Row(children: [
                      const VerticalDivider(width: 15),
                      if (Wind.rightIndex > 0)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (Wind.rightIndex == 2) {
                                _videoAppState.currentState!.getConroller().pause();
                                _videoAppState.currentState!.getConroller().seekTo(const Duration(seconds: 0));
                              }
                              --Wind.rightIndex;
                            });
                          },
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xffedd711),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffffffff).withOpacity(0),
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(18),
                          ),
                        ),
                      if (Wind.rightIndex == 0) const VerticalDivider(width: 65),
                      const VerticalDivider(width: 150),
                      if (Wind.rightIndex < 2)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              ++Wind.rightIndex;
                            });
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffedd711),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff03050a).withOpacity(0),
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(18),
                          ),
                        ),
                      if (Wind.rightIndex == 2)
                        Theme(
                          data: Theme.of(context).copyWith(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // call _controller from VideoApp
                                if (_videoAppState.currentState!.getConroller().value.isPlaying) {
                                  _videoAppState.currentState!.getConroller().pause();
                                }
                                else {
                                  _videoAppState.currentState!.getConroller().play();
                                }
                              });
                            },
                            child: playIcon,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(18),
                            ),
                          ),
                        ),
                    ]),
                    Expanded(child: Container(), flex: 1,)
                  ],
                ),
              ]
          ),
      Expanded(child: Container(), flex: 1),
    ],
    );
  }
}