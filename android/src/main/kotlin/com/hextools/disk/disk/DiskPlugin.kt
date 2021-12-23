package com.hextools.disk.disk

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** DiskPlugin */
class DiskPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "disk")
    channel.setMethodCallHandler(this)
  }

  private fun getTotalBytes(path: String): Long {
    val statFs = StatFs(path)

    return statFs.totalBytes
  }

  private fun getFreeBytes(path: String): Long {
      val statFs = StatFs(path)

      return statFs.freeBytes
  }

  private fun getUsedBytes(path: String): Long {
    val statFs = StatFs(path)

    return statFs.totalBytes -statFs.freeBytes
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {

      "getTotalBytes" -> {
          val path = call.argument<String>("path")!!
          result.success(getTotalBytes(path))
      }

      "getFreeBytes" -> {
          val path = call.argument<String>("path")!!
          result.success(getFreeBytes(path))
      }

      "getUsedBytes" -> {
        val path = call.argument<String>("path")!!
        result.success(getUsedBytes(path))
      }

      "getPlatformVersion" -> {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }

      else -> {
          result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
