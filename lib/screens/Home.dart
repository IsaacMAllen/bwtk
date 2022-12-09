import 'package:bwtk/widgets/Compass.dart';
import 'package:bwtk/widgets/EnergyUsage.dart';
import 'package:bwtk/widgets/PictoMatcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

// Custom Widgets
import '../widgets/PowerChart.dart';
import '../widgets/VideoApp.dart';
//import '../widgets/PowerChart.dart';
import '../widgets/TurbineGauge.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  int pageIndex = 1;
  bool requestActive = false;
  final pages = [
    const LicensePage(applicationVersion: "0.1b", applicationName: "ASU REI Dashboard",),
    const Wind(),
  ];

  notify(String subject, String body) async {
    await FirebaseFirestore.instance.collection("mail").add(
      {
        'from': 'isaac@isaacallen.dev',
        'to': 'isaac@isaacallen.dev',
        'message': {
          'subject': subject,
          'text': body
        },
      },
    );
  }

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
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
                      title: const Center(child: Text("Leave a suggestion!")),
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            left: -40,
                            top: -80,
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
                            child:  const CircleAvatar(
                              backgroundColor: Color(0xff3C3F42),
                              radius: 15,
                              child: Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Color(0xffedd711),
                                  ),
                                ),
                            ),
                          ),
                          Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: 250,
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: fnameController,
                                  decoration: const InputDecoration(
                                    hintText: 'First Name',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide: BorderSide(color: Color(0xff3C3F42), width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide: BorderSide(color: Color(0xffedd711), width: 2.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your First Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: 250,
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: lnameController,
                                  decoration: const InputDecoration(
                                      hintText: 'Last Name',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide: BorderSide(color: Color(0xff3C3F42), width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide: BorderSide(color: Color(0xffedd711), width: 2.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Last Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: 250,
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      hintText: 'Email',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide: BorderSide(color: Color(0xff3C3F42), width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide: BorderSide(color: Color(0xffedd711), width: 2.0),
                                    ),
                                  ),
                                  validator: (value) {
                                      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                      final regExp = RegExp(pattern);
                                      if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
                                        return 'Please enter a valid Email Address';
                                      }
                                    return null;
                                  },
                                ),
                              ),
                              Container(height: 20),
                              Container(
                                  height: 100,
                                  width: 350,
                                  child:
                                  TextFormField(
                                    maxLength: 240,
                                    minLines: 10,
                                    maxLines: 20,
                                    controller: bodyController,
                                    decoration: const InputDecoration(
                                      hintText: 'Your Suggestion(s)',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        borderSide: BorderSide(color: Color(0xff3C3F42), width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        borderSide: BorderSide(color: Color(0xffedd711), width: 2.0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a Suggestion';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Color(0xff3C3F42))
                                  ), 
                                  child: const Text("Submit"),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var subject = 'REI Dashboard User Suggestion from ' +
                                          fnameController.text + ' ' +
                                          lnameController.text;
                                      final body = emailController.text + ' says: ' +
                                          bodyController.text;
                                      notify(subject, body);
                                      Navigator.of(context).pop();
                                      setState(() {
                                        requestActive = false;
                                      });
                                      fnameController.text = "";
                                      lnameController.text = "";
                                      emailController.text = "";
                                      bodyController.text = "";
                                    }
                                  }
                                )
                              ),
                            ]
                            )
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }
            });
            },
              icon: requestActive ?
              const Center(
                child: Icon(
                  Icons.lightbulb,
                  color: Color(0xffedd711),
                  size: 35,
                ),
              )
              : const Center(
                child: Icon (
                Icons.lightbulb_outline,
                color: Color(0xffedd711),
                size: 35,
            ),
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
    return

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(
                      width: 300,
                      height: 450,
                      child: Compass()
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children:[
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          'images/rei.png',
                          height: 100,
                          width: 300,
                        ),
                      ),
                      const Expanded(
                          flex: 6,
                          child:
                              TurbineGauge()
                          ),
                      Expanded(flex: 2, child: Container()),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(child: Container(), flex: 1),
                      SizedBox(
                        height: 420,
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
                                  child: PowerChart(),
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
                        Expanded(child: Container(), flex: 1),
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
                        Expanded(child: Container(), flex: 1),
                      ]),
                      Expanded(child: Container(), flex: 1,)
                    ],
                  ),
                ),
              ]
          );
  }
}