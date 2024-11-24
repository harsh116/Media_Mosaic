import 'package:flutter/material.dart';

class Card extends StatefulWidget {
  const Card({super.key});

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    double carWidth = 300.0;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        clipBehavior: Clip.hardEdge,
        // constraints: BoxConstraints()

        // position: DecorationPosition.foreground,
        child: FittedBox(
          child: Column(children: [
            Image.network(
              'https://i.ytimg.com/vi/kXYiU_JCYtU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLC5i_i2I7iyr9Nvb20q1S6kN1uQEQ',
              width: carWidth,
            ),
            Container(
              width: carWidth,

              // width: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                // color: Colors.pink,
              ),
              child: Text('The Numb',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ),
          ]),
        ));
  }
}
