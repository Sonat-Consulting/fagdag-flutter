package no.sonat.solution

import android.content.Context
import android.os.BatteryManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "no.sonat.demo/native"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when(call.method) {
                "getBatteryLevel" -> {
                    getBatteryLevel().takeIf { it != -1 }?.let {
                        result.success(it)
                    } ?: result.error("UNAVAILABLE", "Battery level not available.", null)
                }
                "getOsVersion" -> result.success(getOsVersion())
                else -> result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        with(getSystemService(Context.BATTERY_SERVICE) as BatteryManager) {
            return getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        }
    }

    private fun getOsVersion(): String {
        return android.os.Build.VERSION.RELEASE
    }
}
