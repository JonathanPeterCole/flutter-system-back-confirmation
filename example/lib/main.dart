import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:system_back_confirmation/system_back_confirmation.dart';

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
      builder: (context, child) => SystemBackConfirmation(child: child!),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example app'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Push route'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DemoPage()),
          ),
        ),
      ),
    );
  }
}
