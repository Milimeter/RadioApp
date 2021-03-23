import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/Screen/no_connection_screen.dart';
import 'package:radio_app/utilities/contants.dart';

class RadioPlayerScreen extends StatefulWidget {
  @override
  _RadioPlayerScreenState createState() => _RadioPlayerScreenState();
}

class _RadioPlayerScreenState extends State<RadioPlayerScreen> {
  //to randomize Wave height
  final List<double> values = [
    9.0,
    31.0,
    20.0,
    15.0,
    15.0,
    16.0,
    14.0,
    27.0,
    41.0,
    0.0,
    27.0,
    51.0,
    67.0,
    42.0,
    54.0,
    60.0,
    36.0,
    66.0,
    16.0,
    3.0,
    3.0,
    64.0,
    61.0,
    51.0,
    37.0,
    41.0,
    29.0,
    46.0,
    16.0,
    55.0,
    0.0,
    0.0,
    41.0,
    44.0,
    9.0,
    66.0,
    58.0,
    64.0,
    45.0,
    29.0,
    23.0,
    50.0,
    35.0,
    21.0,
    34.0,
    7.0,
    27.0,
    35.0,
    63.0,
    29.0,
    4.0,
    36.0,
    63.0,
    60.0,
    62.0,
    59.0,
    48.0,
    38.0,
    48.0,
    23.0,
    22.0,
    49.0,
    2.0,
    39.0,
    47.0,
    1.0,
    32.0,
    43.0,
    33.0,
    27.0
  ];

  String url = "http://stream.zeno.fm/2p593bgeup8uv";
  bool isPlaying = false;
  bool isVisible = true;
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  var playerState = FlutterRadioPlayer.flutter_radio_paused;

  var volume = 0.8;

  @override
  initState() {
    super.initState();
    // startAudio();
    initRadioService();
  }

  // Future<void> startAudio() async {
  //   await FlutterRadio.audioStart();
  //   print("Audio of Radio Started");
  // }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init(
          "Radio East", "Live", "http://stream.zeno.fm/7f4w4us5wp8uv", "false");
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  navigate() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ConnectionLostScreen()));
  }

  @override
  Widget build(BuildContext context) {
    bool noInternet = Provider.of<DataConnectionStatus>(context) ==
        DataConnectionStatus.disconnected;

    if (noInternet == true) {
      navigate();
    } else {
      initRadioService();
    }
    return Scaffold(
      backgroundColor: cwhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),

              //Now we will create Navigation Buttons
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: pbutton(),
                    onTap: () {},
                  ),
                  Spacer(),
                  Text(
                    'RADIO EAST',
                    style: TextStyle(
                        color: cblue,
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                  ),
                  Spacer(),
                  //dbutton(Icons.radio),
                  pbutton(),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),

              //Now we will create Album Art Disk
              Container(
                padding: EdgeInsets.all(50),
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(disk)),
                ),
                child: CircleAvatar(
                    backgroundImage: AssetImage(albumart),
                    child: CircleAvatar(
                      backgroundColor: cwhite,
                      radius: 25,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              // Now we will create Song Title and Artist name Texts
              Text(
                "Radio East",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Streaming",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 20,
              ),

              StreamBuilder(
                  stream: _flutterRadioPlayer.isPlayingStream,
                  initialData: playerState,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    String returnData = snapshot.data;
                    print("object data: " + returnData);
                    switch (returnData) {
                      // case FlutterRadioPlayer.flutter_radio_stopped:
                      //   return GestureDetector(
                      //       child: dbutton(Iconsclose)
                      //       onTap: () async {
                      //         await initRadioService();
                      //       });
                      //   break;
                      case FlutterRadioPlayer.flutter_radio_loading:
                        return Text(
                          "Loading stream...",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        );
                      case FlutterRadioPlayer.flutter_radio_error:
                        return GestureDetector(
                            child: dbutton(Icons.refresh_rounded),
                            onTap: () async {
                              await initRadioService();
                            });
                        break;
                      default:
                        return Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  print("button press data: " +
                                      snapshot.data.toString());
                                  await _flutterRadioPlayer.playOrPause();
                                },
                                child: snapshot.data ==
                                        FlutterRadioPlayer.flutter_radio_playing
                                    ? dbutton(Icons.pause)
                                    : dbutton(Icons.play_arrow),
                              ),
                              // IconButton(
                              //   onPressed: () async {
                              //     print("button press data: " +
                              //         snapshot.data.toString());
                              //     await _flutterRadioPlayer.playOrPause();
                              //   },
                              //   icon: snapshot.data ==
                              //           FlutterRadioPlayer.flutter_radio_playing
                              //       ? dbutton(Icons.pause)
                              //       : dbutton(Icons.play_arrow),
                              // ),
                              GestureDetector(
                                onTap: () async {
                                  await _flutterRadioPlayer.stop();
                                  await initRadioService();
                                },
                                child: dbutton(Icons.stop),
                              ),
                              // IconButton(
                              //   onPressed: () async {
                              //     await _flutterRadioPlayer.stop();
                              //   },
                              //   icon: dbutton(Icons.stop),
                              // )
                            ]);
                        break;
                    }
                  }),
              Slider(
                  activeColor: cblue,
                  inactiveColor: cblue,
                  value: volume,
                  min: 0,
                  max: 1.0,
                  onChanged: (value) => setState(() {
                        volume = value;
                        _flutterRadioPlayer.setVolume(volume);
                      })),
              Text("Volume: " + (volume * 100).toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: cblue,
                  )),

              //Now we will create Music Controller Buttons
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     GestureDetector(
              //       onTap: () {
              //         FlutterRadio.pause(url: url);
              //       },
              //       child: dbutton(Icons.pause),
              //     ),
              //     //The buttons are called passing its above symbol
              //     GestureDetector(
              //       onTap: () {
              //         FlutterRadio.play(url: url);
              //         isPlaying = !isPlaying;
              //         isVisible = !isVisible;
              //       },
              //       child: Center(child: cbutton(play)),
              //     ),

              //     GestureDetector(
              //       onTap: () {
              //         FlutterRadio.stop();
              //       },
              //       child: dbutton(Icons.pause),
              //     ),
              //   ],
              // ),

              //Now we will create Song TimeStamp
              // RichText(
              //   text: TextSpan(
              //       style: TextStyle(
              //           color: cblue.withAlpha(100), fontWeight: FontWeight.bold),
              //       children: <TextSpan>[
              //         TextSpan(
              //             text: '0:54',
              //             style:
              //                 TextStyle(color: cblue, fontWeight: FontWeight.bold)),
              //         TextSpan(text: ' | '),
              //         TextSpan(text: '03:15')
              //       ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
