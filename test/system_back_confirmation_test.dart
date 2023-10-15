import 'package:flutter_test/flutter_test.dart';
import 'package:system_back_confirmation/system_back_confirmation.dart';
import 'package:system_back_confirmation/system_back_confirmation_platform_interface.dart';
import 'package:system_back_confirmation/system_back_confirmation_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSystemBackConfirmationPlatform
    with MockPlatformInterfaceMixin
    implements SystemBackConfirmationPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SystemBackConfirmationPlatform initialPlatform =
      SystemBackConfirmationPlatform.instance;

  test('$MethodChannelSystemBackConfirmation is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelSystemBackConfirmation>());
  });

  test('getPlatformVersion', () async {
    SystemBackConfirmationPlugin systemBackConfirmationPlugin =
        SystemBackConfirmationPlugin();
    MockSystemBackConfirmationPlatform fakePlatform =
        MockSystemBackConfirmationPlatform();
    SystemBackConfirmationPlatform.instance = fakePlatform;

    expect(await systemBackConfirmationPlugin.getPlatformVersion(), '42');
  });
}
