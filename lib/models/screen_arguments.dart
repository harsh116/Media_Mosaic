import 'package:flutter/material.dart';

class ScreenArguments {
  final String title;
  String? lyrics;
  // final BuildContext homepageContext;

  ScreenArguments(this.title, {this.lyrics});
}

class Lyric {
  final String title;
  final String lyrics;

  const Lyric(this.title, this.lyrics);
}
