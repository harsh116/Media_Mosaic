// contains some stateless components used by EditOverlay widget

import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String title;

  LabelText(this.title);


  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.none,
          fontSize: 20,
          fontFamily: 'Roberto',
        ));
  }
}

class StyledTextFormField extends StatelessWidget {
  bool isMultiLine;
  final String hintValue;
  final TextEditingController controller;

  final String initialValue;

  StyledTextFormField(
      {this.isMultiLine = false,
      required this.hintValue,
      required this.controller,
      required this.initialValue});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      // initialValue: initialValue,
      controller: controller,
      keyboardType: isMultiLine ? TextInputType.multiline : null,
      maxLines: isMultiLine ? 6 : 1,

      // cursorColor: Colors.blue,
      style: TextStyle(
        color: Colors.black,
      ),

      // strutStyle: StrutStyle(),

      decoration: InputDecoration(
        // fillColor: Colors.black,
        // focusColor: Colors.black,
        // iconColor: Colors.black,

        constraints: BoxConstraints(maxWidth: 200),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),

        hintText: hintValue,

        hintStyle: TextStyle(color: Colors.grey),
        // labelText: 'title',
        // prefixStyle: TextStyle(color: Colors.black),
        // counterText: '3',
      ),
    );
  }
}

class FileChooserButton extends StatelessWidget {
  final String label;
  final Function() onFileChoose;

  final String filename;

  // FileType fileType;

  FileChooserButton(
      {super.key,
      required this.label,
      required this.onFileChoose,
      required this.filename});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      clipBehavior: Clip.none,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            // shape: BeveledRectangleBorder(
            //     borderRadius: BorderRadius.all(
            //         Radius.circular(3))),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          child: Text(label, style: TextStyle(color: Colors.white)),
          onPressed: onFileChoose,
        ),
        Positioned(
          bottom: -20,
          left: 10,
          child: Text(
            filename,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

// each row of the overlay containing label and its corresponding input field
class FormRow extends StatelessWidget {
  final double labelWidth;
  final Widget label;
  final Widget inputField;

  const FormRow(
      {super.key,
      required this.labelWidth,
      required this.label,
      required this.inputField});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      )),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: labelWidth, child: label),
          // SizedBox(width: 100),
          inputField,
        ],
      ),
    );
  }
}
