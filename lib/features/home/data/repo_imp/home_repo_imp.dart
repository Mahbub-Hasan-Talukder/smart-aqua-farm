import 'package:dartz/dartz.dart';
import 'package:smart_aqua_farm/features/home/domain/entity/detection_entity.dart';

import '../../domain/repository/home_repo.dart';
import '../data/home_data_source.dart';
import '../model/detection_response.dart';

class HomeRepoImp implements HomeRepository {
  final HomeDataSource homeRemoteDataSource;
  HomeRepoImp(this.homeRemoteDataSource);

  @override
  Future<Either<String, DetectionEntity>> detectDisease(
    String imagePath,
  ) async {
    try {
      final res = await homeRemoteDataSource.getDisease(imagePath);
      return Right(DetectionResponse.fromJson(res).toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
