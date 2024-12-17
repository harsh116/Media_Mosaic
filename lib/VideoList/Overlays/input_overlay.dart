import 'package:flutter/material.dart';

import '../../utils/utils.dart';

// import 'models/screen_arguments.dart';

class InputOverlay extends StatefulWidget {
  // final ScreenArguments videoData;
  final Function(String input, bool isAction) confirmAction;

  final String message;

  const InputOverlay(
      {super.key, required this.confirmAction, required this.message});

  @override
  State<InputOverlay> createState() => _InputOverlayState();
}

class _InputOverlayState extends State<InputOverlay> {
  final inputController = TextEditingController();

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
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              widget.message,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: TextFormField(
                                controller: inputController,
                                autofocus: true,
                              )),
                        ],
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
                          onPressed: () {
                            if (!validateFileName(inputController.text)) {
                              print('invalid title name');
                              return;
                            }
                            widget.confirmAction(inputController.text, true);
                          }),
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
                        onPressed: () => widget.confirmAction('', false),
                      ),
                    ])
                  ],
                ),
              )),
        )));
  }
}
