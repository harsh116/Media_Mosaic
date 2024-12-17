// import 'package:flutter/material.dart';
// // import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
// // import 'package:pip_view/pip_view.dart';
// // import 'package:video_player/video_player.dart';

// import './models/screen_arguments.dart';
// import './videoplayer.dart';
// import './homepage.dart';
// import './video_page_full_screen.dart';

// class Videopage extends StatefulWidget {
//   Videopage({super.key, this.homepageState});
//   Widget? homepageState;
//   @override
//   State<Videopage> createState() => _VideoPageState();
// }

// class _VideoPageState extends State<Videopage> {
//   bool isFloating = false;

//   @override
//   Widget build(BuildContext context) {
//     final ScreenArguments args =
//         ModalRoute.of(context)!.settings.arguments as ScreenArguments;
//     // final lyrics = ModalRoute.of(context)!.settings.arguments as ScreenArgumentsl
//     late final lyrics = args.lyrics;
//     // final isFloating = _bottomWidget != null;

//     return VideoPageFullScreen(
//       args: args,
//       isFloating: isFloating,
//     );
//   }
// }
