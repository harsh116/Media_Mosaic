import 'package:flutter/material.dart';
// import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
import 'package:pip_view/pip_view.dart';
// import 'package:video_player/video_player.dart';

import './models/screen_arguments.dart';
import './videoplayer.dart';
import './homepage.dart';
import './video_page_full_screen.dart';
import './pipview_custom.dart';
import 'rawpipview_custom.dart' as Custom;

class Videopage extends StatefulWidget {
  Videopage({super.key, this.homepageState});
  Widget? homepageState;
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
    // final isFloating = _bottomWidget != null;

    return Stack(
      children: [
        PIPViewCustom(
            floatingHeight: 200,
            floatingWidth: 300,
            // floatingHeight: 400,
            // floatingWidth: 600,
            initialCorner: Custom.PIPViewCorner.bottomRight,
            // topWidget: IgnorePointer(
            //      ignoring: isFloating,
            //      child: Builder(
            //        builder: (context) => widget.builder(context, isFloating),
            //      ),
            //    ),
            builder: (context, isFloating) => VideoPageFullScreen(
                  args: args,
                  isFloating: isFloating,
                  homepageState: widget.homepageState,
                  homepageContext: args.homepageContext,
                )),
        // Positioned(
        //   child: IconButton(icon: Icon(Icons.close), onPressed: () => {}),
        //   top: 0,
        // ),
      ],
    );
  }
}
