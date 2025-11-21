import 'package:flutter/material.dart';
import '../styles/mycourses_colors.dart';

class MyCoursesCategoryFilters extends StatelessWidget {
  const MyCoursesCategoryFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: const [
          _CategoryChip(label: "Tümü", selected: true),
          SizedBox(width: 8),
          _CategoryChip(label: "Yazılım"),
          SizedBox(width: 8),
          _CategoryChip(label: "Yapay Zeka"),
          SizedBox(width: 8),
          _CategoryChip(label: "Siber Güvenlik"),
          SizedBox(width: 8),
          _CategoryChip(label: "Girişimcilik"),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _CategoryChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: selected ? MyCoursesColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(999),
        border:
            selected ? null : Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ]
            : [],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: MyCoursesColors.gncBlue,
          fontWeight: selected ? FontWeight.bold : FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
