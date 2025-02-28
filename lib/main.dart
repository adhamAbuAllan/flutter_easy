import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//
// import 'video_list.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   runApp(const YoutubePlayerDemoApp());
// }
//
// /// Creates [YoutubePlayerDemoApp] widget.
// class YoutubePlayerDemoApp extends StatelessWidget {
//   const YoutubePlayerDemoApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Youtube Player Flutter',
//       theme: ThemeData(
//         colorSchemeSeed: Colors.blue,
//         appBarTheme: const AppBarTheme(
//           color: Colors.blueAccent,
//           titleTextStyle: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w300,
//             fontSize: 20,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.blueAccent),
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// /// Homepage
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late YoutubePlayerController _controller;
//   late TextEditingController _idController;
//   late TextEditingController _seekToController;
//
//   late PlayerState _playerState;
//   late YoutubeMetaData _videoMetaData;
//   double _volume = 100;
//   bool _muted = false;
//   bool _isPlayerReady = false;
//
//   final List<String> _ids = [
//     'nPt8bK2gbaU',
//     'gQDByCdjUXw',
//     'iLnmTe5Q2Qw',
//     '_WoCV4c6XOE',
//     'KmzdUe0RSJo',
//     '6jZDSSZZxjQ',
//     'p2lYr3vM_1w',
//     '7QUtEmBT_-w',
//     '34_PXCzGw1M',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: _ids.first,
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: true,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//       ),
//     )..addListener(listener);
//     _idController = TextEditingController();
//     _seekToController = TextEditingController();
//     _videoMetaData = const YoutubeMetaData();
//     _playerState = PlayerState.unknown;
//   }
//
//   void listener() {
//     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//       setState(() {
//         _playerState = _controller.value.playerState;
//         _videoMetaData = _controller.metadata;
//       });
//     }
//   }
//
//   @override
//   void deactivate() {
//     // Pauses video while navigating to next page.
//     _controller.pause();
//     super.deactivate();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _idController.dispose();
//     _seekToController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
//       onExitFullScreen: () {
//         // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
//         // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//       },
//       player: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.blueAccent,
//         topActions: <Widget>[
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: Text(
//               _controller.metadata.title,
//               style: const TextStyle(color: Colors.white, fontSize: 18.0),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.white, size: 25.0),
//             onPressed: () {
//               log('Settings Tapped!');
//             },
//           ),
//         ],
//         onReady: () {
//           _isPlayerReady = true;
//         },
//         onEnded: (data) {
//           _controller.load(
//             _ids[(_ids.indexOf(data.videoId) + 1) % _ids.length],
//           );
//           _showSnackBar('Next Video Started!');
//         },
//       ),
//       builder:
//           (context, player) => Scaffold(
//             backgroundColor: Colors.black26,
//             appBar: AppBar(
//               // leading: Padding(
//               //   padding: const EdgeInsets.only(left: 12.0),
//               //   child: Image.asset('assets/ypf.png', fit: BoxFit.fitWidth),
//               // ),
//               title: const Text(
//                 'Youtube Player Flutter',
//                 style: TextStyle(color: Colors.white),
//               ),
//               actions: [
//                 IconButton(
//                   icon: const Icon(Icons.video_library),
//                   onPressed:
//                       () => Navigator.push(
//                         context,
//                         CupertinoPageRoute(
//                           builder: (context) => const VideoList(),
//                         ),
//                       ),
//                 ),
//               ],
//             ),
//             body: ListView(
//               children: [
//                 player,
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       _space,
//                       _text('Title', _videoMetaData.title),
//                       _space,
//                       _text('Channel', _videoMetaData.author),
//                       _space,
//                       _text('Video Id', _videoMetaData.videoId),
//                       _space,
//                       Row(
//                         children: [
//                           _text(
//                             'Playback Quality',
//                             _controller.value.playbackQuality ?? '',
//                           ),
//                           const Spacer(),
//                           _text(
//                             'Playback Rate',
//                             '${_controller.value.playbackRate}x  ',
//                           ),
//                         ],
//                       ),
//                       _space,
//                       TextField(
//                         enabled: _isPlayerReady,
//                         controller: _idController,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Enter youtube <video id> or <link>',
//                           fillColor: Colors.blueAccent.withAlpha(20),
//                           filled: true,
//                           hintStyle: const TextStyle(
//                             fontWeight: FontWeight.w300,
//                             color: Colors.blueAccent,
//                           ),
//                           suffixIcon: IconButton(
//                             icon: const Icon(Icons.clear),
//                             onPressed: () => _idController.clear(),
//                           ),
//                         ),
//                       ),
//                       _space,
//                       Row(
//                         children: [
//                           _loadCueButton('LOAD'),
//                           const SizedBox(width: 10.0),
//                           _loadCueButton('CUE'),
//                         ],
//                       ),
//                       _space,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.skip_previous),
//                             onPressed:
//                                 _isPlayerReady
//                                     ? () => _controller.load(
//                                       _ids[(_ids.indexOf(
//                                                 _controller.metadata.videoId,
//                                               ) -
//                                               1) %
//                                           _ids.length],
//                                     )
//                                     : null,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               _controller.value.isPlaying
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                             ),
//                             onPressed:
//                                 _isPlayerReady
//                                     ? () {
//                                       _controller.value.isPlaying
//                                           ? _controller.pause()
//                                           : _controller.play();
//                                       setState(() {});
//                                     }
//                                     : null,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               _muted ? Icons.volume_off : Icons.volume_up,
//                             ),
//                             onPressed:
//                                 _isPlayerReady
//                                     ? () {
//                                       _muted
//                                           ? _controller.unMute()
//                                           : _controller.mute();
//                                       setState(() {
//                                         _muted = !_muted;
//                                       });
//                                     }
//                                     : null,
//                           ),
//                           FullScreenButton(
//                             controller: _controller,
//                             color: Colors.blueAccent,
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.skip_next),
//                             onPressed:
//                                 _isPlayerReady
//                                     ? () => _controller.load(
//                                       _ids[(_ids.indexOf(
//                                                 _controller.metadata.videoId,
//                                               ) +
//                                               1) %
//                                           _ids.length],
//                                     )
//                                     : null,
//                           ),
//                         ],
//                       ),
//                       _space,
//                       Row(
//                         children: <Widget>[
//                           const Text(
//                             "Volume",
//                             style: TextStyle(fontWeight: FontWeight.w300),
//                           ),
//                           Expanded(
//                             child: Slider(
//                               inactiveColor: Colors.transparent,
//                               value: _volume,
//                               min: 0.0,
//                               max: 100.0,
//                               divisions: 10,
//                               label: '${(_volume).round()}',
//                               onChanged:
//                                   _isPlayerReady
//                                       ? (value) {
//                                         setState(() {
//                                           _volume = value;
//                                         });
//                                         _controller.setVolume(_volume.round());
//                                       }
//                                       : null,
//                             ),
//                           ),
//                         ],
//                       ),
//                       _space,
//                       AnimatedContainer(
//                         duration: const Duration(milliseconds: 800),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: _getStateColor(_playerState),
//                         ),
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           _playerState.toString(),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w300,
//                             color: Colors.white,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//     );
//   }
//
//   Widget _text(String title, String value) {
//     return RichText(
//       text: TextSpan(
//         text: '$title : ',
//         style: const TextStyle(
//           color: Colors.blueAccent,
//           fontWeight: FontWeight.bold,
//         ),
//         children: [
//           TextSpan(
//             text: value,
//             style: const TextStyle(
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Color _getStateColor(PlayerState state) {
//     switch (state) {
//       case PlayerState.unknown:
//         return Colors.grey[700]!;
//       case PlayerState.unStarted:
//         return Colors.pink;
//       case PlayerState.ended:
//         return Colors.red;
//       case PlayerState.playing:
//         return Colors.blueAccent;
//       case PlayerState.paused:
//         return Colors.orange;
//       case PlayerState.buffering:
//         return Colors.yellow;
//       case PlayerState.cued:
//         return Colors.blue[900]!;
//       default:
//         return Colors.blue;
//     }
//   }
//
//   Widget get _space => const SizedBox(height: 10);
//
//   Widget _loadCueButton(String action) {
//     return Expanded(
//       child: MaterialButton(
//         color: Colors.blueAccent,
//         onPressed:
//             _isPlayerReady
//                 ? () {
//                   if (_idController.text.isNotEmpty) {
//                     var id =
//                         YoutubePlayer.convertUrlToId(_idController.text) ?? '';
//                     if (action == 'LOAD') _controller.load(id);
//                     if (action == 'CUE') _controller.cue(id);
//                     FocusScope.of(context).requestFocus(FocusNode());
//                   } else {
//                     _showSnackBar('Source can\'t be empty!');
//                   }
//                 }
//                 : null,
//         disabledColor: Colors.grey,
//         disabledTextColor: Colors.black,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 14.0),
//           child: Text(
//             action,
//             style: const TextStyle(
//               fontSize: 18.0,
//               color: Colors.white,
//               fontWeight: FontWeight.w300,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),
//         ),
//         backgroundColor: Colors.blueAccent,
//         behavior: SnackBarBehavior.floating,
//         elevation: 1.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'video_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Player Flutter',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      home: VideoListScreen(),
    );
  }
}

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final List<YoutubePlayerController> _controllers = [];
  final List<String> _videoUrls = [];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  // Load saved video URLs from shared preferences
  void _loadVideos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> videoUrls = prefs.getStringList('videoUrls') ?? [];

    for (var url in videoUrls) {
      _addVideo(url, saveToStorage: false);
    }
  }

  // Add video to the list and save the URL to shared preferences
  void _addVideo(String url, {bool saveToStorage = true}) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      setState(() {
        _controllers.add(
          YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false),
          ),
        );
        if (saveToStorage) {
          _saveVideoUrl(url);
        }
      });
    } else {
      // Handle invalid URL
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid YouTube URL')));
    }
  }

  // Save the video URL to shared preferences
  void _saveVideoUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> videoUrls = prefs.getStringList('videoUrls') ?? [];
    videoUrls.add(url);
    await prefs.setStringList('videoUrls', videoUrls);
  }

  // Remove the video from the list and shared preferences
  void _removeVideo(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> videoUrls = prefs.getStringList('videoUrls') ?? [];
    videoUrls.removeAt(index); // Remove the URL from shared preferences
    await prefs.setStringList('videoUrls', videoUrls);

    setState(() {
      _controllers.removeAt(index); // Remove the controller from the list
    });
  }

  void _showAddVideoDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        String url = '';
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter YouTube URL',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  url = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _addVideo(url);
                },
                child: Text('Add Video'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultSelectionStyle.defaultColor,
      appBar: AppBar(title: Text('Video List')),
      body: ListView.separated(
        itemCount: _controllers.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Stack(
              children: [
                YoutubePlayer(
                  controller: _controllers[index],
                  showVideoProgressIndicator: true,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('Video Tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => VideoPlayerScreen(
                              videoId: _controllers[index].initialVideoId,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeVideo(index);
              },
            ),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddVideoDialog,
        label: Text('Add Video'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late YoutubeMetaData _videoMetaData;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
  }

  void listener() {
    setState(() {
      _videoMetaData = _controller.metadata;
    });
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('YouTube Player')),
      body: Column(
        spacing: 17,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              _controller.addListener(() {});
            },
          ),
          _text("title", _videoMetaData.title),
          // _text("description", _videoMetaData.author),
        ],
      ),
    );
  }

  Widget _text(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        value,
        textDirection: TextDirection.rtl,
        style: const TextStyle(
          // fontWeight: FontWeight.w300,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
