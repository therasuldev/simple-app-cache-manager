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

class _ExampleState extends State<Example> with CacheMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: cacheSizeNotifier,
                builder: (context, cacheSize, child) => Text(cacheSize),
              ),
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
}

mixin CacheMixin on State<Example> {
  late final SimpleAppCacheManager cacheManager;
  late ValueNotifier<String> cacheSizeNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    cacheManager = SimpleAppCacheManager();
    updateCacheSize();
  }

  void updateCacheSize() async {
    final cacheSize = await cacheManager.getTotalCacheSize();
    cacheSizeNotifier.value = cacheSize;
  }
}
