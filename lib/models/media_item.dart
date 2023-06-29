class MediaItem {
  final String id;
  final String userId;
  final String name;
  final String? url;

  MediaItem({
    required this.id,
    required this.userId,
    required this.name,
    this.url,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      url: json['url'],
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
