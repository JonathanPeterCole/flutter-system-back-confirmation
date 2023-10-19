import 'package:flutter/material.dart';

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
