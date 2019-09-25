import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tipui/tipui.dart';

void main() {
  const MethodChannel channel = MethodChannel('tipui');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Tipui.platformVersion, '42');
  });
}
