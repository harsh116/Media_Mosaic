import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import './card.dart' as customCard;
// import './video_page_full_screen.dart';
import './models/screen_arguments.dart';
import './constants.dart' as Constants;
import './pip_video.dart';
import './file_manager.dart';
import 'utils.dart';
import 'delete_overlay.dart';
import 'edit_overlay.dart';
import 'info_overlay.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required this.playlistName});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String playlistName;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVideoPageOpen = false;
  ScreenArguments args = ScreenArguments("", vidPath: '');
  List<ScreenArguments> videoDataList = [];
  ScreenArguments selectedVideoData = ScreenArguments("", vidPath: "");

  bool deleteMode = false;
  bool editMode = false;
  bool infoMode = false;

  bool isDeleteOverLay = false;
  bool isEditOverLay = false;
  bool isInfoOverLay = false;

  PopupMenuItem buildPopMenuItem(
      String title, IconData icondata, Function() onTap) {
    return PopupMenuItem(
      child: Row(
        children: [
          Icon(
            icondata,
          ),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
      onTap: onTap,
    );
  }

  bool _onKey(KeyEvent event) {
    try {
      final key = event.logicalKey.keyLabel;

      if (event is KeyUpEvent) {
        print('keyup event: $key');
        if (key == "Escape") {
          if (isDeleteOverLay || isEditOverLay || isInfoOverLay) {
            cancelAllOverLays();
          } else {
            cancelAllModes();
          }
        }
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  // List<String>? videoNames;

  // bool isVideoPageMounted
  //

  // void getPath() async {
  //   if (Platform.isAndroid) {
  //     await storagePermissions();
  //     ExternalFileManager efm = ExternalFileManager();
  //     print('path: ${await efm.localPath}');

  //     efm.writeCounter(8);
  //     print('${await efm.readCounter()}');
  //   } else
  //   // if(Platform.isLinux || Platform.isWindows )
  //   {
  //     FileManager fm = FileManager();

  //     print('path: ${await fm.localPath}');
  //     fm.writeCounter(3);
  //     print('counter: ${await fm.readCounter()}');
  //   }

  //   // FileManager fm = FileManager();

  //   // print('path: ${await fm._localPath}');
  //   // fm.writeCounter(3);
  //   // print('counter: ${await fm.readCounter()}');
  //   //
  // }

  void initializeVideos() async {
    // if (Platform.isAndroid) {
    //   await storagePermissions();
    //   ExternalFileManager efm = ExternalFileManager();
    //   print('path: ${await efm.localPath}');
    //   efm.createPlayListDirectories('Weeknd');
    // } else
    // // if(Platform.isLinux || Platform.isWindows )
    // {
    FileManager fm = FileManager();

    print('path: ${await fm.localPath}');
    fm.createPlayListDirectories(widget.playlistName);

    videoDataList = await getvideoData(fm, widget.playlistName);
    setState(() => {});
    // }
  }

  @override
  void initState() {
    ServicesBinding.instance.keyboard.addHandler(_onKey);
    // getPath();
    initializeVideos();
    // print();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  void openVideo(String title,
      {String? lyrics, String? description, required String vidPath}) {
    setState(() {
      // bringing the delete overlay and reseeting delete mode back to false
      if (deleteMode == true) {
        isDeleteOverLay = true;
        selectedVideoData = ScreenArguments(title,
            vidPath: vidPath, lyrics: lyrics, description: description);

        return;
      }

      if (editMode == true) {
        isEditOverLay = true;
        selectedVideoData = ScreenArguments(title,
            vidPath: vidPath, lyrics: lyrics, description: description);

        return;
      }

      if (infoMode == true) {
        isInfoOverLay = true;
        selectedVideoData = ScreenArguments(title,
            vidPath: vidPath, lyrics: lyrics, description: description);

        return;
      }

      print('openVideopath: $vidPath');
      // await closeVideo();
      isVideoPageOpen = true;
      args = ScreenArguments(title,
          lyrics: lyrics, vidPath: vidPath, description: description);
    });
  }

  void editVideo(bool isEdit) {
    print('Edit video');

    if (isEdit) {
      print('isEdit: true');
      initializeVideos();
    }

    isEditOverLay = false;
    selectedVideoData = ScreenArguments('', vidPath: '');
    setState(() => {});
  }

  void closeVideo() {
    setState(() {
      isVideoPageOpen = false;
      args = ScreenArguments("", vidPath: "");
    });
  }

  void deleteVideo(bool isDelete) async {
    if (isDelete) {
      FileManager fm = FileManager();
      await fm.deleteVideoAll(selectedVideoData.title, widget.playlistName);
      initializeVideos();
    }

    // String vidPath = selectedVideoData.vidPath;
    // String lyricsPath = ''

    selectedVideoData = ScreenArguments('', vidPath: '');
    isDeleteOverLay = false;
    setState(() => {});
  }

  void cancelAllModes() {
    editMode = deleteMode = infoMode = false;
    setState(() => {});
  }

  void cancelAllOverLays() {
    isDeleteOverLay = isEditOverLay = isInfoOverLay = false;
    setState(() => {});
  }

  Future<void> addVideos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          "mp3", "wav", "ogg", "flac", "aac", "wma", "m4a", "aiff",
          "opus", // Audio
          "mp4", "mkv", "avi", "mov", "wmv", "flv", "webm", "mpeg", "mpg",
          "3gp", "ogv", "ts", "m2ts", // Video
        ]);
    if (result != null) {
      List<PlatformFile> files = result.files;
      for (PlatformFile file in files) {
        FileManager fm = FileManager();
        String vidname = extractFileNameWithoutExtension(file.path!);

        // corrected now,  to be corrected, file.path is video of source not the playlistlib folder
        ScreenArguments videoData = ScreenArguments(vidname,
            vidPath: await fm.getVideoFilePath(vidname, widget.playlistName));
        videoDataList.add(videoData);

        fm.copyFileToDestination(file.path!,
            '${widget.playlistName}/videos/${extractFileName(file.path!)}');
      }
      setState(() => {});
      initializeVideos();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (ModalRoute.of(context)!.settings.name != null) {
    //   print('currentRoute: ${ModalRoute.of(context)!.settings.name}');
    //   // setState(() => {});
    // }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              // TRY THIS: Try changing the color here to a specific color (to
              // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
              // change color while the other colors stay the same.
              backgroundColor: Theme.of(context).colorScheme.primary,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(widget.title),
              centerTitle: true,
              bottomOpacity: 0.2,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // IconButton(
                    //     icon: Icon(Icons.more_vert), onPressed: () => { }),
                    (editMode || deleteMode || infoMode)
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              cancelAllModes();
                            })
                        : PopupMenuButton(
                            itemBuilder: (context) => [
                              buildPopMenuItem(
                                  'Add Videos', Icons.add, addVideos),
                              buildPopMenuItem('Delete Mode', Icons.delete, () {
                                deleteMode = true;
                                setState(() => {});
                              }),
                              buildPopMenuItem('Edit Mode', Icons.edit, () {
                                editMode = true;
                                setState(() => {});
                              }),
                              buildPopMenuItem('Info Mode', Icons.info, () {
                                infoMode = true;
                                setState(() => {});
                              }),
                            ],
                          )
                  ],
                )
              ]),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              child: Container(
                  width: MediaQuery.sizeOf(context).width >
                          (Constants.carWidth + 20)
                      ? MediaQuery.sizeOf(context).width
                      : 320,
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  // color: Colors.yellow,
                  // child: Flex(
                  //   direction: Axis.horizontal,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                  //     for (int i = 0; i < 10; i++) customCard.Card(title: 'Numb'),
                  //   ],
                  // ),import './video_page_full_screen.dart';
                  child: SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                        spacing: 40,
                        runSpacing: 20,
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: videoDataList!.map((videoData) {
                          return customCard.Card(
                            title: videoData.title,
                            arg: videoData,
                            onClickVideo: openVideo,
                          );
                        }).toList(),
                        // children: [
                        //   for (int i = 0; i < 10; i++)
                        //     customCard.Card(
                        //         title: 'Numb ${i + 1}',
                        //         onClickVideo: openVideo),
                        // ],
                      ),
                    ),
                  )),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // if (ModalRoute.of(context)!.settings.name != null) {
          //     // print('currentRoute: ${ModalRoute.of(context)!.settings.name}');
          //     // setState(() => {});
          //     // }
          //   },
          //   child: Icon(Icons.add),
          // ),
        ),
        isDeleteOverLay ? DeleteOverlay(deleteVideo: deleteVideo) : Container(),
        isEditOverLay
            ? EditOverlay(editVideo: editVideo, videoData: selectedVideoData)
            : Container(),
        isInfoOverLay
            ? InfoOverlay(
                videoData: selectedVideoData,
                closeInfoOverlay: () {
                  isInfoOverLay = false;
                  setState(() => {});
                })
            : Container(),
        isVideoPageOpen
            ? PIPVideo(args: args, closeVideo: closeVideo)
            : Container(),
      ],
    );
  }
}
