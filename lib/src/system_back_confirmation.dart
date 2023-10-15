import 'package:flutter/material.dart';

import 'back_will_kill_app.dart';

/// Shows a confirmation SnackBar if a system back gesture would otherwise have
/// killed the app. If the back gesture is triggered again while the SnackBar
/// is visible, the app will close.
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
///   * [BackWillKillApp], which this widget uses internally to handle the
///     system back gesture.
class SystemBackConfirmation extends StatefulWidget {
  const SystemBackConfirmation({
    super.key,
    this.enabled = true,
    this.confirmationDuration,
    this.snackBarBuilder,
    required this.child,
  }) : assert(
          confirmationDuration == null || snackBarBuilder == null,
          'Setting confitmationDuration when using snackBarBuilder will have '
          'no effect. Instead, set the duration property on the SnackBar '
          'itself.',
        );

  final bool enabled;
  final Duration? confirmationDuration;
  final SnackBar Function(BuildContext context)? snackBarBuilder;
  final Widget child;

  static const Duration defaultConfirmationDuration = Duration(seconds: 2);

  @override
  State<SystemBackConfirmation> createState() => _SystemBackConfirmationState();
}

class _SystemBackConfirmationState extends State<SystemBackConfirmation>
    with WidgetsBindingObserver {
  bool _awaitingConfirmation = false;

  void _onPopBlocked() async {
    setState(() => _awaitingConfirmation = true);
    final SnackBar snackBar;
    if (widget.snackBarBuilder != null) {
      snackBar = widget.snackBarBuilder!(context);
    } else {
      snackBar = SnackBar(
        content: const Text('Go back again to exit'),
        duration: widget.confirmationDuration ??
            SystemBackConfirmation.defaultConfirmationDuration,
      );
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    await ScaffoldMessenger.of(context).showSnackBar(snackBar).closed;
    if (mounted) {
      setState(() => _awaitingConfirmation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackWillKillApp(
      enabled: !_awaitingConfirmation,
      onBackBlocked: _onPopBlocked,
      child: widget.child,
    );
  }
}
