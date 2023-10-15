import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'system_back_confirmation_method_channel.dart';

abstract class SystemBackConfirmationPlatform extends PlatformInterface {
  /// Constructs a SystemBackConfirmationPlatform.
  SystemBackConfirmationPlatform() : super(token: _token);

  static final Object _token = Object();

  static SystemBackConfirmationPlatform _instance =
      MethodChannelSystemBackConfirmation();

  /// The default instance of [SystemBackConfirmationPlatform] to use.
  ///
  /// Defaults to [MethodChannelSystemBackConfirmation].
  static SystemBackConfirmationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SystemBackConfirmationPlatform] when
  /// they register themselves.
  static set instance(SystemBackConfirmationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Checks if the system back button will kill the app, if no back callback
  /// has been registered by Flutter.
  Future<bool> getBackWillKillApp() {
    throw UnimplementedError('getBackWillKillApp() has not been implemented.');
  }
}
