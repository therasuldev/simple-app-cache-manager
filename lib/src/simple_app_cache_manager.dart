import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:simple_app_cache_manager/src/i_simple_app_cache_manager.dart';

/// A cache manager implementation that manages application cache.
///
/// This class implements the [ISimpleAppCacheManager] interface and provides methods
/// to [check] cache existence, calculate total cache [size], and [clear] the cache.
/// It uses platform-specific methods to interact with the cache directory
/// and communicate with native code through method channels.
class SimpleAppCacheManager extends ISimpleAppCacheManager {
  final MethodChannel _channel = const MethodChannel('simple_app_cache_manager');

  @override
  Future<bool> get checkCacheExistence async {
    try {
      if (Platform.isAndroid) {
        final tempDir = await getTemporaryDirectory();
        final okAnroid = tempDir.existsSync();
        return okAnroid;
      } else if (Platform.isIOS) {
        final okIOS = await _channel.invokeMethod('checkCacheExistence');
        return okIOS;
      }
    } on PlatformException catch (exception) {
      dev.log(exception.message!);
    }

    return false;
  }

  @override
  Future<String> getTotalCacheSize() async {
    try {
      if (Platform.isAndroid) {
        final tempDir = await getTemporaryDirectory();
        final tempDirSize = _calculateDirectorySize(tempDir);
        return _formatBytes(tempDirSize);
      } else if (Platform.isIOS) {
        final tempDirSize = await _channel.invokeMethod('getTotalCacheSize');
        return tempDirSize;
      }
    } on PlatformException catch (exception) {
      dev.log(exception.message!);
    }

    return '0 B';
  }

  @override
  void clearCache() async {
    try {
      if (Platform.isAndroid) {
        final cacheDir = await getTemporaryDirectory();
        if (cacheDir.existsSync()) {
          cacheDir.deleteSync(recursive: true);
        }
      } else if (Platform.isIOS) {
        await _channel.invokeMethod('clearCache');
      }
    } on PlatformException catch (exception) {
      dev.log(exception.message!);
    }
  }

  /// will convert the received cache size into a appropriate format.
  ///
  /// This method is intended only for the Android platform
  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    final List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int index = (log(bytes) / log(1024)).floor();
    double size = bytes / pow(1024, index);
    return '${size.toStringAsFixed(2)} ${units[index]}';
  }

  /// This method is intended only for the Android platform
  int _calculateDirectorySize(FileSystemEntity file) {
    if (file is File) {
      return file.lengthSync();
    } else if (file is Directory) {
      int sum = 0;
      List<FileSystemEntity> children = file.listSync();
      for (FileSystemEntity child in children) {
        sum += _calculateDirectorySize(child);
      }
      return sum;
    }
    return 0;
  }
}
