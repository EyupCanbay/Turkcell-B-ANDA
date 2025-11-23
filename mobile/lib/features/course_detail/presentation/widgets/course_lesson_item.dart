import 'package:flutter/material.dart';

class CourseLessonItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isCurrent;

  const CourseLessonItem({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = isCurrent
        ? const Color(0xffFFCA00)
        : isCompleted
            ? Colors.green
            : Colors.grey;

    IconData icon = isCurrent
        ? Icons.play_circle_fill
        : isCompleted
            ? Icons.check_circle
            : Icons.lock;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border:
            isCurrent ? Border.all(color: Color(0xffFFCA00), width: 2) : null,
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  color: Color(0xff002B5C),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
