import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF002B5C),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7F8),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(icon, color: const Color(0xFF002B5C)),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "",
                  ),
                  style: const TextStyle(
                    color: Color(0xFF002B5C),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}
