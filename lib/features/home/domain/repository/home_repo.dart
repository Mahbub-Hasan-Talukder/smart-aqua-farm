import 'package:dartz/dartz.dart';

import '../entity/detection_entity.dart';

abstract class HomeRepository {
  Future<Either<String, DetectionEntity>> detectDisease(String imagePath);
}
