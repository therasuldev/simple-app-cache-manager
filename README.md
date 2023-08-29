# Simple App Cache Manager

A Flutter package for managing application cache efficiently. This package provides methods to check cache existence, calculate total cache size, and clear the cache. It is designed to simplify cache management, especially for file system caching.


## Features

- Check if cache exists
- Calculate total cache size
- Clear cache

## Installation

To use this package, add **simple_app_cache_manager** as a dependency in your `pubspec.yaml` file.

```bash
dependencies:
  flutter:
    sdk: flutter
  simple_app_cache_manager: ^0.0.1  # Use the latest version
```
Then run the following command to fetch the package:

```bash
flutter pub get
```


## Usage


```dart
import 'package:simple_app_cache_manager/simple_app_cache_manager.dart';
import 'package:flutter/material.dart';

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

```

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.


## Additional information

This package provides a unified way to manage cache in Flutter applications across both Android and iOS platforms. The cache management is achieved through a combination of Flutter and native code.

### Android Cache Management

Android cache management is handled entirely within the Flutter environment. The package leverages the `getTemporaryDirectory` method from the `path_provider` package to access and manage the Android cache directory. The methods provided by the package are platform-agnostic and work seamlessly on Android.

### iOS Cache Management

For iOS cache management, native Swift code is used to interact with the cache system. The package includes a Swift bridge that communicates with the Flutter environment through method channels. This approach ensures efficient and accurate cache management on iOS devices.