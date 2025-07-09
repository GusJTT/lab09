package com.example.lab09

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.ejemplo/calculadora"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            val a = call.argument<Int>("a") ?: 0
            val b = call.argument<Int>("b") ?: 0

            when (call.method) {
                "sumar" -> result.success(a + b)
                "restar" -> result.success(a - b)
                "multiplicar" -> result.success(a * b)
                "dividir" -> {
                    if (b != 0) {
                        result.success(a / b)
                    } else {
                        result.error("DIVISION_ERROR", "División por cero", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}