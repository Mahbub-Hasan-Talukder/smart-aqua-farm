import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_aqua_farm/features/library/domain/use_cases/library_use_cases.dart';

part 'dis_details_state.dart';

class DisDetailsCubit extends Cubit<DisDetailsState> {
  DisDetailsCubit(this._disDetUseCase) : super(DisDetailsInitial());
  final DisDetUseCase _disDetUseCase;

  void fetchDiseaseDetails(String diseaseName) async {
    emit(DisDetailsLoading());
    try {
      // Simulate fetching disease details
      await Future.delayed(const Duration(seconds: 2));

      // Mock data
      final res = await _disDetUseCase.call(diseaseName);
      res.fold((l) => emit(DisDetailsFailure(error: l)), (r) {
        final diseaseDescription = r.description;
        final diseaseSymptoms = r.symptoms;
        final diseaseTreatment = r.treatment;
        final imageUrl = r.url;

        emit(
          DisDetailsSuccess(
            diseaseName: diseaseName,
            diseaseDescription: diseaseDescription,
            diseaseSymptoms: diseaseSymptoms,
            diseaseTreatment: diseaseTreatment,
            imageUrl: imageUrl,
          ),
        );
      });
    } catch (e) {
      emit(DisDetailsFailure(error: e.toString()));
    }
  }
}
