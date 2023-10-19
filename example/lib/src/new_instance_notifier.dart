import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Displays a SnackBar and provides haptic feedback when a new app instance
/// is started, indicating that the state has been lost.
class NewInstanceNotifier extends StatefulWidget {
  const NewInstanceNotifier({super.key, required this.child});

  final Widget child;

  @override
  State<NewInstanceNotifier> createState() => _NewInstanceNotifierState();
}

class _NewInstanceNotifierState extends State<NewInstanceNotifier> {
  bool hasNotified = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasNotified) {
      hasNotified = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New app instance started')),
      );
      Future(() async {
        for (int i = 0; i < 3; i++) {
          await Future.delayed(const Duration(milliseconds: 200));
          await HapticFeedback.vibrate();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
