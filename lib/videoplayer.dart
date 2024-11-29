import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class Videoplayer extends StatefulWidget {
  final String url;

  Videoplayer({required this.url});

  @override
  State<Videoplayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<Videoplayer> {
  final kAspectRatio = 9 / 16;

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
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1000.0, maxHeight: 1000.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double w = constraints.maxWidth - 32.0;
          double h = w * kAspectRatio;

          // if height is losing then also decrease width of container
          if (h > constraints.maxHeight - 16.0) {
            h = constraints.maxHeight - 16;
            w = h / kAspectRatio;
          }

          return Video(
            pauseUponEnteringBackgroundMode: false,
            width: w,
            height: h,
            fill: Colors.grey,
            controller: _controller,
          );
        },
      ),
    );
  }
}
