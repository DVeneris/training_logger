class MediaItem {
  late final String? id;
  final String? userId;
  final String? name;
  late String url;
  MediaItem({this.id, this.userId, this.name, String? url}) {
    this.url = url ?? "assets/no_media.png";
  }

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      url: json['url'] ?? "assets/no_media.png",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'url': url,
    };
  }
}
