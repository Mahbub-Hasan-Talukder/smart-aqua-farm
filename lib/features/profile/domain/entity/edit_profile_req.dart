class EditProfileReq {
  String? name;
  String? profilePicture;
  String? locale;
  String? theme;

  EditProfileReq({this.name, this.profilePicture, this.locale, this.theme});

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (profilePicture != null) 'profile_picture': profilePicture,
      if (locale != null) 'locale': locale,
      if (theme != null) 'theme': theme,
    };
  }
}
