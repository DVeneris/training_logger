class UserProfileDTO {
  String? name;
  String? description;
  String? link;
  // final MediaItem? mediaItemId;
  UserProfileDTO({this.description, this.link, this.name});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
      'description': description,
    };
  }
}
