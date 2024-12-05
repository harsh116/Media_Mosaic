import 'package:flutter/material.dart';
// import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
// import 'package:pip_view/pip_view.dart';
// import 'package:video_player/video_player.dart';

import './models/screen_arguments.dart';
import './videoplayer.dart';
import './homepage.dart';
import './video_page_full_screen.dart';

class Videopage extends StatefulWidget {
  Videopage({super.key, this.homepageState});
  Widget? homepageState;
  @override
  State<Videopage> createState() => _VideoPageState();
}

class _VideoPageState extends State<Videopage> {
  bool isFloating = false;

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
    //     minSize: const Size(144, 108),
    //     movable: true,
    //     resizable: true,
    //     initialCorner: PIPViewCorner.bottomLeft,
    //   ),
    // );
    final ScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    // final lyrics = ModalRoute.of(context)!.settings.arguments as ScreenArgumentsl
    late final lyrics = args.lyrics;
    // final isFloating = _bottomWidget != null;

    return VideoPageFullScreen(
      args: args,
      isFloating: isFloating,
      homepageState: widget.homepageState,
      homepageContext: args.homepageContext,
    );
  }
}
