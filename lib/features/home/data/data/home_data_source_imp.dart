import 'dart:io';
import 'package:flutter/services.dart';

import 'home_data_source.dart';

class HomeDataSourceImp implements HomeDataSource {
  static const platform = MethodChannel('com.example.smart_aqua_farm/pytorch');
  static bool _modelLoaded = false;

  @override
  Future<Map<String, dynamic>> getDisease(String imagePath) async {
    try {
      // Load model if not already loaded
      if (!_modelLoaded) {
        await loadModel();
        _modelLoaded = true;
      }

      final result = await predict(File(imagePath));
      return result;
    } on PlatformException catch (e) {
      String errorMsg;
      switch (e.code) {
        case 'MODEL_NOT_LOADED':
          errorMsg =
              'Failed to load the disease detection model. Please try restarting the app.';
          break;
        case 'PREDICTION_ERROR':
          errorMsg = 'Error processing the image: ${e.message}';
          break;
        default:
          errorMsg = 'Failed to get disease prediction: ${e.message}';
      }
      throw Exception(errorMsg);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> loadModel() async {
    try {
      await platform.invokeMethod('loadModel');
    } on PlatformException catch (e) {
      _modelLoaded = false;
      throw Exception('Failed to load model: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> predict(File imageFile) async {
    try {
      if (!imageFile.existsSync()) {
        throw Exception('Image file does not exist');
      }

      final bytes = await imageFile.readAsBytes();
      if (bytes.isEmpty) {
        throw Exception('Image file is empty');
      }

      final result = await platform.invokeMethod('predict', bytes);
      final prediction = Map<String, dynamic>.from(result);

      // Validate prediction result
      if (!prediction.containsKey('prediction')) {
        throw Exception('Invalid prediction result format');
      }

      return prediction;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to process image: $e');
    }
  }
}
