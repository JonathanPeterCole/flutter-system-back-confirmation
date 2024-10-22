package dev.jonathancole.system_back_confirmation

import android.app.Activity
import android.content.Intent

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SystemBackConfirmationPlugin */
class SystemBackConfirmationPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity : Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "system_back_confirmation")
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getBackWillKillApp") {
      activity?.intent?.hasCategory(Intent.CATEGORY_LAUNCHER)
      if (android.os.Build.VERSION.SDK_INT >= 31) {
        // Check the intent action and category as specified at
        // https://developer.android.com/about/versions/12/behavior-changes-all#back-press
        val intent = activity?.intent
        val isRootLauncherActivity = (intent?.action == Intent.ACTION_MAIN && intent.hasCategory(Intent.CATEGORY_LAUNCHER))
        // Although I couldn't find official documentation on this, Android also seems to kill
        // activities if the referrer is non-null.
        val hasReferrer = activity?.referrer != null
        result.success(hasReferrer || !isRootLauncherActivity)
      } else {
        result.success(true)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
