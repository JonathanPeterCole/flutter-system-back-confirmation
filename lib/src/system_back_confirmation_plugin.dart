import 'package:system_back_confirmation/system_back_confirmation_platform_interface.dart';

class SystemBackConfirmationPlugin {
  /// Checks if the system back button will kill the app, if no back callback
  /// has been registered by Flutter.
  Future<bool> getBackWillKillApp() {
    return SystemBackConfirmationPlatform.instance.getBackWillKillApp();
  }
}
