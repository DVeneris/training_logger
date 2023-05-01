class MediaItem {
  String? name;
  late String url;

  MediaItem({this.name, String? url}) {
    this.url = url ?? "assets/no_media.png";
  }

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      name: json['name'],
      url: json['url'] ?? "assets/no_media.png",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }
}
