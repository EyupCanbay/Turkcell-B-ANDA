import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';

class SharedCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const SharedCircleButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
            )
          ],
        ),
        child: Icon(icon, color: CdColors.gncBlue),
      ),
    );
  }
}
