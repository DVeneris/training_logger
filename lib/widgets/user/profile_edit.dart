import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/providers/user_provider.dart';
import 'package:training_tracker/services/file_storage_service.dart';
import 'package:training_tracker/services/user-service.dart';
import 'package:training_tracker/utils/media_selector.dart';

import '../../utils/kawaii_textbox.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final FileStorage storage = FileStorage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);

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
        body: provider.isLoading
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
                  mediaItem: provider.userProfile.mediaItem,
                  onMediaSelectorPressed: () async {
                    final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery, imageQuality: 25);
                    File imageFile;
                    if (pickedFile == null) {
                      return;
                    }
                    imageFile = File(pickedFile.path);
                    provider.isLoading = true;
                    var mediaItem = await storage.uploadFile(imageFile);
                    if (mediaItem == null) return;
                    provider.setMediaItem(mediaItem);
                    provider.isLoading = false;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Name"),
                KawaiiTextbox(
                  initialValue: provider.userProfile.name,
                  onChange: (change) {
                    provider.userProfile.name = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Link"),
                KawaiiTextbox(
                  initialValue: provider.userProfile.link,
                  onChange: (change) {
                    provider.userProfile.link = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Description"),
                KawaiiTextbox(
                  maxlines: 3,
                  initialValue: provider.user.description,
                  onChange: (change) {
                    provider.userProfile.description = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextButton(
                    onPressed: () async {
                      await provider.updateUser();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12)),
                      child: Selector<UserProvider, bool>(
                        selector: (_, service) => service.isSaving,
                        builder: (context, saving, child) {
                          return Center(
                              child: Text(
                            saving ? 'saving...' : 'Save',
                            style: const TextStyle(color: Colors.white),
                          ));
                        },
                        shouldRebuild: (previous, next) => true,
                      ),
                    ),
                  ),
                ),
              ]));
  }
}
