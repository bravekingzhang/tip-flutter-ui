import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tipui/TipColorText.dart';

class TipSwitchText extends StatefulWidget {
  const TipSwitchText(
    this.data, {
    Key key,
    this.timerRest = 1500,
    this.scrollDirection = Axis.horizontal,
    this.style = const TextStyle(),
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
  })  : assert(
          data != null,
          'A non-null String must be provided to a Text widget.',
        ),
        super(key: key);

  @override
  _TipSwitchTextState createState() => _TipSwitchTextState();

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final List<String> data;

  final int timerRest;

  /// The axis along which the page view scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// The text style to apply.
  final TextStyle style;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is non-null, it will override even explicit null values of
  /// [Text.maxLines].
  final int maxLines;

  /// The strategy to use when calculating the width of the Text.
  /// See [TextWidthBasis] for possible values and their implications.
  final TextWidthBasis textWidthBasis;
}

class _TipSwitchTextState extends State<TipSwitchText> {
  PageController _controller = new PageController();
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      startTimer();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new PageView(
      scrollDirection: widget.scrollDirection,
      controller: _controller,
      children: widget.data.map((text) {
        return new TipColorText(
          text,
          textAlign: widget.textAlign,
          overflow: widget.overflow,
          style: widget.style,
          maxLines: widget.maxLines,
        );
      }).toList(),
    );
  }

  void _animate() {
    Duration duration = Duration(milliseconds: (widget.timerRest / 2).ceil());
    Curve curve = Curves.easeOut;
    if (_controller.page == widget.data.length - 1) {
      _controller.jumpToPage(0);
    } else {
      _controller.nextPage(duration: duration, curve: curve);
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: widget.timerRest), (timer) {
      _animate();
    });
  }
}
