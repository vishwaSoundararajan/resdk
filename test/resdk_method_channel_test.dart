import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resdk/resdk_method_channel.dart';

void main() {
  MethodChannelResdk platform = MethodChannelResdk();
  const MethodChannel channel = MethodChannel('resdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
