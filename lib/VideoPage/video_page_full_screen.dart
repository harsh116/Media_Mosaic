import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:pip_view/pip_view.dart';

import '../models/screen_arguments.dart';
import 'videoplayer.dart';
import '../VideoList/homepage.dart';
import 'description_box.dart';
import '../VideoList/Overlays/yes_no_overlay.dart';

import '../utils/enums.dart';

class VideoPageFullScreen extends StatefulWidget {
  final ScreenArguments args;
  final bool isFloating;
  final bool isVideoPlaying;
  final void Function() enablePIPmode;
  final void Function() closeVideo;
  final Function(Uint8List) savingScreenShot;

  // Widget? homepageState;
  // final BuildContext homepageContext;
  VideoPageFullScreen({
    super.key,
    required this.args,
    required this.isFloating,
    required this.enablePIPmode,
    required this.isVideoPlaying,
    required this.closeVideo,
    required this.savingScreenShot,
    // this.homepageState,
    // required this.homepageContext
  });
  @override
  State<VideoPageFullScreen> createState() => _VideoPageFullScreenState();
}

class _VideoPageFullScreenState extends State<VideoPageFullScreen> {
  String? lyrics;
  String? description;
  // String ch="1";
  DescriptionType descriptionType = DescriptionType.Lyrics;

  bool isScreenshotTaken = false;
  bool isYesNoOverlay = false;

  // bool isOverlayYesNoMessageConfirmed = false;

  // VoidCallback? takeScreenShot;
  // void setTakeScreenShot(Function() callback) {
  //   takeScreenShot = callback;
  //   setState(() => {});
  // }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, DescriptionType>> descriptionTypes = [
    //   {'Lyrics': DescriptionType.Lyrics},
    //   {'Description': DescriptionType.Description},
    // ];

    List<String> descriptionTypes = ['Lyrics', 'Description'];

    // print('isvideoplaying fullscreen dart: ${widget.isVideoPlaying}');
    bool isFloating = widget.isFloating;
    // bool isFloating = false;

    lyrics = widget.args.lyrics;
    description = widget.args.description;
    return Scaffold(
        appBar: isFloating
            ? null
            : AppBar(
                title: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: widget.closeVideo,
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      // width: 20,

                      // decoration: BoxDecoration()
                      child: Text(widget.args.title,
                          overflow: TextOverflow.clip, style: TextStyle()),
                    ),
                  ],
                ),
              ),
        body: Stack(
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Videoplayer(
                          url:
                              // 'https://user-images.githubusercontent.com/28951144/229373720-14d69157-1a56-4a78-a2f4-d7a134d7c3e9.mp4',
                              widget.args.vidPath,
                          isVideoPlaying: widget.isVideoPlaying,
                          videoData: widget.args,
                          isScreenshotTaken: isScreenshotTaken,
                          savingScreenShot: widget.savingScreenShot,
                          // setTakeScreenshot: setTakeScreenShot,
                        ),
                        !isFloating
                            ? Positioned(
                                top: -10,
                                right: -10,
                                child: IconButton(
                                  icon: Icon(Icons.screenshot),
                                  onPressed: () {
                                    print(
                                        'screenshot button pressed'); // this path is reached

                                    isYesNoOverlay = true;
                                    setState(() => {});

                                    // setState(
                                    //   () => isScreenshotTaken =
                                    //       !isScreenshotTaken,
                                    // );

                                    // if (takeScreenShot != null) {
                                    //   takeScreenShot!();
                                    // }
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                // widget.args.lyrics != null &&
                !isFloating
                    ? Expanded(
                        flex: 1,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 1000),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.1),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,

                                // height: 200,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 32),
                                child: Builder(builder: (context) {
                                  if (descriptionType == DescriptionType.Lyrics)
                                    return DescriptionBox(
                                        descriptionType: descriptionType,
                                        descriptionContent: lyrics);
                                  else if (descriptionType ==
                                      DescriptionType.Description)
                                    return DescriptionBox(
                                        descriptionType: descriptionType,
                                        descriptionContent: description);
                                  else
                                    return Container();
                                }),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.5)),
                                  child: Row(
                                    children: descriptionTypes
                                        .map((e) => Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                              ),
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    shape: LinearBorder(),
                                                  ),
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .inversePrimary),
                                                  ),
                                                  onPressed: () {
                                                    if (e == 'Lyrics')
                                                      setState(() =>
                                                          descriptionType =
                                                              DescriptionType
                                                                  .Lyrics);
                                                    if (e == 'Description') {
                                                      setState(() =>
                                                          descriptionType =
                                                              DescriptionType
                                                                  .Description);
                                                    }
                                                  }),
                                            ))
                                        .toList(),
                                    // children: [

                                    //   TextButton(
                                    //       child: Text('Lyrics'), onPressed: () => {}),
                                    //   TextButton(
                                    //       child: Text('Description'),
                                    //       onPressed: () => {}),
                                    // ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            !isFloating && isYesNoOverlay
                ? YesNoOverlay(
                    confirmAction: (bool isConfirm) {
                      if (isConfirm) {
                        // isOverlayYesNoMessageConfirmed = true;

                        isScreenshotTaken = !isScreenshotTaken;
                      }
                      isYesNoOverlay = false;
                      setState(() => {});
                    },
                    message:
                        "Are your sure you wanna update thumnail with current frame",
                  )
                : Container(),
          ],
        ),
        floatingActionButton:
            // isFloating
            //     ? FloatingActionButton(
            //         onPressed: () => {print('pressed close')},
            //         child: Icon(Icons.close),
            //       )
            //     :
            isFloating
                ? null
                : Tooltip(
                    message: 'Picture in Picture',
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.1),

                      // backgroundBlendMode: BlendMode.colorDodge,
                    ),
                    // richMessage: InlineSpan(style: TextStyle(color: Colors.white)),
                    textStyle: TextStyle(color: Colors.white),
                    child: FloatingActionButton(
                        // tooltip: 'Picture in Picture',
                        backgroundColor:
                            const Color.fromRGBO(255, 255, 255, 0.1),
                        foregroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        onPressed: () {
                          // setState(() => isPIPMode = true);
                          // PIPViewCustom.of(context)!.presentBelow(
                          //     const MyHomePage(title: 'playlist'));
                          // PIPViewCustom.of(context)!.presentBelow(
                          //     widget.homepageState!, widget.homepageContext);
                          // PIPViewCustom.of(context)!
                          //     .presentBelow(null);
                          widget.enablePIPmode();
                        },
                        child: const Icon(Icons.picture_in_picture)),
                  ));
  }
}
