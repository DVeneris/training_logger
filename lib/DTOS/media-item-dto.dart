class MediaItemDTO {
  final String? id;
  final String? userId;
  final String? name;
  late final String url;
  MediaItemDTO({this.id, this.userId, this.name, String? url}) {
    this.url = url ?? "assets/no_media.png";
  }
}
