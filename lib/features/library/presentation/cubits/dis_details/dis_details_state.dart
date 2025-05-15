part of 'dis_details_cubit.dart';

class DisDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DisDetailsInitial extends DisDetailsState {}

class DisDetailsLoading extends DisDetailsState {}

class DisDetailsSuccess extends DisDetailsState {
  final String diseaseName;
  final String diseaseDescription;
  final String diseaseSymptoms;
  final String diseaseTreatment;
  final String imageUrl;

  DisDetailsSuccess({
    required this.diseaseName,
    required this.diseaseDescription,
    required this.diseaseSymptoms,
    required this.diseaseTreatment,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
    diseaseName,
    diseaseDescription,
    diseaseSymptoms,
    diseaseTreatment,
    imageUrl,
  ];
}

class DisDetailsFailure extends DisDetailsState {
  final String error;

  DisDetailsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
