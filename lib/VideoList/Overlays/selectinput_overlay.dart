import 'package:flutter/material.dart';

import '../../utils/utils.dart';

// import 'models/screen_arguments.dart';

class SelectinputOverlay extends StatefulWidget {
  // final ScreenArguments videoData;
  final Function(String input, bool isAction) confirmAction;

  final String message;
  final List<String> inputLists;
  final String initialPlayListName;

  const SelectinputOverlay(
      {super.key,
      required this.confirmAction,
      required this.message,
      required this.inputLists,
      required this.initialPlayListName});

  @override
  State<SelectinputOverlay> createState() => _SelectinputOverlayState();
}

class _SelectinputOverlayState extends State<SelectinputOverlay> {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print('initial playlistname: ' + widget.initialPlayListName);
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
              height: 250,
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
                            // child: TextFormField(
                            //   controller: inputController,
                            //   autofocus: true,
                            // ),

                            // this dropdownMenu have entries property which is list of DropdownMenuEntry
                            //  so List<String> is mapped to List<DropdownMenuEntry>
                            child: DropdownMenu<String>(
                              initialSelection: widget.initialPlayListName,
                              // errorText: inputController.text "No such playlist name",
                              requestFocusOnTap: true,
                              menuHeight: 200,
                              controller: inputController,
                              dropdownMenuEntries: widget.inputLists
                                  .map((inputList) => DropdownMenuEntry(
                                      value: inputList, label: inputList))
                                  .toList(),
                            ),
                          ),
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                  child: Text(
                                    'Playlist name cannot contain letter like "/" or ""."',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ));
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
