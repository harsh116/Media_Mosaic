import 'package:flutter/material.dart';

class ScreenArguments {
  final String title;
  String? lyrics;
  // final BuildContext homepageContext;
  String vidPath;

  String? description;

  String? thumbnailPath;

  ScreenArguments(this.title,
      {this.lyrics,
      required this.vidPath,
      this.description,
      this.thumbnailPath});
}

class Lyric {
  final String title;
  final String lyrics;

  const Lyric(this.title, this.lyrics);
}
