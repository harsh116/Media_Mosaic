import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:get_thumbnail_video/video_thumbnail.dart';

import './models/screen_arguments.dart';
import './lyrics.dart';

import './constants.dart' as Constants;

class Card extends StatefulWidget {
  Card(
      {super.key,
      required this.title,
      required this.onClickVideo,
      required this.arg});
  final String title;
  final ScreenArguments arg;

  void Function(String,
      {String? lyrics,
      String? description,
      required String vidPath}) onClickVideo;

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  String? lyrics;

  Uint8List? uint8list;

  // void loadThumbnail() async {
  //   uint8list = await VideoThumbnail.thumbnailData(
  //     video: widget.arg.vidPath,
  //     maxWidth: Constants.carWidth.toInt(),
  //   );
  //   setState(() => {});
  // }

  @override
  void initState() {
    // loadThumbnail();
  }

  // @override
  // void initState() {
  //   for (Lyric lyric in lyricsList) {
  //     if (widget.title == lyric.title) {
  //       setState(() {
  //         lyrics = lyric.lyrics;
  //       });
  //     }
  //   }

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // for (Lyric lyric in lyricsList) {
    //   if (widget.title == lyric.title) {
    //     setState(() {
    //       lyrics = lyric.lyrics;
    //     });
    //   }
    // }
    double carWidth = Constants.carWidth;
    double videoIconSize = Constants.videoIconSize;
    double imageHeight = Constants.imageHeight;

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        clipBehavior: Clip.hardEdge,
        // constraints: BoxConstraints()

        // position: DecorationPosition.foreground,
        child: Stack(
          children: <Widget>[
            FittedBox(
              child: Column(children: [
                // Image.memory(
                //   uint8list!,
                // ),
                widget.arg.thumbnailPath != null
                    ? Image.memory(
                        File(widget.arg.thumbnailPath!).readAsBytesSync(),
                        width: carWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'asset/black-background.png',
                        width: carWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                Container(
                  width: carWidth,

                  // width: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    // color: Colors.pink,
                  ),
                  child: Text(widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      )),
                ),
              ]),
            ),
            Positioned(
              child: TextButton(
                child: Icon(
                  Icons.play_arrow,
                  size: videoIconSize,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                onPressed: null,
              ),
              left: carWidth / 2 - videoIconSize / 2,
              top: (imageHeight - videoIconSize) / 2,
            ),
            TextButton(
              child: SizedBox(
                width: carWidth,
                height: imageHeight,
                // constraints: BoxConstraints(maxWidth: carWidth),
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: Colors.blue,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  )),
              clipBehavior: Clip.hardEdge,
              onPressed: () {
                print('overlay pressed');
                widget.onClickVideo(widget.title,
                    lyrics: widget.arg.lyrics,
                    description: widget.arg.description,
                    vidPath: widget.arg.vidPath);

                // Navigator.pushNamed(
                //   context,
                //   '/video',
                //   // arguments: {'title': 'Numb'},
                //   arguments: ScreenArguments(widget.title,
                //       homepageContext: context, lyrics: lyrics),
                // );
              },
            ),
          ],
        ));
  }
}
