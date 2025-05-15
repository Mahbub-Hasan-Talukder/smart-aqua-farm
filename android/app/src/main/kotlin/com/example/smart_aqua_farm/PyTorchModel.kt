package com.example.smart_aqua_farm

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream
import org.pytorch.IValue
import org.pytorch.Module
import org.pytorch.Tensor
import org.pytorch.torchvision.TensorImageUtils

class PyTorchModel(private val context: Context) {

    private var model: Module? = null

    fun loadModel() {
        model = Module.load(assetFilePath(context, "efficientnetb0_fish_scripted.pt"))
    }

    fun predict(imageBytes: ByteArray, result: MethodChannel.Result) {
        try {

            val startTime = System.currentTimeMillis()

            // Convert byte array to Bitmap
            val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)

            // Preprocess the image (convert to tensor)
            val inputTensor = preprocessImage(bitmap)

            // Run inference
            val outputTensor = model?.forward(IValue.from(inputTensor))?.toTensor()

            // Postprocess the output
            val output = postprocessOutput(outputTensor)

            val endTime = System.currentTimeMillis() // Capture end time

            val inferenceTime = endTime - startTime // Calculate time taken

            // Return result and inference time as a map
            val response = mapOf("prediction" to output, "timeTakenMs" to inferenceTime)

            result.success(response) // Send map to Flutter
        } catch (e: Exception) {
            result.error("PREDICTION_ERROR", e.message, null)
        }
    }

    private fun assetFilePath(context: Context, assetName: String): String {
        val file = File(context.filesDir, assetName)
        if (file.exists() && file.length() > 0) {
            return file.absolutePath
        }

        context.assets.open(assetName).use { inputStream ->
            FileOutputStream(file).use { outputStream ->
                val buffer = ByteArray(4 * 1024)
                var read: Int
                while (inputStream.read(buffer).also { read = it } != -1) {
                    outputStream.write(buffer, 0, read)
                }
                outputStream.flush()
            }
        }
        return file.absolutePath
    }

    private fun preprocessImage(bitmap: Bitmap): Tensor {
        // Convert Bitmap to Tensor
        return TensorImageUtils.bitmapToFloat32Tensor(
                bitmap,
                TensorImageUtils.TORCHVISION_NORM_MEAN_RGB,
                TensorImageUtils.TORCHVISION_NORM_STD_RGB
        )
    }

    private fun postprocessOutput(outputTensor: Tensor?): Map<String, Any> {
        // Handle null tensor
        if (outputTensor == null) {
            return mapOf(
                    "classIndex" to -1,
                    "probabilities" to listOf<Double>(),
                    "confidence" to 0.0
            )
        }

        // Get scores from tensor
        val scores = outputTensor.dataAsFloatArray

        // Calculate softmax probabilities
        val expScores = scores.map { Math.exp(it.toDouble()) }
        val sumExpScores = expScores.sum()
        val probabilities = expScores.map { (it / sumExpScores) * 100 } // Convert to percentages

        // Get predicted class index
        val classIndex = probabilities.indices.maxByOrNull { probabilities[it] } ?: -1
        val confidence = probabilities[classIndex]
        // Return as map
        return mapOf(
                "classIndex" to classIndex,
                "probabilities" to probabilities,
                "confidence" to confidence,
        )
    }
}
