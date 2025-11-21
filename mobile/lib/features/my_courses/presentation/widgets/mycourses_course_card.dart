import 'package:flutter/material.dart';
import '../styles/mycourses_colors.dart';

class MyCoursesCourseList extends StatelessWidget {
  const MyCoursesCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          MyCourseCard(
            title: "Python'a Giriş",
            subtitle: "Yazılım • 12 Ders",
            progressPercent: 0.30,
            progressText: "%30",
            imageUrl: "https://picsum.photos/201",
          ),
          SizedBox(height: 12),
          MyCourseCard(
            title: "Yapay Zeka Temelleri",
            subtitle: "Yapay Zeka • 15 Ders",
            progressPercent: 0.50,
            progressText: "%50",
            imageUrl: "https://picsum.photos/202",
          ),
          SizedBox(height: 12),
          MyCourseCard(
            title: "Siber Güvenlik 101",
            subtitle: "Siber Güvenlik • 10 Ders",
            progressPercent: 0.10,
            progressText: "%10",
            imageUrl: "https://picsum.photos/203",
          ),
          SizedBox(height: 12),
          MyCourseCard(
            title: "Girişimcilik ve İnovasyon",
            subtitle: "Girişimcilik • 8 Ders",
            progressPercent: 0.75,
            progressText: "%75",
            imageUrl: "https://picsum.photos/204",
          ),
        ],
      ),
    );
  }
}

class MyCourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progressPercent;
  final String progressText;
  final String imageUrl;

  const MyCourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progressPercent,
    required this.progressText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // TEXT + PROGRESS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: MyCoursesColors.gncBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: progressPercent,
                          minHeight: 6,
                          backgroundColor: const Color(0xFFE5E7EB),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            MyCoursesColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      progressText,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: MyCoursesColors.gncBlue,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
