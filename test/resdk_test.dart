import 'package:flutter_test/flutter_test.dart';
import 'package:resdk/resdk.dart';
import 'package:resdk/resdk_platform_interface.dart';
import 'package:resdk/resdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockResdkPlatform
    with MockPlatformInterfaceMixin
    implements ResdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ResdkPlatform initialPlatform = ResdkPlatform.instance;

  test('$MethodChannelResdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelResdk>());
  });

  test('getPlatformVersion', () async {
    Resdk resdkPlugin = Resdk();
    MockResdkPlatform fakePlatform = MockResdkPlatform();
    ResdkPlatform.instance = fakePlatform;

    expect(await resdkPlugin.getPlatformVersion(), '42');
  });
}
