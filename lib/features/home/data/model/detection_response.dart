import 'package:smart_aqua_farm/core/base/model/base_model.dart';
import 'package:smart_aqua_farm/features/home/domain/entity/detection_entity.dart';

class DetectionResponse extends BaseModel {
  String? className;
  double? probability;
  DetectionResponse({this.className, this.probability});
  List<String> classLabels = [
    'Bacterial Red disease',
    'Bacterial diseases - Aeromoniasis',
    'Bacterial gill disease',
    'Fungal diseases - Saprolegniasis',
    'Healthy Fish',
    'Parasitic diseases',
    'Viral diseases - White tail disease',
  ];
  DetectionResponse.fromJson(Map<String, dynamic> json) {
    className = classLabels[json['prediction']['classIndex']];
    probability = json['probability'];
  }

  @override
  toEntity() {
    return DetectionEntity(
      className: className ?? 'Something went wrong',
      probability: probability ?? 0.0,
    );
  }
}
