import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late FlickManager flickManager;
  VideoPlayerController? _videoPlayerController;

  // Variable to store the saved position
  double savedPosition = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize the video player
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    // Get the saved position from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedPosition = prefs.getDouble('video_position') ?? 0.0;

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse("https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
    );

    // Initialize the video player controller asynchronously
    await _videoPlayerController!.initialize();

    // Create the FlickManager with the video player controller
    flickManager = FlickManager(
      videoPlayerController: _videoPlayerController!,
    );

    // Add a listener to update the position when the video is playing
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController!.value.isPlaying) {
        // Save the current position periodically while the video is playing
        _savePosition();
      }
    });

    // Seek to the last saved position once the video is initialized
    if (savedPosition > 0.0 && _videoPlayerController!.value.isInitialized) {
      _videoPlayerController!.seekTo(Duration(seconds: savedPosition.toInt()));
    }

    // Trigger a rebuild after initialization is complete
    setState(() {});
  }

  // Method to save the current position
  Future<void> _savePosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double currentPosition = _videoPlayerController!.value.position.inSeconds.toDouble();
    prefs.setDouble('video_position', currentPosition);
  }

  @override
  void dispose() {
    // Ensure we only dispose the controller and manager if the widget is still mounted
    if (mounted) {
      _savePosition();
      flickManager.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure that flickManager and videoPlayerController are initialized
    if (_videoPlayerController == null || !(_videoPlayerController!.value.isInitialized)) {
      return const Center(child: CircularProgressIndicator());
    }

    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: const FlickVideoWithControls(
          closedCaptionTextStyle: TextStyle(fontSize: 8),
          controls: FlickPortraitControls(),
        ),
        flickVideoWithControlsFullscreen: const FlickVideoWithControls(
          controls: FlickLandscapeControls(),
        ),
      ),
    );
  }
}
