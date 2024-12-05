import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class Videoplayer extends StatefulWidget {
  final String url;
  final bool isVideoPlaying;

  Videoplayer({required this.url, required this.isVideoPlaying});

  @override
  State<Videoplayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<Videoplayer> {
  final kAspectRatio = 9 / 16;
  // bool stateToggle = widget.stateToggle;

  final Player _player = Player();
  late final VideoController _controller = VideoController(_player);

  @override
  void initState() {
    super.initState();
    _player.open(
      Media(widget.url),
      play: false,
    );
  }

  @override
  void didUpdateWidget(Videoplayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isVideoPlaying != widget.isVideoPlaying) {
      _player.playOrPause();
    }
  }

  // void togglePlayorPause() {
  //   if (!widget.isVideoPlaying) {
  //     _player.pause();
  //   } else {
  //     _player.play();
  //   }
  // }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double w = constraints.maxWidth - 32.0;
          double h = w * kAspectRatio;

          // if height is losing then also decrease width of container
          if (h > constraints.maxHeight - 16.0) {
            h = constraints.maxHeight - 16;
            w = h / kAspectRatio;
          }

          return Stack(
            children: [
              Video(
                pauseUponEnteringBackgroundMode: false,
                width: w,
                height: h,
                fill: Colors.grey,
                controller: _controller,
              ),
              // Positioned(
              //   child: IconButton(icon: Icon(Icons.close), onPressed: () => {}),
              //   top: 10,
              //   right: 10,
              // ),
            ],
          );
        },
      ),
    );
  }
}
