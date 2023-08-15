import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/models/media_item.dart';

class MediaSelector extends StatefulWidget {
  final MediaItemDTO? mediaItem;
  final Future<void> Function() onMediaSelectorPressed;
  const MediaSelector(
      {required this.mediaItem,
      required this.onMediaSelectorPressed,
      super.key});

  @override
  State<MediaSelector> createState() => _MediaSelectorState();
}

class _MediaSelectorState extends State<MediaSelector> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          widget.mediaItem != null && widget.mediaItem!.url != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(widget.mediaItem!.url!))
              : const CircleAvatar(
                  backgroundImage: AssetImage("assets/no_media.png"),
                ),
          Positioned(
              bottom: 0,
              right: -25,
              child: RawMaterialButton(
                onPressed: () async {
                  await widget.onMediaSelectorPressed();
                },
                elevation: 2.0,
                fillColor: const Color(0xFFF5F6F9),
                padding: const EdgeInsets.all(1.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.blue,
                ),
              )),
        ],
      ),
    );
  }
}
