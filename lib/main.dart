import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';

import './homepage.dart';
import './videopage.dart';

// import './card.dart' as customCard;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PiPMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: ColorScheme.dark(
          inversePrimary: Colors.blueGrey[50],
          primary: Colors.blueGrey.shade800,
          primaryContainer: Colors.grey.shade700,
        ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Playlist'),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Playlist'),
        '/video': (context) => const Videopage(),
      },
    );
  }
}
