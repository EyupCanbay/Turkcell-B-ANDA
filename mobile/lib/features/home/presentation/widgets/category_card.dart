import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          category.name ?? "Kategori",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF002B5C),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
