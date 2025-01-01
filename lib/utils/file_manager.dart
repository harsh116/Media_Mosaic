import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../constants.dart' as Constants;
import 'utils.dart';

// class ExternalFileManager {
//   final playlist_path = '${Constants.INTERNAL_STORGE_PATH}/Playlist_Lib';

//   Future<void> createPlayListDirectories(String playlistName) async {
//     List<String> directoriesString = [
//       'videos',
//       'lyrics',
//       'descriptions',
//       'thumbnails'
//     ];

//     String playlistDirectoryPath = '${await localPath}/$playlistName';

//     // creating playlist directory if not created
//     Directory(playlistDirectoryPath).create();

//     for (String dirString in directoriesString) {
//       Directory dir = await Directory('${playlistDirectoryPath}/$dirString');
//       dir.create();
//     }
//   }

//   // Future<void> createDirectory() async {
//   //   // final file = await File('${INTERNAL_STORGE_PATH}');
//   //   // file.

//   // }

//   // Future<List<String>> get _localPath async {
//   Future<String> get localPath async {
//     // final directory = await getApplicationDocumentsDirectory();
//     // final directories = await getExternalStorageDirectories();
//     // final directories = await getExternalCacheDirectories();
//     // return directories!.map((e) => e.path).toList();
//     // return directories!.path;
//     //
//     // return '/storage/emulated/0/playlist_flutter';
//     Directory directory = await Directory(playlist_path);
//     directory.create();
//     return playlist_path;
//   }

//   Future<File> get _localFile async {
//     // await createDirectory();
//     return File('${await localPath}/counter.txt');
//   }

//   Future<File> writeCounter(int counter) async {
//     final file = await _localFile;
//     // return file.writeAsString('$counter');
//     // return file.writeAsString('$counter\n12',
//     //     mode: FileMode.write, encoding: utf8);

//     return file.writeAsString('$counter${Platform.lineTerminator}12',
//         mode: FileMode.write, encoding: utf8);
//   }

//   Future<String> readCounter() async {
//     final file = await _localFile;
//     return file.readAsString();
//   }
// }

class FileManager {
  Future<void> createPlayListSubDirectories(String playlistName) async {
    List<String> directoriesString = [
      'videos',
      'lyrics',
      'descriptions',
      'thumbnails'
    ];

    String playlistDirectoryPath = '${await localPath}/$playlistName';

    // creating playlist directory if not created
    Directory(playlistDirectoryPath).create();

    for (String dirString in directoriesString) {
      Directory dir = await Directory('${playlistDirectoryPath}/$dirString');
      dir.create();
    }
  }

  Future<void> createPlayListDirectory(String playlistName) async {
    Directory dir = await Directory('${await localPath}/$playlistName');
    dir.create();
  }

