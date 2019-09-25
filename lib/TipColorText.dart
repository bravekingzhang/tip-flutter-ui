import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class TipColorText extends StatefulWidget {
  const TipColorText(
    this.data, {
    Key key,
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
  _TipColorTextState createState() => _TipColorTextState();

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String data;

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

class _TipColorTextState extends State<TipColorText> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: _buildTextSpans(widget.data),
      ),
      style: widget.style,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      overflow: widget.overflow,
    );
  }

  List<TextSpan> _buildTextSpans(String data) {
    List<TextItem> texts = parse(data);
    return texts.map((item) => _buildTextSpan(item)).toList();
  }

  List<TextItem> parse(String data) {
    dom.Document document = parser.parse(data.replaceAll("font", "span"));
    List<TextItem> items = [];
    document.body.nodes.forEach((node) {
      if (node is dom.Text) {
        items.add(
            TextItem(widget.style.color, widget.style.fontSize, node.text));
      } else if (node is dom.Element && node.localName == "span") {
        items.add(TextItem(HexColor(node.attributes['color']),
            widget.style.fontSize, node.text));
      }
    });
    return items;
  }

  TextSpan _buildTextSpan(TextItem textItem) {
    return TextSpan(
        text: textItem.content,
        style: widget.style.copyWith(color: textItem.color));
  }
}

class TextItem {
  Color color;
  double fontSize;
  String content;

  TextItem(this.color, this.fontSize, this.content);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
