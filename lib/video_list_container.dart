import 'package:flutter/material.dart';

import 'VideoList/homepage.dart';
import 'constants.dart' as Constants;

class VideoListContainer extends StatefulWidget {
  @override
  State<VideoListContainer> createState() => _VideoListContainerState();
}

class _VideoListContainerState extends State<VideoListContainer> {
  String playlistName = Constants.DEFAULT_PLAYLIST_NAME;

  void setPlayListName(String newPlaylistName) {
    print('newplaylist name: $newPlaylistName');
    playlistName = newPlaylistName;
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyHomePage(
      // title: 'Playlist', playlistName: Constants.DEFAULT_PLAYLIST_NAME),
      title: playlistName,
      playlistName: playlistName,
      setPlayListName: setPlayListName,
    );
  }
}
