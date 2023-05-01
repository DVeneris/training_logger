class MediaItem {
  //String? id;
  String? name;
  late String url;
  MediaItem({String? url}) {
    this.url = url ?? "assets/no_media.png";
  }
}
