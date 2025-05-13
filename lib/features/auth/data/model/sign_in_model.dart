import '../../domain/entity/user_entity.dart';

class SignInModel {
  String? email;
  String? name;
  String? id;

  SignInModel(this.email, this.name, this.id);

  SignInModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? 'No email';
    name = json['full_name'] ?? 'No name';
    id = json['id'] ?? 'No id';
  }
  UserEntity toEntity() {
    return UserEntity(email: email, name: name, id: id);
  }
}
