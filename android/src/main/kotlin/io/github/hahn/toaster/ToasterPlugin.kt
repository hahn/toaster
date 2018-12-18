package io.github.hahn.toaster

import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

import android.widget.Toast

class ToasterPlugin(private val registrar: Registrar): MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "toaster")
      channel.setMethodCallHandler(ToasterPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if(call.method == "toast") {

        val msg: String? = call.argument("message")
        val duration: Int? = call.argument("duration")
        Log.d("TAG", "toast: $msg ")
        val d = when(duration) {
            0 -> Toast.LENGTH_SHORT
            else -> Toast.LENGTH_LONG
        }

        Toast.makeText(registrar.context(), msg, d).show()

    } else {
      result.notImplemented()
    }
  }
}
