import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';

class CdQuizCard extends StatelessWidget {
  final VoidCallback onStartQuiz;

  const CdQuizCard({super.key, required this.onStartQuiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lesson Quiz",
              style: TextStyle(
                color: CdColors.gncBlue,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Each lesson ends with a quick quiz to measure your understanding.",
              style: TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.help_outline, color: CdColors.gncYellow),
                SizedBox(width: 6),
                Text("10 Questions",
                    style: TextStyle(
                        color: CdColors.gncBlue, fontWeight: FontWeight.w600)),
                SizedBox(width: 24),
                Icon(Icons.timer, color: CdColors.gncYellow),
                SizedBox(width: 6),
                Text("Est. 5 min",
                    style: TextStyle(
                        color: CdColors.gncBlue, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: onStartQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CdColors.gncYellow,
                  foregroundColor: CdColors.gncBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 6,
                ),
                child: const Text(
                  "Start Quiz",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
