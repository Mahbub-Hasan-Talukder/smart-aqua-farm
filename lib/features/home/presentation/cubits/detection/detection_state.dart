part of 'detection_cubit.dart';

class DetectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetectionInitial extends DetectionState {}

class DetectionLoading extends DetectionState {}

class DetectionSuccess extends DetectionState {
  final String className;
  final double probability;
  DetectionSuccess({required this.className, required this.probability});

  @override
  List<Object?> get props => [className, probability];
}

class DetectionError extends DetectionState {
  final String message;
  DetectionError({required this.message});

  @override
  List<Object?> get props => [message];
}
