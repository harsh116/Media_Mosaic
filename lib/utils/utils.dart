import 'dart:io';
import 'dart:async';
import 'dart:core';

import 'file_manager.dart';
import '../models/screen_arguments.dart';

Future<List<ScreenArguments>> getvideoData(
    FileManager fm, String playlistName) async {
  String rootPath = await fm.localPath;
  final directory = Directory('${rootPath}/$playlistName/videos');
  List<ScreenArguments> videoDataList = await directory.list().map((file) {
    String path = file.path;
    // print('path: $path');
    String vidName = RegExp(r'.+/(.+)\..+').firstMatch(path)!.group(1) ?? '';
    String vidPath = file.path;

    String lyricsPath = '${rootPath}/$playlistName/lyrics/$vidName.txt';
    String descriptionPath =
        '${rootPath}/$playlistName/descriptions/$vidName.txt';
    // String thumbnailPath = '${rootPath}/$playlistName/thumbnails/$vidName.txt';
    String thumbnailPath = getFilePathWithExtension(
        '${rootPath}/$playlistName/thumbnails', vidName);

    // print('thumbnailPath: $thumbnailPath');

    String? lyrics;
    String? description;

    try {
      final lyricFile = File(lyricsPath);
      if (lyricFile.existsSync()) {
        lyrics = lyricFile.readAsStringSync();
      }

      final descriptionFile = File(descriptionPath);
      if (descriptionFile.existsSync()) {
        description = descriptionFile.readAsStringSync();
      }

      // description = File(descriptionPath).readAsStringSync();
    } catch (e) {
      print(e.toString());
    }

    bool isThumbnailExists = File(thumbnailPath).existsSync();

    return ScreenArguments(vidName,
        vidPath: vidPath,
        lyrics: lyrics,
        description: description,
        thumbnailPath: isThumbnailExists ? thumbnailPath : null);
  }).toList();

  return videoDataList;
}

Future<List<String>> getvideoNames(FileManager fm, String playlistName) async {
  final directory = Directory('${await fm.localPath}/$playlistName/videos');
  List<String> dirPaths = await directory.list().map((file) {
    String path = file.path;
    String vidName = RegExp(r'.+/(.+)\..+').firstMatch(path)!.group(1) ?? '';
    return vidName;
  }).toList();

  return dirPaths;
}

String extractFileNameWithoutExtension(String vidPath) {
  String vidName = RegExp(r'.+/(.+)\..+').firstMatch(vidPath)!.group(1) ?? '';
  return vidName;
}

String extractPlaylistName(String vidPath) {
  String vidName =
      RegExp(r'PlayList_Lib/(.*)/.*/.*').firstMatch(vidPath)!.group(1) ?? '';
  print('playlist name: $vidName');
  return vidName;
}

String extractFileName(String vidPath) {
  String vidName = RegExp(r'.+/(.+\..+)').firstMatch(vidPath)?.group(1) ?? '';
  return vidName;
}

String extractParentDirectory(String vidPath) {
  String vidName = RegExp(r'^(.+)/.+\..+$').firstMatch(vidPath)!.group(1) ?? '';
  return vidName;
}

String extractExtension(String vidPath) {
  String vidName = RegExp(r'.+/.+\.(.+)').firstMatch(vidPath)!.group(1) ?? '';
  return vidName;
}

Future<List<String>> getvideoLyrics(FileManager fm, String playlistName) async {
  final directory = Directory('${await fm.localPath}/$playlistName/lyrics');
  List<String> dirPaths = await directory.list().map((file) {
    return file.path;
  }).toList();

  return dirPaths;
}

Future<List<String>> getvideoDescriptions(
    FileManager fm, String playlistName) async {
  final directory =
      Directory('${await fm.localPath}/$playlistName/descriptions');
  List<String> dirPaths = await directory.list().map((file) {
    return file.path;
  }).toList();

  return dirPaths;
}

String getFilePathWithExtension(String parentDirectory, String filename) {
  Directory dir = Directory(parentDirectory);

  List<FileSystemEntity> entities = dir.listSync();
  for (FileSystemEntity entity in entities) {
    if (extractFileNameWithoutExtension(entity.path) == filename) {
      return entity.path;
    }
  }

  // if file with given filename not found then returning empty string as path
  return "";
}