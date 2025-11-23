import 'package:flutter/material.dart';

class CourseDescriptionCard extends StatefulWidget {
  final String description;

  const CourseDescriptionCard({super.key, required this.description});

  @override
  State<CourseDescriptionCard> createState() => _CourseDescriptionCardState();
}

class _CourseDescriptionCardState extends State<CourseDescriptionCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.description,
            maxLines: expanded ? null : 3,
            overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 15, height: 1.4, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => expanded = !expanded),
            child: Text(
              expanded ? "Show Less" : "Show More",
              style: const TextStyle(
                  color: Color(0xff002B5C),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
