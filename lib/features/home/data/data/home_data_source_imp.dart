import 'dart:io';
import 'package:flutter/services.dart';

import 'home_data_source.dart';

class HomeDataSourceImp implements HomeDataSource {
  static final platform = MethodChannel('com.example.smart_aqua_farm/pytorch');
  @override
  Future<Map<String, dynamic>> getDisease(String imagePath) async {
    try {
      await loadModel();
      final result = await predict(File(imagePath));
      return result;
    } on PlatformException catch (e) {
      throw Exception('Failed to get disease prediction: ${e.message}');
    }
  }

  Future<void> loadModel() async {
    try {
      await platform.invokeMethod('loadModel');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> predict(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final result = await platform.invokeMethod('predict', bytes);
      return Map<String, dynamic>.from(result);
    } catch (e) {
      rethrow;
    }
  }
}
