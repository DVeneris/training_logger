class MediaItemDTO {
  String id;
  String userId;
  String name;
  String? url;
  MediaItemDTO(
      {required this.id, required this.userId, required this.name, this.url});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'url': url,
    };
  }

  factory MediaItemDTO.fromJson(Map<String, dynamic> json) {
    return MediaItemDTO(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      url: json['url'] as String?,
    );
  }
}
