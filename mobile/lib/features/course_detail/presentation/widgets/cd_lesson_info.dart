import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';

class CdLessonInfo extends StatelessWidget {
  const CdLessonInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '1. Understanding the Algorithm',
            style: TextStyle(
              color: CdColors.gncBlue,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.schedule, size: 18, color: Colors.grey),
              SizedBox(width: 4),
              Text('12 min', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 16),
              Icon(Icons.signal_cellular_alt, size: 18, color: Colors.grey),
              SizedBox(width: 4),
              Text('Beginner', style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
