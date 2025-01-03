import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';

// import 'VideoList/homepage.dart';
import 'constants.dart' as Constants;
import 'utils/utils.dart';
import 'video_list_container.dart';
// import './videopage.dart';

// import './card.dart' as customCard;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? homepageState;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // showSemanticsDebugger: false,
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
          // secondary: Colors.blueGrey.shade50,
          // secondary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: VideoListContainer(),

      // initialRoute: '/${toAlphanumeric(Constants.DEFAULT_PLAYLIST_NAME)}',
      // routes: {
      //   '/${toAlphanumeric(Constants.DEFAULT_PLAYLIST_NAME)}': (context) {
      //     return const MyHomePage(
      //         title: 'Playlist', playlistName: Constants.DEFAULT_PLAYLIST_NAME);
      //     // setState(() =>
      //     // homepageState = const MyHomePage(title: 'Playlist');
      //     // );
      //     // return homepageState!;
      //   },
      //   // '/video': (context) => Videopage(homepageState: homepageState),
      // },
    );
  }
}
