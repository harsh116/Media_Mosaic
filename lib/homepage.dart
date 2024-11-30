import 'package:flutter/material.dart';

import './card.dart' as customCard;
import './models/screen_arguments.dart';
import './constants.dart' as Constants;

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
  int _counter = 0;
  // bool isVideoPageMounted

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
    return Scaffold(
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
              width:
                  MediaQuery.sizeOf(context).width > (Constants.carWidth + 20)
                      ? MediaQuery.sizeOf(context).width
                      : 320,
              height: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              // color: Colors.yellow,
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  customCard.Card(title: 'Numb'),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // if (ModalRoute.of(context)!.settings.name != null) {
            print('currentRoute: ${ModalRoute.of(context)!.settings.name}');
            // setState(() => {});
            // }
          },
          child: Icon(Icons.add),
        ));
  }
}
