import 'package:flutter/material.dart';

import './card.dart' as customCard;
import './video_page_full_screen.dart';
import './models/screen_arguments.dart';
import './constants.dart' as Constants;

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVideoPageOpen = false;
  ScreenArguments args = ScreenArguments("");

  // bool isVideoPageMounted

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  void openVideo(String title, {String? lyrics}) {
    setState(() {
      isVideoPageOpen = true;
      args = ScreenArguments(title, lyrics: lyrics);
    });
  }

  void closeVideo() {
    setState(() {
      isVideoPageOpen = false;
      args = ScreenArguments("");
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (ModalRoute.of(context)!.settings.name != null) {
    //   print('currentRoute: ${ModalRoute.of(context)!.settings.name}');
    //   // setState(() => {});
    // }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.primary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            centerTitle: true,
            bottomOpacity: 0.2,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              child: Container(
                  width: MediaQuery.sizeOf(context).width >
                          (Constants.carWidth + 20)
                      ? MediaQuery.sizeOf(context).width
                      : 320,
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  // color: Colors.yellow,
                  // child: Flex(
                  //   direction: Axis.horizontal,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                  //     for (int i = 0; i < 10; i++) customCard.Card(title: 'Numb'),
                  //   ],
                  // ),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                          spacing: 40,
                          runSpacing: 20,
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            for (int i = 0; i < 10; i++)
                              customCard.Card(
                                  title: 'Numb ${i + 1}',
                                  onClickVideo: openVideo),
                          ]),
                    ),
                  )),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // if (ModalRoute.of(context)!.settings.name != null) {
          //     // print('currentRoute: ${ModalRoute.of(context)!.settings.name}');
          //     // setState(() => {});
          //     // }
          //   },
          //   child: Icon(Icons.add),
          // ),
        ),
        isVideoPageOpen
            ? PIPVideo(args: args, closeVideo: closeVideo)
            : Container(),
      ],
    );
  }
}
