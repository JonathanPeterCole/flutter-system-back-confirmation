import 'package:flutter/material.dart';

class PopScopeConfirmation extends StatefulWidget {
  /// Controls back navigation for the current route.
  ///
  /// The [canPop] parameter can be used to disable back navigation, including:
  /// - The back button in an [AppBar].
  /// - The system back button/gesture on Android.
  /// - The back gesture on iOS.
  /// - Other calls to [Navigator.maybePop].
  ///
  /// The [onPopBlocked] parameter is called when back navigation is blocked.
  /// This can be used to show a confirmation alert:
  /// ```dart
  /// PopScopeConfirmation(
  ///   canPop: false,
  ///   onPopBlocked: () {
  ///     showDialog<void>(
  ///       context: context,
  ///       builder: (context) => AlertDialog(
  ///         title: const Text('Are you sure?'),
  ///         content: const Text(
  ///           'If you leave this page, your progress will be lost.',
  ///         ),
  ///         actions: <Widget>[
  ///           TextButton(
  ///             child: const Text('Leave'),
  ///             onPressed: () {
  ///               Navigator.pop(context);
  ///               Navigator.pop(context);
  ///             },
  ///           ),
  ///           TextButton(
  ///             child: const Text('Stay'),
  ///             onPressed: () {
  ///               Navigator.pop(context);
  ///             },
  ///           ),
  ///         ],
  ///       ),
  ///     ),
  ///   ),
  /// );
  /// ```
  ///
  ///
  /// Unlike [PopScope], this doesn't disable the iOS back gesture when [canPop]
  /// is `true`.
  const PopScopeConfirmation({
    super.key,
    required this.canPop,
    this.onPopBlocked,
    required this.child,
  });

  /// Whether or not the page can be popped.
  final bool canPop;

  /// Called when [canPop] is `false` and the user tries going back.
  final VoidCallback? onPopBlocked;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State createState() => _PopScopeConfirmationState();
}

class _PopScopeConfirmationState extends State<PopScopeConfirmation>
    implements PopEntry {
  ModalRoute<dynamic>? _route;

  /// This is required by [PopEntry] to determine whether or not the current
  /// route can be popped. This will always be `false` because we unregister
  /// the pop entry when [widget.canPop] is `true`.
  @override
  late final ValueNotifier<bool> canPopNotifier;

  @override
  PopInvokedCallback? get onPopInvoked => _onPopInvoked;

  @override
  void initState() {
    super.initState();
    canPopNotifier = ValueNotifier(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.canPop) _route?.unregisterPopEntry(this);
    _route = ModalRoute.of(context);
    if (!widget.canPop) _route?.registerPopEntry(this);
  }

  @override
  void didUpdateWidget(PopScopeConfirmation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.canPop != oldWidget.canPop) {
      if (!oldWidget.canPop) _route?.unregisterPopEntry(this);
      if (!widget.canPop) _route?.registerPopEntry(this);
    }
  }

  @override
  void dispose() {
    if (!widget.canPop) _route?.unregisterPopEntry(this);
    canPopNotifier.dispose();
    super.dispose();
  }

  void _onPopInvoked(bool _) {
    widget.onPopBlocked?.call();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
