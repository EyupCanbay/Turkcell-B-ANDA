import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';
import '../pages/video_player_page.dart';

class CdVideoPlayer extends StatelessWidget {
  final String videoUrl;

  const CdVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoPlayerPage(videoUrl: videoUrl),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://i.ytimg.com/vi/ysz5S6PUM-U/maxresdefault.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 200,
                color: Colors.black.withOpacity(0.25),
              ),
              const Center(
                child:
                    Icon(Icons.play_circle_fill, size: 70, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
