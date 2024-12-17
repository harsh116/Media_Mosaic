import 'package:flutter/material.dart';

import '../models/screen_arguments.dart';
import 'video_page_full_screen.dart';

class PIPVideo extends StatefulWidget {
  final ScreenArguments args;
  final void Function() closeVideo;

  const PIPVideo({super.key, required this.args, required this.closeVideo});

  @override
  State<PIPVideo> createState() => _PIPVideoState();
}

class _PIPVideoState extends State<PIPVideo> {
  // initially no pipmode
  bool isFloating = false;

  // following is just rotating state so it doesnt effect if its either true or false
  bool isVideoPlaying = false;

  void enterFullSreenPage() {
    setState(() {
      isFloating = false;
    });
  }

  // to enter pip mode
  void exitFullScreenPage() {
    setState(() {
      isFloating = true;
    });
  }

  void playOrPauseVideo() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const double pipHeight = 170;

    return Positioned(
      bottom: 0,
      right: 0,
      height: !isFloating ? MediaQuery.of(context).size.height : pipHeight,
      width:
          !isFloating ? MediaQuery.of(context).size.width : pipHeight * 16 / 9,
      child: Stack(
        children: [
          VideoPageFullScreen(
            args: widget.args,
            isFloating: isFloating,
            enablePIPmode: exitFullScreenPage,
            isVideoPlaying: isVideoPlaying,
            closeVideo: widget.closeVideo,
          ),
          isFloating
              ? GestureDetector(
                  onDoubleTap: enterFullSreenPage,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: Colors.grey,
                      shape: BeveledRectangleBorder(),
                    ),
                    child: SizedBox(
                      height: pipHeight,
                      width: pipHeight * 16 / 9,
                    ),
                    onPressed: () =>
                        setState(() => isVideoPlaying = !isVideoPlaying),
                  ),
                )
              : Container(),
          isFloating
              ? Positioned(
                  top: 0,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
                    ),
                    onPressed: widget.closeVideo,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
