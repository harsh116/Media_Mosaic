import 'package:flutter/material.dart';
// import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
import 'package:pip_view/pip_view.dart';
// import 'package:video_player/video_player.dart';

import './models/screen_arguments.dart';
import './videoplayer.dart';
import './homepage.dart';

class Videopage extends StatefulWidget {
  const Videopage({super.key});
  @override
  State<Videopage> createState() => _VideoPageState();
}

class _VideoPageState extends State<Videopage> {
  // bool isPIPMode = false;

  @override
  Widget build(BuildContext context) {
    // PictureInPicture.startPiP(
    //   pipWidget: Videoplayer(
    //       url:
    //           'https://user-images.githubusercontent.com/28951144/229373720-14d69157-1a56-4a78-a2f4-d7a134d7c3e9.mp4'),
    // );
    // PictureInPicture.updatePiPParams(
    //   pipParams: PiPParams(
    //     // pipWindowHeight: 144,
    //     // pipWindowWidth: 256,
    //     bottomSpace: 64,
    //     leftSpace: 64,
    //     rightSpace: 64,
    //     topSpace: 64,
    //     // maxSize: Size(256, 144),
    //     minSize: Size(144, 108),
    //     movable: true,
    //     resizable: true,
    //     initialCorner: PIPViewCorner.bottomLeft,
    //   ),
    // );
    final ScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    // final lyrics = ModalRoute.of(context)!.settings.arguments as ScreenArgumentsl
    late final lyrics = args.lyrics;

    return PIPView(
      floatingHeight: 200,
      floatingWidth: 300,
      initialCorner: PIPViewCorner.bottomRight,
      builder: (context, isFloating) => Scaffold(
          appBar: AppBar(
            title: Text(args.title),
          ),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Videoplayer(
                      url:
                          'https://user-images.githubusercontent.com/28951144/229373720-14d69157-1a56-4a78-a2f4-d7a134d7c3e9.mp4'),
                ),
              ),
              lyrics != null && !isFloating
                  ? Expanded(
                      flex: 1,
                      child: Container(

                          // height: 200,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 32),
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
                                    child: Text(
                                      lyrics,
                                      // style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ])),
                    )
                  : Container(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.picture_in_picture),
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.1),
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                // setState(() => isPIPMode = true);
                PIPView.of(context)!
                    .presentBelow(const MyHomePage(title: 'playlist'));
              })),
    );
  }
}
