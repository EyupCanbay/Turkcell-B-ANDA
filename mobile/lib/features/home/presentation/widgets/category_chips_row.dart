import 'package:bi_anda/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class CategoryChipsRow extends StatelessWidget {
  const CategoryChipsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "Yazılım",
      "Yapay Zeka",
      "Siber Güvenlik",
      "Girişimcilik"
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return CategoryChip(
            label: categories[index],
            isSelected: index == 0,
            onTap: () {},
          );
        },
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = HomePage.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: isSelected
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : primaryColor,
          ),
        ),
      ),
    );
  }
}
