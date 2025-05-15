import 'package:dartz/dartz.dart';
import 'package:smart_aqua_farm/features/library/domain/entity/dis_details_entity.dart';
import '../entity/disease_entity.dart';

abstract class LibraryRepository {
  Future<Either<String, List<DiseaseEntity>>> fetchDiseases();
  Future<Either<String, DisDetailsEntity>> fetchDiseaseDetails(
    String diseaseName,
  );
}
