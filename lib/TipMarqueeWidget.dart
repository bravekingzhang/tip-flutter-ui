import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tipui/TipColorText.dart';

class TipMarqueeWidget extends StatefulWidget {
  final String text;
  final Color defaultColor; //默认颜色，如果没有找到颜色的话
  final TextStyle textStyle;
  static const String Sep = "&&&&";

  ///滚动方向，水平或者垂直
  final Axis scrollAxis;

  ///空白部分占控件的百分比
  final double ratioOfBlankToScreen;

  TipMarqueeWidget({
    @required this.text,
    this.textStyle = const TextStyle(),
    this.defaultColor,
    this.scrollAxis: Axis.horizontal,
    this.ratioOfBlankToScreen: 0.25,
  }) : assert(
          text != null,
        );

  @override
  State<StatefulWidget> createState() {
    return new MarqueeWidgetState();
  }
}

class MarqueeWidgetState extends State<TipMarqueeWidget>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  double screenWidth;
  double screenHeight;
  double position = 0.0;
  Timer timer;
  final double _moveDistance = 3.0;
  final int _timerRest = 500;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      startTimer();
    });
  }

  void startTimer() {
    double widgetWidth =
        _key.currentContext.findRenderObject().paintBounds.size.width;
    double widgetHeight =
        _key.currentContext.findRenderObject().paintBounds.size.height;

    timer = Timer.periodic(new Duration(milliseconds: _timerRest), (timer) {
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      double pixels = scrollController.position.pixels;
      if (pixels + _moveDistance >= maxScrollExtent) {
        if (widget.scrollAxis == Axis.horizontal) {
          //TODO 我也看不懂怎么算的
          position = (maxScrollExtent -
                      screenWidth * widget.ratioOfBlankToScreen +
                      widgetWidth) /
                  2 -
              widgetWidth +
              pixels -
              maxScrollExtent;
        } else {
          position = (maxScrollExtent -
                      screenHeight * widget.ratioOfBlankToScreen +
                      widgetHeight) /
                  2 -
              widgetHeight +
              pixels -
              maxScrollExtent;
        }
        scrollController.jumpTo(position);
      }
      position += _moveDistance;
      scrollController.animateTo(position,
          duration: new Duration(milliseconds: _timerRest),
          curve: Curves.linear);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  List<Widget> getBothEndsChild() {
    if (widget.scrollAxis == Axis.vertical) {
      return widget.text.split(TipMarqueeWidget.Sep).map((item) {
        return new TipColorText(
          item,
          style: widget.textStyle,
        );
      }).toList();
    }
    return [
      new Center(
          child: new TipColorText(
        widget.text,
        style: widget.textStyle,
      ))
    ];
  }

  Widget getCenterChild() {
    if (widget.scrollAxis == Axis.horizontal) {
      return new Container(width: screenWidth * widget.ratioOfBlankToScreen);
    } else {
      return new Container(height: screenHeight * widget.ratioOfBlankToScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      key: _key,
      scrollDirection: widget.scrollAxis,
      controller: scrollController,
      physics: new NeverScrollableScrollPhysics(),
      children: <Widget>[
        ...getBothEndsChild(),
        getCenterChild(),
        ...getBothEndsChild(),
      ],
    );
  }
}
