import 'package:dartz/dartz.dart';
import 'package:smart_aqua_farm/features/library/data/data_source/library_data_source.dart';
import 'package:smart_aqua_farm/features/library/data/model/dis_details_repsonse.dart';
import 'package:smart_aqua_farm/features/library/domain/entity/dis_details_entity.dart';
import 'package:smart_aqua_farm/features/library/domain/entity/disease_entity.dart';
import 'package:smart_aqua_farm/features/library/domain/repository/library_repo.dart';

import '../model/fetch_dis_response.dart';

class LibraryRepoImp implements LibraryRepository {
  final LibraryDataSource _libraryDataSource;
  LibraryRepoImp(this._libraryDataSource);
  @override
  Future<Either<String, List<DiseaseEntity>>> fetchDiseases() async {
    try {
      final diseases = await _libraryDataSource.fetchDiseases();
      return Right(
        diseases.map((e) => FetchDisResponse.fromJson(e).toEntity()).toList(),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DisDetailsEntity>> fetchDiseaseDetails(
    String diseaseName,
  ) async {
    try {
      print('dbg in repo imp $diseaseName');

      final res = await _libraryDataSource.fetchDiseaseDetails(diseaseName);
      print('dbg in repo imp 1 $res');
      return Right(DisDetailsRepsonse.fromJson(res).toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
