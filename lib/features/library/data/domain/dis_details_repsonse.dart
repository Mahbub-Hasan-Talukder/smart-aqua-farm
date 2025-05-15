import '../../../../core/base/model/base_model.dart';
import '../../domain/entity/dis_details_entity.dart';

class DisDetailsRepsonse extends BaseModel<DisDetailsEntity> {
  String? id;
  String? name;
  String? description;
  String? url;
  String? symptoms;
  String? treatment;

  DisDetailsRepsonse({
    this.id,
    this.name,
    this.description,
    this.url,
    this.symptoms,
    this.treatment,
  });

  DisDetailsRepsonse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['image_url'];
    symptoms = json['symptoms'];
    treatment = json['treatment'];
  }

  @override
  DisDetailsEntity toEntity() {
    return DisDetailsEntity(
      name: name ?? 'No name found.',
      description: description ?? 'No description found.',
      url: url ?? 'No image found.',
      symptoms: symptoms ?? 'No symptoms found.',
      treatment: treatment ?? 'No treatment found.',
    );
  }
}
