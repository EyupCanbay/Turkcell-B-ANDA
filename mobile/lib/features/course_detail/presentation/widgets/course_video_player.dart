import 'package:flutter/material.dart';

class CourseVideoPlayer extends StatelessWidget {
  final String videoUrl;

  const CourseVideoPlayer({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xff002B5C),
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
          image: NetworkImage(
              "https://via.placeholder.com/600x300.png?text=Course+Video"), // geçici thumbnail
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.25),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}
