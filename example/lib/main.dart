import 'package:flutter/material.dart';
import 'package:simple_app_cache_manager/simple_app_cache_manager.dart';

void main() {
  runApp(const Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  String cacheSize = '';
  late final SimpleAppCacheManager cacheManager;

  @override
  void initState() {
    super.initState();
    cacheManager = SimpleAppCacheManager();
    updateCacheSize();
  }

  @override
  void didUpdateWidget(covariant Example oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateCacheSize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(cacheSize),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('clear'),
                onPressed: () {
                  cacheManager.clearCache();
                  updateCacheSize();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateCacheSize() async {
    final newSize = await cacheManager.getTotalCacheSize();
    setState(() => cacheSize = newSize);
  }
}
