import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Pops the current route, or exits the app if this is the last route.
void popRouteOrExit(BuildContext context) {
  final NavigatorState? navigator = Navigator.maybeOf(context);
  if (navigator?.canPop() == true) {
    Navigator.pop(context);
  } else {
    SystemNavigator.pop();
  }
}
