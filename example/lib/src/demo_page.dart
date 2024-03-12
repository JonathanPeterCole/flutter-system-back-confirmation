import 'package:flutter/material.dart';
import 'package:system_back_confirmation/system_back_confirmation.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _canPop = true;

  void onPopBlocked(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'If you leave this page, your progress will be lost.',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Leave'),
            onPressed: () {
              Navigator.pop(context);
              popRouteOrExit(context);
            },
          ),
          TextButton(
            child: const Text('Stay'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScopeConfirmation(
      canPop: _canPop,
      onPopBlocked: () => onPopBlocked(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Example app'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile.adaptive(
                value: !_canPop,
                onChanged: (value) => setState(() => _canPop = !value),
                title: const Text('Show confirmation dialog on pop?'),
              ),
              ElevatedButton(
                child: const Text('Push route'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DemoPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
