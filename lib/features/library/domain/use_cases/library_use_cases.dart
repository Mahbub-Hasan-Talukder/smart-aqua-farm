import 'package:dartz/dartz.dart';
import 'package:smart_aqua_farm/core/io/no_input.dart';
import 'package:smart_aqua_farm/features/library/domain/entity/dis_details_entity.dart';
import 'package:smart_aqua_farm/features/library/domain/entity/disease_entity.dart';

import '../../../../core/base/use_case/base_use_case.dart';
import '../repository/library_repo.dart';

class FetchDisUseCase
    extends BaseUseCase<String, NoInput, List<DiseaseEntity>> {
  final LibraryRepository _libraryRepository;
  FetchDisUseCase(this._libraryRepository);
  @override
  Future<Either<String, List<DiseaseEntity>>> call(NoInput input) async {
    return await _libraryRepository.fetchDiseases();
  }
}

class DisDetUseCase extends BaseUseCase<String, String, DisDetailsEntity> {
  final LibraryRepository _libraryRepository;
  DisDetUseCase(this._libraryRepository);
  @override
  Future<Either<String, DisDetailsEntity>> call(String input) async {
    return await _libraryRepository.fetchDiseaseDetails(input);
  }
}
