import 'package:flutter/material.dart';

import './models/screen_arguments.dart';
import './lyrics.dart';

import './constants.dart' as Constants;

class Card extends StatefulWidget {
  const Card({super.key, required this.title});
  final String title;

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  String? lyrics;

  @override
  void initState() {
    // for (Lyric lyric in lyricsList) {
    //   if (widget.title == lyric.title) {
    //     setState(() {
    //       lyrics = lyric.lyrics;
    //     });
    //   }
    // }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    for (Lyric lyric in lyricsList) {
      if (widget.title == lyric.title) {
        setState(() {
          lyrics = lyric.lyrics;
        });
      }
    }
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
                Image.network(
                  'https://i.ytimg.com/vi/kXYiU_JCYtU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLC5i_i2I7iyr9Nvb20q1S6kN1uQEQ',
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
                Navigator.pushNamed(
                  context,
                  '/video',
                  // arguments: {'title': 'Numb'},
                  arguments: ScreenArguments(widget.title,
                      homepageContext: context, lyrics: lyrics),
                );
              },
            ),
          ],
        ));
  }
}
