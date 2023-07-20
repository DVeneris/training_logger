import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';
import 'package:training_tracker/services/file_storage_service.dart';
import 'package:training_tracker/utils/media_selector.dart';

class ExerciseCreator extends StatefulWidget {
  const ExerciseCreator({super.key});

  @override
  State<ExerciseCreator> createState() => _ExerciseCreatorState();
}

class _ExerciseCreatorState extends State<ExerciseCreator> {
  final user = AuthService().getUser(); //na vinei me DI
  bool isLoading = false;
  var _exerciseDTO = ExerciseDTO(unit: WeightUnit.kg);
  final TextEditingController _exerciseGroupController =
      TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _equipmentController = TextEditingController();
  final FileStorage storage = FileStorage();
  ExerciseGroup? selectedExerciseGroup;
  Equipment? selectedEquipment;
  @override
  void initState() {
    super.initState();
    _exerciseNameController.addListener(() => _onExerciseNameChange());
  }

  _onExerciseNameChange() {
    _exerciseDTO.name = _exerciseNameController.text;
  }

  @override
  void dispose() {
    super.dispose();
    _equipmentController.dispose();
    _exerciseNameController.dispose();
    _exerciseGroupController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ExerciseGroup>> groupEntries =
        <DropdownMenuEntry<ExerciseGroup>>[];

    for (final ExerciseGroup group in ExerciseGroup.values) {
      groupEntries.add(
          DropdownMenuEntry<ExerciseGroup>(value: group, label: group.name));
    }
    final List<DropdownMenuEntry<Equipment>> equipmentEntries =
        <DropdownMenuEntry<Equipment>>[];

    for (final Equipment equipment in Equipment.values) {
      equipmentEntries.add(DropdownMenuEntry<Equipment>(
          value: equipment, label: equipment.name));
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: const Center(
              child: Text("Create new exercise",
                  style: TextStyle(color: Colors.black))),
          leading: TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 15,
                ),
                foregroundColor: Colors.blue),
            onPressed: () {},
            child: const Text("cancel"),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    foregroundColor: Colors.blue),
                onPressed: () async {
                  if (_exerciseDTO.name.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Empty Exercise Name'),
                          content: const Text(
                              'Please enter a name for the exercise.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  await ExerciseService().createExercise(_exerciseDTO);
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: const Text("Save"),
              ),
            ),
          ],
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
            : Column(
                children: [
                  MediaSelector(
                    mediaItem: _exerciseDTO.mediaItem,
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
                      if (path == null) return;
                      setState(() {
                        isLoading = true;
                      });
                      var mediaItem = await storage.uploadFile(path);
                      _exerciseDTO.mediaItem = mediaItem;
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("Exercise Name"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _exerciseNameController,
                    ),
                  ),
                  const Text("Muscle Group"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: DropdownMenu<ExerciseGroup>(
                      initialSelection: ExerciseGroup.biceps,
                      controller: _exerciseGroupController,
                      leadingIcon: const Icon(Icons.search),
                      label: const Text('GROUP'),
                      dropdownMenuEntries: groupEntries,
                      onSelected: (ExerciseGroup? group) {
                        setState(() {
                          _exerciseDTO.exerciseGroup =
                              group ?? ExerciseGroup.biceps;
                        });
                      },
                    ),
                  ),
                  const Text("Equipment"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: DropdownMenu<Equipment>(
                      enableSearch: false,
                      initialSelection: Equipment.barbell,
                      controller: _equipmentController,
                      leadingIcon: const Icon(Icons.search),
                      label: const Text('GROUP'),
                      dropdownMenuEntries: equipmentEntries,
                      onSelected: (Equipment? equipment) {
                        setState(() {
                          _exerciseDTO.equipment =
                              equipment ?? Equipment.barbell;
                        });
                      },
                    ),
                  )
                ],
              ));
  }
}
