import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/services/file_storage_service.dart';
import 'package:training_tracker/services/user-service.dart';
import 'package:training_tracker/utils/media_selector.dart';

import '../../utils/kawaii_textbox.dart';

class ProfileEdit extends StatefulWidget {
  final UserDTO user;
  const ProfileEdit({required this.user, super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final FileStorage storage = FileStorage();
  late UserProfileDTO userprofiledata;
  @override
  void initState() {
    userprofiledata = UserProfileDTO(
        description: widget.user.description,
        link: widget.user.link,
        name: widget.user.name,
        mediaItem: widget.user.mediaItem);
    super.initState();
  }

  bool isSaving = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.chevron_left_rounded),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Edit Profile"),
        ),
        body: isLoading
            ? Center(
                child: Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    color: Color.fromARGB(255, 128, 8, 8),
                    strokeWidth: 3,
                  ),
                ),
              )
            : Column(children: [
                MediaSelector(
                  mediaItem: userprofiledata.mediaItem,
                  onMediaSelectorPressed: () async {
                    var results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg']);
                    if (results == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("No file selected")));
                    }
                    final path = results?.files.single.path;
                    // final fileName = results?.files.single.name;
                    // print(path);
                    // print(fileName);
                    if (path == null) return;
                    setState(() {
                      isLoading = true;
                    });
                    var mediaItem = await storage.uploadFile(path);
                    userprofiledata.mediaItem = mediaItem;
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Name"),
                KawaiiTextbox(
                  initialValue: userprofiledata.name,
                  onChange: (change) {
                    userprofiledata.name = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Description"),
                KawaiiTextbox(
                  initialValue: userprofiledata.description,
                  onChange: (change) {
                    userprofiledata.description = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Link"),
                KawaiiTextbox(
                  initialValue: userprofiledata.link,
                  onChange: (change) {
                    userprofiledata.link = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        isSaving = true;
                      });
                      await UserService().updateUser(userprofiledata);
                      setState(() {
                        isSaving = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12)),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                            child: Text(
                          "${isSaving ? 'saving...' : 'Save'}",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ]));
  }
}
                // SizedBox(
                //   height: 115,
                //   width: 115,
                //   child: Stack(
                //     clipBehavior: Clip.none,
                //     fit: StackFit.expand,
                //     children: [
                //       userprofiledata.mediaItem != null
                //           ? CircleAvatar(
                //               backgroundImage:
                //                   NetworkImage(userprofiledata.mediaItem!.url!))
                //           : const CircleAvatar(
                //               backgroundImage:
                //                   AssetImage("assets/no_media.png"),
                //             ),
                //       Positioned(
                //           bottom: 0,
                //           right: -25,
                //           child: RawMaterialButton(
                //             onPressed: () async {
                //               var results = await FilePicker.platform.pickFiles(
                //                   allowMultiple: false,
                //                   type: FileType.custom,
                //                   allowedExtensions: ['png', 'jpg']);
                //               if (results == null) {
                //                 ScaffoldMessenger.of(context).showSnackBar(
                //                     const SnackBar(
                //                         content: Text("No file selected")));
                //               }
                //               final path = results?.files.single.path;
                //               // final fileName = results?.files.single.name;
                //               // print(path);
                //               // print(fileName);
                //               if (path == null) return;
                //               setState(() {
                //                 isLoading = true;
                //               });
                //               var mediaItem = await storage.uploadFile(path);
                //               userprofiledata.mediaItem = mediaItem;
                //               setState(() {
                //                 isLoading = false;
                //               });
                //             },
                //             elevation: 2.0,
                //             fillColor: Color(0xFFF5F6F9),
                //             child: Icon(
                //               Icons.camera_alt_outlined,
                //               color: Colors.blue,
                //             ),
                //             padding: EdgeInsets.all(1.0),
                //             shape: CircleBorder(),
                //           )),
                //     ],
                //   ),
                // ),