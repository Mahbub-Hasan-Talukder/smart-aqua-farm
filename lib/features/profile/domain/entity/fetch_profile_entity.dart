class FetchProfileEntity {
  final String name;
  final String email;
  final String profilePicture;
  final String locale;
  final String theme;

  FetchProfileEntity({
    required this.email,
    required this.name,
    required this.profilePicture,
    required this.locale,
    required this.theme,
  });
}
