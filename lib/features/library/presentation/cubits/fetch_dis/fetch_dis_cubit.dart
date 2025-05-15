import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/io/no_input.dart';
import '../../../domain/entity/disease_entity.dart';
import '../../../domain/use_cases/library_use_cases.dart';

part 'fetch_dis_state.dart';

class FetchDisCubit extends Cubit<FetchDisState> {
  FetchDisCubit(this._fetchDisUseCase) : super(FetchDisInitial());
  final FetchDisUseCase _fetchDisUseCase;

  void fetchDiseases() async {
    emit(FetchDisLoading());
    try {
      final res = await _fetchDisUseCase.call(NoInput());
      res.fold(
        (l) => emit(FetchDisFailure(error: l)),
        (r) => emit(FetchDisSuccess(diseases: r)),
      );
    } catch (e) {
      emit(FetchDisFailure(error: e.toString()));
    }
  }
}
