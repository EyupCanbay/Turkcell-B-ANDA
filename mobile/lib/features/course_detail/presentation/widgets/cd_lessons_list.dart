import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';

class CdLessonsList extends StatelessWidget {
  const CdLessonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Course Lessons",
            style: TextStyle(
              color: CdColors.gncBlue,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          _lessonTile("1. Understanding the Algorithm", "Now Playing",
              nowPlaying: true),
          const SizedBox(height: 8),
          _lessonTile("2. Creating Engaging Content", "Completed",
              completed: true),
          const SizedBox(height: 8),
          _lessonTile("3. Platform-Specific Strategies", "Upcoming",
              locked: true),
          const SizedBox(height: 8),
          _lessonTile("4. Analytics and Optimization", "Upcoming",
              locked: true),
        ],
      ),
    );
  }
}

Widget _lessonTile(String title, String subtitle,
    {bool nowPlaying = false, bool completed = false, bool locked = false}) {
  Color bg = Colors.white;
  Color iconBg = CdColors.gncYellow.withOpacity(0.15);
  Color iconColor = CdColors.gncYellow;
  IconData icon = Icons.play_circle_outline;
  double opacity = 1;

  if (locked) {
    iconBg = const Color(0xFFE5E7EB);
    iconColor = Colors.grey;
    icon = Icons.lock;
    opacity = 0.4;
  } else if (completed) {
    icon = Icons.check_circle;
  }

  return Opacity(
    opacity: opacity,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border:
            nowPlaying ? Border.all(color: CdColors.gncYellow, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: CdColors.gncBlue, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
