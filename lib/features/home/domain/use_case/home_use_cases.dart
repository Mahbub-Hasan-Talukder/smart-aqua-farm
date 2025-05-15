import 'package:dartz/dartz.dart';

import '../../../../core/base/use_case/base_use_case.dart';
import '../entity/detection_entity.dart';
import '../repository/home_repo.dart';

class DetectionUseCase extends BaseUseCase<String, String, DetectionEntity> {
  final HomeRepository _homeRepository;
  DetectionUseCase(this._homeRepository);
  @override
  Future<Either<String, DetectionEntity>> call(String input) async {
    return await _homeRepository.detectDisease(input);
  }
}
