import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tipui/tipui.dart';

import 'package:tipui/TipColorText.dart';
import 'package:tipui/TipMarqueeWidget.dart';
import 'package:tipui/TipTextSwitch.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Tipui.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    String text =
        '我是普通文字<font color="#ff0000">我是红色字</font>又是积分积分普通字<font color="#00ff00">我是绿色字</font><font color="#0000ff">我是蓝色色字</font>';
    List<String> runHouse = [
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'>你总是盘旋在我</font><font color='#ffffff'>通过不懈的努力攻下</font><font color='#fdcb32'>腾讯科技(深圳)有限公司(科兴科学园)</font><font color='#ffffff'>，成为擂主</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'>这些猫</font><font color='#ffffff'>通过不懈的努力攻下</font><font color='#fdcb32'>科兴科学园</font><font color='#ffffff'>，成为擂主</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'>秋之凉</font><font color='#ffffff'>通过不懈的努力攻下</font><font color='#fdcb32'>科兴科学园</font><font color='#ffffff'>，成为擂主</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'></font><font color='#ffffff'>通过不懈的努力攻下</font><font color='#fdcb32'>广东省</font><font color='#ffffff'>，成为擂主</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'>这些猫</font><font color='#ffffff'>，拿下</font><font color='#fdcb32'>2344</font><font color='#ffffff'>高分</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'></font><font color='#ffffff'>，拿下</font><font color='#fdcb32'>2405</font><font color='#ffffff'>高分</font>"
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('王者人生flutter控件demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Center(child: Text("TipColorText 单行")),
              ),
              Card(
                child: Center(
                    child: TipColorText(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
              ),
              Card(
                child: Center(child: Text("TipColorText 多行")),
              ),
              Card(
                child: Center(child: TipColorText(text)),
              ),
              Container(
                height: 2,
                color: Colors.red,
              ),
              Card(
                child: Center(child: Text("TipMarqueeWidget")),
              ),
              Card(
                child: Container(
                  height: 20,
                  child: Center(
                      child: TipMarqueeWidget(
                    text: text,
                  )),
                ),
              ),
              Container(
                height: 2,
                color: Colors.red,
              ),
              Card(
                child: Center(child: Text("TipSwitchText 单行")),
              ),
              Card(
                child: Container(
                  color: Colors.black45,
                  height: 20.0,
                  child: Center(
                      child: TipSwitchText(
                    runHouse,
                    scrollDirection: Axis.vertical,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
              ),
              Card(
                child: Center(child: Text("TipSwitchText 多行")),
              ),
              Card(
                child: Container(
                  color: Colors.black45,
                  height: 40.0,
                  child: Center(
                      child: TipSwitchText(
                    runHouse,
                    scrollDirection: Axis.vertical,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
