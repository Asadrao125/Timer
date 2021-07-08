import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController tb;
  int hour = 0, mins = 0, sec = 0;
  String timeToDisplay = "";
  bool started = true;
  bool stopped = true;
  int timefortimer = 0;
  final dur = const Duration(seconds: 1);
  bool canceltimer = false;
  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });

    timefortimer = ((hour * 3600) + (mins * 60) + sec);
    debugPrint(timefortimer.toString());
    Timer.periodic(
      dur,
      (Timer t) {
        setState(() {
          if (timefortimer < 1 || canceltimer == true) {
            t.cancel();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          } else if (timefortimer < 60) {
            timeToDisplay = timefortimer.toString();
            timefortimer = timefortimer - 1;
          } else if (timefortimer < 3600) {
            int m = timefortimer ~/ 60;
            int s = timefortimer - (60 * m);
            timeToDisplay = m.toString() + " : " + s.toString();
            timefortimer = timefortimer - 1;
          } else {
            int h = timefortimer ~/ 3600;
            int t = timefortimer - (3600 * h);
            int m = t ~/ 60;
            int s = t - (60 * m);
            timeToDisplay =
                h.toString() + " : " + m.toString() + " : " + s.toString();
            timefortimer = timefortimer - 1;
          }
        });
      },
    );
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      canceltimer = true;
      timeToDisplay = "";
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "HH",
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: hour,
                        itemWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "MM",
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: mins,
                        itemWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            mins = val;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "SS",
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: sec,
                        itemWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                timeToDisplay,
                style: new TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    splashColor: Colors.white,
                    color: Colors.green,
                    onPressed: started ? start : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 12.0),
                      child: Text(
                        "Start",
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    splashColor: Colors.white,
                    color: Colors.red,
                    onPressed: stopped ? null : stop,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 12.0),
                      child: Text(
                        "Stop",
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Watch"),
        ),
        bottom: TabBar(
          tabs: [
            Tab(child: Text("Timer")),
            Tab(child: Text("Stopwatch")),
          ],
          controller: tb,
          labelStyle: TextStyle(
            fontSize: 16.0,
          ),
          unselectedLabelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          Center(
            child: Text("Stopwatch"),
          ),
        ],
        controller: tb,
      ),
    );
  }
}
