// import 'package:flutter/material.dart';

// class VideoPlayerPage extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerPage({
//     super.key,
//     required this.videoUrl,
//   });

//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }

// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late VideoPlayerController _videoController;
//   ChewieController? _chewieController;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }

//   Future<void> _initializeVideo() async {
//     try {
//       _videoController = VideoPlayerController.network(widget.videoUrl);

//       await _videoController.initialize();

//       _chewieController = ChewieController(
//         videoPlayerController: _videoController,
//         autoPlay: true,
//         looping: false,
//         allowFullScreen: true,
//         allowPlaybackSpeedChanging: true,
//         materialProgressColors: ChewieProgressColors(
//           playedColor: Colors.yellow,
//           handleColor: Colors.yellow,
//           backgroundColor: Colors.white24,
//           bufferedColor: Colors.grey.shade300,
//         ),
//       );

//       setState(() {
//         _isLoading = false;
//       });
//     } catch (e) {
//       debugPrint("Video yüklenemedi: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             _isLoading
//                 ? const Center(
//                     child: CircularProgressIndicator(color: Colors.yellow),
//                   )
//                 : Center(
//                     child: Chewie(controller: _chewieController!),
//                   ),

//             // Geri butonu
//             Positioned(
//               top: 12,
//               left: 12,
//               child: InkWell(
//                 onTap: () => Navigator.pop(context),
//                 child: Container(
//                   width: 44,
//                   height: 44,
//                   decoration: BoxDecoration(
//                     color: Colors.black45,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.arrow_back, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
