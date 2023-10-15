import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'system_back_confirmation_platform_interface.dart';

/// An implementation of [SystemBackConfirmationPlatform] that uses method channels.
class MethodChannelSystemBackConfirmation
    extends SystemBackConfirmationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('system_back_confirmation');

  @override
  Future<bool> getBackWillKillApp() async {
    final bool? backWillKillApp =
        await methodChannel.invokeMethod<bool>('getBackWillKillApp');
    return backWillKillApp ?? false;
  }
}
