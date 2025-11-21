import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';

class CdDescriptionCard extends StatelessWidget {
  const CdDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              "This lesson breaks down how social media algorithms work.",
              style: TextStyle(
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Show More",
                style: TextStyle(
                  color: CdColors.gncBlue,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
