import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'system_back_confirmation_plugin.dart';
import 'system_back_confirmation.dart';

/// Consumes system back gestures that would otherwise kill the app.
///
/// If [enabled] is `true`, this will prevent system back gestures killing the
/// app. When a back gesture is consumed, [onBackBlocked] will be called.
///
/// This should be placed above any navigators in the widget tree to work
/// correctly:
/// ```dart
/// MaterialApp(
///   builder: (context, child) => PopWillKillApp(
///     child: child!,
///   ),
///   home: MyApp(),
/// );
/// ```
///
/// See also:
///
///   * [SystemBackConfirmation], which uses this widget to show a SnackBar if
///     a back gesture would kill the app.
class BackWillKillApp extends StatefulWidget {
  const BackWillKillApp({
    super.key,
    this.enabled = true,
    this.onBackBlocked,
    required this.child,
  });

  /// When `false`, pops that will kill the app will not be blocked.
  final bool enabled;

  /// Called after a pop that would have killed the app was blocked.
  final VoidCallback? onBackBlocked;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<BackWillKillApp> createState() => _BackWillKillAppState();
}

class _BackWillKillAppState extends State<BackWillKillApp>
    with WidgetsBindingObserver {
  final SystemBackConfirmationPlugin _plugin = SystemBackConfirmationPlugin();
  bool _popWillKillApp = false;
  bool _childCanHandlePop = false;

  @override
  void initState() {
    super.initState();
    _plugin.getBackWillKillApp().then((value) {
      if (mounted && _popWillKillApp != value) {
        _popWillKillApp = value;
        _onShouldHandlePopChanged();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(BackWillKillApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _onShouldHandlePopChanged();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    // If the child can handle the pop, ignore the notification and allow it to
    // continue propagating.
    if (_childCanHandlePop) return false;
    // Otherwise, if the widget is enabled and popping would kill the app,
    // trigger the callback and handle the notification.
    if (widget.enabled && _popWillKillApp) {
      widget.onBackBlocked?.call();
      return true;
    }
    return false;
  }

  void _onShouldHandlePopChanged() {
    final bool shouldHandlePop =
        _childCanHandlePop || (widget.enabled && _popWillKillApp);
    final NavigationNotification notification = NavigationNotification(
      canHandlePop: shouldHandlePop,
    );
    // Avoid dispatching a notification in the middle of a build.
    switch (SchedulerBinding.instance.schedulerPhase) {
      case SchedulerPhase.postFrameCallbacks:
        notification.dispatch(context);
      case SchedulerPhase.idle:
      case SchedulerPhase.midFrameMicrotasks:
      case SchedulerPhase.persistentCallbacks:
      case SchedulerPhase.transientCallbacks:
        SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
          if (!context.mounted) {
            return;
          }
          notification.dispatch(context);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<NavigationNotification>(
      onNotification: (NavigationNotification notification) {
        final bool childCanHandlePop = notification.canHandlePop;
        if (_childCanHandlePop != childCanHandlePop) {
          _childCanHandlePop = childCanHandlePop;
          _onShouldHandlePopChanged();
        }
        return true;
      },
      child: widget.child,
    );
  }
}
