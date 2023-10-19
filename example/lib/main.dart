import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:system_back_confirmation/system_back_confirmation.dart';
import 'package:system_back_confirmation_example/src/demo_page.dart';
import 'package:system_back_confirmation_example/src/new_instance_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => SystemBackConfirmation(
        child: NewInstanceNotifier(
          child: child!,
        ),
      ),
      home: const DemoPage(),
    );
  }
}
