import '../../../../core/base/model/base_model.dart';
import '../../domain/entity/fetch_profile_entity.dart';

class FetchProfileResponse extends BaseModel<FetchProfileEntity> {
  String? name;
  String? email;
  String? profilePicture;
  String? theme;
  String? locale;

  FetchProfileResponse({
    this.email,
    this.name,
    this.locale,
    this.profilePicture,
    this.theme,
  });

  FetchProfileResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    profilePicture = json['profile_picture'];
    locale = json['locale'];
    theme = json['theme'];
  }

  @override
  FetchProfileEntity toEntity() {
    return FetchProfileEntity(
      email: email ?? 'N/A',
      name: name ?? 'No User Found',
      profilePicture:
          profilePicture ??
          'https://img.freepik.com/premium-vector/vector-flat-illustration-grayscale-avatar-user-profile-person-icon-profile-picture-business-profile-woman-suitable-social-media-profiles-icons-screensavers-as-templatex9_719432-1310.jpg?semt=ais_items_boosted&w=740',
      locale: locale ?? 'N/A',
      theme: theme ?? 'N/A',
    );
  }
}
