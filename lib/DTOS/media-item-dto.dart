class MediaItemDTO {
  String? id;
  String? userId;
  String name;
  String url;
  MediaItemDTO(
      {this.id, this.userId, this.name = "", this.url = "assets/no_media.png"});
}
