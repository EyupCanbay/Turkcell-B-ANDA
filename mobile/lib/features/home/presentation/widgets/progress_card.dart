import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class ProgressCard extends StatelessWidget {
  final String levelTitle;
  final String subtitle;
  final String description;
  final String progressLabel;
  final String progressPercentText;
  final double progressValue;

  const ProgressCard({
    super.key,
    required this.levelTitle,
    required this.subtitle,
    required this.description,
    required this.progressLabel,
    required this.progressPercentText,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = HomePage.primaryColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(levelTitle,
              style: const TextStyle(
                  color: primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle,
              style: TextStyle(
                  color: primaryColor.withOpacity(0.7), fontSize: 14)),
          Text(description,
              style: TextStyle(
                  color: primaryColor.withOpacity(0.7), fontSize: 14)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                progressLabel,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                progressPercentText,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 10,
              color: primaryColor.withOpacity(0.1),
              child: FractionallySizedBox(
                widthFactor: progressValue,
                alignment: Alignment.centerLeft,
                child: Container(color: primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Take Next Quiz",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
