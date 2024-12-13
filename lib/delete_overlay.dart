import 'package:flutter/material.dart';

// import 'models/screen_arguments.dart';

class DeleteOverlay extends StatefulWidget {
  // final ScreenArguments videoData;
  final Function(bool isDelete) deleteVideo;

  const DeleteOverlay({super.key, required this.deleteVideo});

  @override
  State<DeleteOverlay> createState() => _DeleteOverlayState();
}

class _DeleteOverlayState extends State<DeleteOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(255, 255, 255, 0.2),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SizedBox(
              height: 200,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Are your sure you wanna delete this video',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            shape: LinearBorder(),
                            backgroundColor:
                                Color.fromRGBO(255, 255, 255, 0.4)),
                        child: Text(
                          'Ok',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        onPressed: () => widget.deleteVideo(true),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                            shape: LinearBorder(),
                            backgroundColor:
                                Color.fromRGBO(255, 255, 255, 0.4)),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        onPressed: () => widget.deleteVideo(false),
                      ),
                    ])
                  ],
                ),
              )),
        )));
  }
}
