import 'package:flutter/material.dart';
// import 'package:pip_view/pip_view.dart';

import './models/screen_arguments.dart';
import './videoplayer.dart';
import './homepage.dart';

class VideoPageFullScreen extends StatefulWidget {
  final ScreenArguments args;
  final bool isFloating;
  final bool isVideoPlaying;
  final void Function() enablePIPmode;
  final void Function() closeVideo;
  // Widget? homepageState;
  // final BuildContext homepageContext;
  VideoPageFullScreen({
    super.key,
    required this.args,
    required this.isFloating,
    required this.enablePIPmode,
    required this.isVideoPlaying,
    required this.closeVideo,
    // this.homepageState,
    // required this.homepageContext
  });
  @override
  State<VideoPageFullScreen> createState() => _VideoPageFullScreenState();
}

class _VideoPageFullScreenState extends State<VideoPageFullScreen> {
  var lyrics;
  @override
  Widget build(BuildContext context) {
    // print('isvideoplaying fullscreen dart: ${widget.isVideoPlaying}');
    bool isFloating = widget.isFloating;
    // bool isFloating = false;

    lyrics = widget.args.lyrics;
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
                    Text(widget.args.title),
                  ],
                ),
              ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Videoplayer(
                  url:
                      'https://user-images.githubusercontent.com/28951144/229373720-14d69157-1a56-4a78-a2f4-d7a134d7c3e9.mp4',
                  isVideoPlaying: widget.isVideoPlaying,
                ),
              ),
            ),
            widget.args.lyrics != null && !isFloating
                ? Expanded(
                    flex: 1,
                    child: Container(

                        // height: 200,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Text('Lyrics',
                                    // textAlign: TextAlign.end,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontSize: 20,
                                      // backgroundColor: Colors.grey,
                                    )),
                              ),
                              // Scrollable part with a single Text widget
                              Expanded(
                                child: SingleChildScrollView(
                                    // child: widget.args.lyrics!=null?Text(
                                    //   widget.args.lyrics ,
                                    //   // style: TextStyle(fontSize: 16),
                                    // ):Container() ,

                                    child: Text(
                                  lyrics,
                                  style: TextStyle(fontSize: 16),
                                )),
                              ),
                            ])),
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
