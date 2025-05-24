import 'dart:io';
import 'dart:typed_data';

import 'package:pytorch_lite/pytorch_lite.dart';

import 'home_data_source.dart';

class FlutterPytorchImp implements HomeDataSource {
  @override
  Future<Map<String, dynamic>> getDisease(String imagePath) async {
    ClassificationModel classificationModel =
        await PytorchLite.loadClassificationModel(
          "assets/ai_models/model.pt",
          224,
          224,
          7,
        );
    final Uint8List binaryImage = await File(imagePath).readAsBytes();
    final imagePrediction = await classificationModel.getImagePredictionList(
      binaryImage,
    );

    double confidence = 0;
    int classIndex = 0;
    for (int i = 0; i < 7; i++) {
      if (imagePrediction[i] > confidence) {
        confidence = imagePrediction[i];
        classIndex = i;
      }
    }
    return {"class_index": classIndex, "confidence": confidence};
  }
}
