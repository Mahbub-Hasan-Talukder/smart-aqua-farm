import '../../domain/entity/disease_entity.dart';
import '../../../../core/base/model/base_model.dart';

class FetchDisResponse extends BaseModel<DiseaseEntity> {
  String? id;
  String? name;
  String? description;
  String? url;
  String? symptoms;
  String? treatment;

  FetchDisResponse({
    this.id,
    this.name,
    this.description,
    this.url,
    this.symptoms,
    this.treatment,
  });

  FetchDisResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['image_url'];
    symptoms = json['symptoms'];
    treatment = json['treatment'];
  }

  @override
  toEntity() {
    return DiseaseEntity(
      id: id ?? '',
      name: name ?? 'No name found.',
      description: description ?? 'No description found.',
      url: url ?? 'No image found.',
    );
  }
}
