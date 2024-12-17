import 'package:flutter/material.dart';

import 'models/screen_arguments.dart';

class InfoOverlay extends StatefulWidget {
  final ScreenArguments videoData;
  final Function() closeInfoOverlay;

  InfoOverlay(
      {super.key, required this.videoData, required this.closeInfoOverlay});

  @override
  State<InfoOverlay> createState() => _InfoOverlayState();
}

class _InfoOverlayState extends State<InfoOverlay> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(255, 255, 255, 0.2),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 800,
            minHeight: 300,
            minWidth: 300,
          ),
          child: Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.rectangle,
                // border: Border.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      // offset: 3,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Material(
                color: Colors.black,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            // width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                widget.videoData.title,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '-Description-',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.videoData.description != null &&
                                          widget.videoData.description!.length >
                                              0
                                      ? widget.videoData.description!
                                      : 'No description',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '-Lyrics-',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.videoData.lyrics != null &&
                                          widget.videoData.lyrics!.length > 0
                                      ? widget.videoData.lyrics!
                                      : 'No lyrics',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: widget.closeInfoOverlay),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