  Future<String> get localPath async {
    Directory directory;

    if (Platform.isAndroid) {
      directory = Directory(Constants.INTERNAL_STORGE_PATH);
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    // final directory = await getExternalStorageDirectories();
    final PlayListDir = Directory('${directory.path}/PlayList_Lib');
    await PlayListDir.create();

    return PlayListDir.path;
  }

  Future<File> get _localFile async {
    final path = await localPath;
    return File('$path/counter.txt');
  }

  Future<List<String>> getPlayListNames() async {
    Directory playlistsParentDirectory = Directory('${await localPath}');
    List<String> dirs = await playlistsParentDirectory.list().map((entity) {
      String path = entity.path;
      if (!path.contains('.')) {
        return extractPlayListFromItsDirectory(path);
      }
      return "";
    }).toList();

    return dirs;
  }

  Future<bool> isFileExists(String path) async {
    final file = await File(path);
    return file.exists();
  }

  Future<void> copyFileToDestination(
      String source, String relevativeDestination,
      {bool replaceMode = false}) async {
    String destination = '${await localPath}/$relevativeDestination';
    File file = File('$source');

    File destinationFile = File(destination);

    // if same filename exists then renaming current one
    if (await destinationFile.exists() && !replaceMode) {
      destination =
          '${extractParentDirectory(destination)}/${extractFileNameWithoutExtension(destination)}_1.${extractExtension(destination)}';
      print('changed filename : $destination');
    }
    file.copy(destination);
  }

  Future<void> renameFile(String filePath, String newPath) async {
    File file = File(filePath);
    file.rename(newPath);
  }

  // relativePath here path relative to localPath ie directory where all the files is stored so relative .../PlayList_Lib
  Future<File> writeFile(String contents, String relativePath) async {
    final file = await _localFile;
    return file.writeAsString('$contents', mode: FileMode.write);
    // return file.
  }

  Future<void> writeLyricstoFile(
      String lyrics, String title, String playlistName) async {
    final file = File('${await localPath}/$playlistName/lyrics/$title.txt');
    file.writeAsString(lyrics);
  }

  Future<void> writeDescriptiontoFile(
      String description, String title, String playlistName) async {
    final file =
        File('${await localPath}/$playlistName/descriptions/$title.txt');
    file.writeAsString(description);
  }

  Future<String> getVideoFilePath(String title, String playlistName) async {
    // String path = '${await localPath}/$playlistName/videos/$title';

    String path = await getFilePathWithExtension(
        '${await localPath}/$playlistName/videos', title);
    print('video path 123: $path');
    return path;
  }

  Future<String> getLyricFilePath(String title, String playlistName) async {
    String path = '${await localPath}/$playlistName/lyrics/$title.txt';
    return path;
  }

  Future<String> getDescriptionFilePath(
      String title, String playlistName) async {
    String path = '${await localPath}/$playlistName/descriptions/$title.txt';
    return path;
  }

  Future<String> getThumbnailFilePath(String title, String playlistName) async {
    String path = await getFilePathWithExtension(
        '${await localPath}/$playlistName/thumbnails', title);
    return path;
  }

  Future<void> saveThumbnailInRespectivePath(
      String title, String playlistName, Uint8List imageData) async {
    String path = await getThumbnailFilePath(title, playlistName);

    if (path.length == 0) {
      path = '${await localPath}/$playlistName/thumbnails/$title.png';
    }

    File thumbnailFile = File(path);

    thumbnailFile.writeAsBytesSync(imageData);
  }

  // deletes video and its details too
  Future<void> deleteVideoAll(String title, String playlistName) async {
    File lyricFile = File('${await getLyricFilePath(title, playlistName)}');
    File videoFile = File('${await getVideoFilePath(title, playlistName)}');
    // File videoFile = File();
    File descriptionFile =
        File('${await getDescriptionFilePath(title, playlistName)}');
    File thumbnailFile =
        File('${await getThumbnailFilePath(title, playlistName)}');

    if (await lyricFile.exists()) {
      lyricFile.delete();
    }
    if (await videoFile.exists()) {
      videoFile.delete();
    } else {
      // print('video file dont exist');
    }
    if (await descriptionFile.exists()) {
      descriptionFile.delete();
    }
    if (await thumbnailFile.exists()) {
      thumbnailFile.delete();
    }
  }

  // changing title means changing name of all respective files in the 4 folders
  Future<void> changeTitle(
      String oldTitle, String playlistName, String newTitle) async {
    File lyricFile = File('${await getLyricFilePath(oldTitle, playlistName)}');
    File videoFile = File('${await getVideoFilePath(oldTitle, playlistName)}');
    // File videoFile = File();
    File descriptionFile =
        File('${await getDescriptionFilePath(oldTitle, playlistName)}');
    File thumbnailFile =
        File('${await getThumbnailFilePath(oldTitle, playlistName)}');

    print('before configuring new files');

    String newVidPath =
        '${extractParentDirectory('${await getVideoFilePath(oldTitle, playlistName)}')}/${newTitle}.${extractExtension('${await getVideoFilePath(oldTitle, playlistName)}')}';
    print('after newVidPath');
    String newLyricPath =
        '${extractParentDirectory('${await getLyricFilePath(oldTitle, playlistName)}')}/${newTitle}.${extractExtension('${await getLyricFilePath(oldTitle, playlistName)}')}';
    print('after newlyricsPath');
    String newDescriptionPath =
        '${extractParentDirectory('${await getDescriptionFilePath(oldTitle, playlistName)}')}/${newTitle}.${extractExtension('${await getDescriptionFilePath(oldTitle, playlistName)}')}';
    print('after newdesPath');
    String newThumbnailPath =
        '${extractParentDirectory('${await getThumbnailFilePath(oldTitle, playlistName)}')}/${newTitle}.${extractExtension('${await getThumbnailFilePath(oldTitle, playlistName)}')}';

    print('before video rename');
    videoFile.renameSync(newVidPath);
    print('after video rename');
  }

  // deletes video only
  Future<void> deleteVideoOnly(String title, String playlistName) async {
    File videoFile = File('${await getVideoFilePath(title, playlistName)}');
    if (!(await videoFile.exists())) {
      return;
    }

    videoFile.delete();
  }

  // move video to other playlist
  Future<void> moveVideosToDifferentPlaylist(String title,
      String currentPlaylistName, String anotherPlaylistName) async {
    File videoFile =
        File('${await getVideoFilePath(title, currentPlaylistName)}');

    if (!(await videoFile.exists())) {
      return;
    }

    moveFile(videoFile,
        '${await localPath}/$anotherPlaylistName/videos/${extractFileName(videoFile.path)}');

    File lyricFile =
        File('${await getLyricFilePath(title, currentPlaylistName)}');

    // File videoFile = File();
    File descriptionFile =
        File('${await getDescriptionFilePath(title, currentPlaylistName)}');
    File thumbnailFile =
        File('${await getThumbnailFilePath(title, currentPlaylistName)}');

    if (lyricFile.existsSync()) {
      moveFile(
          lyricFile, '${await getLyricFilePath(title, anotherPlaylistName)}');
    }
    if (descriptionFile.existsSync()) {
      moveFile(descriptionFile,
          '${await getDescriptionFilePath(title, anotherPlaylistName)}');
    }
    if (thumbnailFile.existsSync()) {
      moveFile(thumbnailFile,
          '${await localPath}/$anotherPlaylistName/lyrics/${extractFileName(lyricFile.path)}');
    }
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }
}

// for android

Future<void> storagePermissions() async {
  // var status = await Permission.storage.request();
  //

  // print('version: ${Platform.operatingSystemVersion}');

  DeviceInfoPlugin deviceinfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceinfo.androidInfo;
  // print('info : ${androidInfo.version.release}');

  PermissionStatus existingStatus;

  if (int.parse(androidInfo.version.release) >= 13) {
    existingStatus = await Permission.manageExternalStorage.status;
  } else {
    existingStatus = await Permission.storage.status;
  }

  if (existingStatus.isDenied) {
    PermissionStatus status;

    if (int.parse(androidInfo.version.release) >= 13) {
      status = await Permission.manageExternalStorage.request();
    } else {
      status = await Permission.storage.request();
    }

    // Permission.storage.request();
    // var status = await Permission.camera.request();

    if (status.isDenied) {
      print('storage permission denied');
    } else if (status.isGranted) {
      print('storage permission granted');
    }
  }
}
