import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../models/screen_arguments.dart';
import '../../../utils/file_manager.dart';
import '../../../utils/utils.dart';
import 'edit_overlay_components.dart';

class EditOverlay extends StatefulWidget {
  final Function(bool isEdit) editVideo;
  final ScreenArguments videoData;

  EditOverlay({required this.editVideo, required this.videoData});

  @override
  State<EditOverlay> createState() => _EditOverlayState();
}

class _EditOverlayState extends State<EditOverlay> {
  // creating key for form
  final formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var lyricsController = TextEditingController();
  var descriptionController = TextEditingController();

  String selectedVidPath = '';
  String selectedThumbnailPath = '';

  @override
  void initState() {
    titleController = TextEditingController(text: widget.videoData.title);
    lyricsController = TextEditingController(text: widget.videoData.lyrics);
    descriptionController =
        TextEditingController(text: widget.videoData.description);

    // vidPath = widget.videoData.vidPath;
  }

  void onChoosingVideo() async {
    print('video choosen');

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "mp3", "wav", "ogg", "flac", "aac", "wma", "m4a", "aiff",
      "opus", // Audio
      "mp4", "mkv", "avi", "mov", "wmv", "flv", "webm", "mpeg", "mpg",
      "3gp", "ogv", "ts", "m2ts", // Video
    ]);

    if (result != null) {
      PlatformFile file = result.files.first;

      // String filename = extractFileName(file.path!);
      selectedVidPath = file.path!;
      setState(() => {});
    }
  }

  void onChoosingThumbnail() async {
    print('thumbnail choosen');

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // String filename = extractFileName(file.path!);
      selectedThumbnailPath = file.path!;
      setState(() => {});
    }
  }

  Future<void> savingChanges() async {
    print('saving changes');

    String playlistName = extractPlaylistName(widget.videoData.vidPath);

    // saving title of song
    FileManager fm = FileManager();

    await fm.changeTitle(
        widget.videoData.title, playlistName, titleController.text);

    // String newVidPath =
    //     '${extractParentDirectory(widget.videoData.vidPath)}/${titleController.text}.${extractExtension(widget.videoData.vidPath)}';

    // // if(titleController.text)
    // await fm.renameFile(widget.videoData.vidPath, newVidPath);

    // changing video file
    if (selectedVidPath.length > 0) {
      await fm.copyFileToDestination(selectedVidPath,
          '${playlistName}/videos/${titleController.text}.${extractExtension(selectedVidPath)}',
          replaceMode: true);
    }

    // changing lyrics
    await fm.writeLyricstoFile(
        lyricsController.text, titleController.text, playlistName);

    // changing description
    await fm.writeDescriptiontoFile(
        descriptionController.text, titleController.text, playlistName);

    // changing thumbnail
    if (selectedThumbnailPath.length > 0) {
      String rootPath = await fm.localPath;
      String oldThumbnailPath = getFilePathWithExtension(
          '${rootPath}/$playlistName/thumbnails', titleController.text);

      if (File(oldThumbnailPath).existsSync()) {
        File(oldThumbnailPath).deleteSync();
      }

      await fm.copyFileToDestination(selectedThumbnailPath,
          '${playlistName}/thumbnails/${titleController.text}.${extractExtension(selectedThumbnailPath)}',
          replaceMode: true);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    lyricsController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double labelWidth =
        MediaQuery.of(context).size.width < 850 ? 110 : 200;

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(255, 255, 255, 0.2),
        child: Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: 300, minWidth: 350, maxWidth: 1000),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    shape: BoxShape.rectangle,
                    // border: Border.all(color: Colors.black, width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          // offset: 3,
                          spreadRadius: 2,
                          blurStyle: BlurStyle.normal),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FormRow(
                              labelWidth: labelWidth,
                              label: LabelText('Title'),
                              inputField: StyledTextFormField(
                                initialValue: widget.videoData.title,
                                controller: titleController,
                                hintValue: 'Enter title of video',
                              ),
                            ),
                            FormRow(
                              labelWidth: labelWidth,
                              label: LabelText('Video'),
                              inputField: FileChooserButton(
                                  filename: extractFileName(selectedVidPath),
                                  label: 'Choose File',
                                  onFileChoose: onChoosingVideo),
                            ),
                            FormRow(
                              labelWidth: labelWidth,
                              label: LabelText('Lyrics'),
                              inputField: StyledTextFormField(
                                initialValue: widget.videoData.lyrics ?? '',
                                controller: lyricsController,
                                hintValue: 'Enter lyrics of video',
                                isMultiLine: true,
                              ),
                            ),
                            FormRow(
                              labelWidth: labelWidth,
                              label: LabelText('Description'),
                              inputField: StyledTextFormField(
                                initialValue:
                                    widget.videoData.description ?? '',
                                controller: descriptionController,
                                hintValue: 'Enter description of video',
                                isMultiLine: true,
                              ),
                            ),
                            FormRow(
                              labelWidth: labelWidth,
                              label: LabelText('Thumbnail'),
                              inputField: FileChooserButton(
                                  filename:
                                      extractFileName(selectedThumbnailPath),
                                  label: 'Choose Image',
                                  onFileChoose: onChoosingThumbnail),
                            ),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      overlayColor: Colors.white,
                                    ),
                                    child: Text('Save',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () async {
                                      if (!validateFileName(
                                          titleController.text)) {
                                        print('invalid title name');
                                        return;
                                      }
                                      await savingChanges();
                                      widget.editVideo(true);
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      overlayColor: Colors.white,
                                    ),
                                    child: Text('Cancel',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      widget.editVideo(false);
                                    },
                                  ),
                                ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}
