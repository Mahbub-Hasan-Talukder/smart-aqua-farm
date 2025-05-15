import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_aqua_farm/features/home/domain/use_case/home_use_cases.dart';

part 'detection_state.dart';

class DetectionCubit extends Cubit<DetectionState> {
  DetectionCubit(this._detectionUseCase) : super(DetectionInitial());

  final DetectionUseCase _detectionUseCase;

  void startDetection(String imagePath) async {
    emit(DetectionLoading());
    await Future.delayed(const Duration(seconds: 1));
    final res = await _detectionUseCase.call(imagePath);
    res.fold(
      (error) {
        emit(DetectionError(message: error));
      },
      (detectionEntity) {
        emit(
          DetectionSuccess(
            className: detectionEntity.className,
            probability: detectionEntity.probability,
          ),
        );
      },
    );
  }

  void resetDetection() {
    emit(DetectionInitial());
  }
}
