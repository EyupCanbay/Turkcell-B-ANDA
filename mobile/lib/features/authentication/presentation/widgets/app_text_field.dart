import 'package:bi_anda/core/di/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.onChanged,
    this.isPassword = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword ? _obscure : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppColors.darkNavy)
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.darkNavy,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
