import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Disk {
  static const MethodChannel _channel = MethodChannel('disk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int> getTotalBytes(String path) async {
    return await _channel.invokeMethod("getTotalBytes", {"path": path}) as int;
  }

  static Future<int> getFreeBytes(String path) async {
    return await _channel.invokeMethod("getFreeBytes", {"path": path}) as int;
  }

  static Future<int> getUsedBytes(String path) async {
    return await _channel.invokeMethod("getUsedBytes", {"path": path}) as int;
  }

  static Future<List<String>> getStorageVolumePaths() async {
    List? storageDirectories = await getExternalStorageDirectories();

    return (storageDirectories ?? [])
        .map((storageDirectory) =>
            (storageDirectory as Directory).path.split("/Android")[0])
        .toList();
  }
}
