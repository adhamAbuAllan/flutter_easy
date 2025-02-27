import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
/*
void main() {
  // List of YouTube URIs
  List<String> urls = [
    "https://www.youtube.com/watch?v=3N65c0-srsU&list=RD3N65c0-srsU&start_radio=1",
    "https://www.youtube.com/watch?v=nPt8bK2gbaU",
    "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    "https://www.youtube.com/watch?v=invalidUrl", // This won't have a valid video ID
  ];

  // Extract video IDs from the list of URIs
  List<String?> videoIds = extractVideoIdsFromUrls(urls);

  // Print the results
  for (int i = 0; i < urls.length; i++) {
    print("URL: ${urls[i]}");
    print("Video ID: ${videoIds[i] ?? 'No video ID found'}");
    print("-----------------------------");
  }
}

/// Extracts video IDs from a list of YouTube URIs
List<String?> extractVideoIdsFromUrls(List<String> urls) {
  return urls.map((url) => extractVideoId(url)).toList();
}

/// Extracts the video ID from a single YouTube URI
String? extractVideoId(String url) {
  // Parse the URL
  Uri uri = Uri.parse(url);

  // Get the query parameters
  Map<String, String> queryParameters = uri.queryParameters;

  // Extract the 'v' parameter (video ID)
  return queryParameters['v'];
}
 */

/// Creates list of video players
class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}
String? extractVideoId(String url) {
  // Parse the URL
  Uri uri = Uri.parse(url);

  // Get the query parameters
  Map<String, String> queryParameters = uri.queryParameters;

  // Extract the 'v' parameter (video ID)
  return queryParameters['v'];
}
class _VideoListState extends State<VideoList> {
final  List<YoutubePlayerController> _controllers = [
    "https://www.youtube.com/watch?v=3N65c0-srsU&list=RD3N65c0-srsU&start_radio=1",
    "https://www.youtube.com/watch?v=nPt8bK2gbaU",
    "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    "https://www.youtube.com/watch?v=invalidUrl", // This won't have a valid video ID
  ]
      .map<YoutubePlayerController>(
        (videoId) {
          extractVideoId(videoId);
          debugPrint("videoId: $videoId");
          return  YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
            ),
          );
        },
  )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List Demo'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return YoutubePlayer(
            key: ObjectKey(_controllers[index]),
            controller: _controllers[index],
            actionsPadding: const EdgeInsets.only(left: 16.0),
            bottomActions: const [
              CurrentPosition(),
              SizedBox(width: 10),
              ProgressBar(isExpanded: true),
              SizedBox(width: 10),
              RemainingDuration(),
              FullScreenButton(),
            ],
          );
        },
        itemCount: _controllers.length,
        separatorBuilder: (context, _) => const SizedBox(height: 10.0),
      ),
    );
  }
}