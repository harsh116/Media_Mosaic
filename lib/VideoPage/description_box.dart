import 'package:flutter/material.dart';

// import '../models/screen_arguments.dart';
import '../utils/enums.dart';

class DescriptionBox extends StatefulWidget {
  final DescriptionType descriptionType;
  String? descriptionContent;

  final Function() editVideoFromVideoPageButton;
  DescriptionBox(
      {super.key,
      required this.descriptionType,
      this.descriptionContent,
      required this.editVideoFromVideoPageButton});

  @override
  State<DescriptionBox> createState() => _DescriptionBoxState();
}

class _DescriptionBoxState extends State<DescriptionBox> {
  @override
  Widget build(BuildContext context) {
    String descriptionTypeString = "";

    switch (widget.descriptionType) {
      case DescriptionType.Description:
        descriptionTypeString = "Description";
        break;
      case DescriptionType.Lyrics:
        descriptionTypeString = "Lyrics";
        break;

      default:
    }

    return Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(descriptionTypeString,
                    // textAlign: TextAlign.end,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20,
                      // backgroundColor: Colors.grey,
                    )),
                const SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: widget.editVideoFromVideoPageButton,
                ),
              ],
            ),
          ),

          // Scrollable part with a single Text widget
          Expanded(
            child: SingleChildScrollView(
                // child: widget.args.lyrics!=null?Text(
                //   widget.args.lyrics ,
                //   // style: TextStyle(fontSize: 16),
                // ):Container() ,

                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.descriptionContent != null &&
                          widget.descriptionContent!.length > 0
                      ? widget.descriptionContent!
                      // : "Tap + button to add lyrics here",
                      : "No ${descriptionTypeString} added. Tap edit button to add ${descriptionTypeString}",
                  style: TextStyle(fontSize: 16),
                ),
                // lyrics == null
                //     ? IconButton(
                //         icon: Icon(Icons.add),
                //         onPressed: () => {})
                //     : Container(),
              ],
            )),
          ),
        ]);
  }
}
