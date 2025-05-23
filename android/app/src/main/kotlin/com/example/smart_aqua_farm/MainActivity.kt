package com.example.smart_aqua_farm

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.smart_aqua_farm/pytorch"
    private lateinit var pytorchModel: PyTorchModel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        pytorchModel = PyTorchModel(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "loadModel" -> {
                    pytorchModel.loadModel()
                    result.success(null)
                }
                "predict" -> {
                    val imageBytes = call.arguments as ByteArray  // Receive bytes
                    pytorchModel.predict(imageBytes, result)
                }
                else -> result.notImplemented()
            }
        }
        
    }
}
