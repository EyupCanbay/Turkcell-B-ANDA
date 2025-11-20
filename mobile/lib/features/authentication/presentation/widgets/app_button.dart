import 'package:bi_anda/core/di/theme/app_colors.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(text, style: AppTextStyles.button),
      ),
    );
  }
}
