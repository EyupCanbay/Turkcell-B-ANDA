import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';
import '../widgets/shared_circle_button.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CdColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const _QuizResultHeader(),
                const Expanded(child: _QuizResultContent()),
              ],
            ),
            const _QuizResultBottomButton(),
          ],
        ),
      ),
    );
  }
}

// Header
class _QuizResultHeader extends StatelessWidget {
  const _QuizResultHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          SharedCircleButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Quiz Result",
                style: TextStyle(
                  color: CdColors.gncBlue,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

// Content
class _QuizResultContent extends StatelessWidget {
  const _QuizResultContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 90, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _accuracyCard(),
          const SizedBox(height: 16),
          _statsRow(),
          const SizedBox(height: 16),
          _pointsCard(),
        ],
      ),
    );
  }

  Widget _accuracyCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _box(),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 3,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFFD1D5DB)),
                ),
                const CircularProgressIndicator(
                  value: 0.8,
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(CdColors.gncYellow),
                ),
                const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "80%",
                        style: TextStyle(
                          color: CdColors.gncBlue,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text("Accuracy", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Great Job!",
            style: TextStyle(
              color: CdColors.gncBlue,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "You're doing amazing. Keep it up!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF4B5563), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: const [
        Expanded(
          child: _StatCard(
            icon: Icons.check_circle,
            iconColor: CdColors.green,
            value: "8",
            label: "Correct",
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.cancel,
            iconColor: CdColors.red,
            value: "2",
            label: "Incorrect",
          ),
        ),
      ],
    );
  }

  Widget _pointsCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CdColors.gncYellow.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: CdColors.gncYellow),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: CdColors.gncYellow,
            child: const Icon(Icons.emoji_events,
                color: CdColors.gncBlue, size: 26),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "+25 Points Added",
                style: TextStyle(
                  color: CdColors.gncBlue,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Weekly Total: 450 Points",
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      );
}

// Bottom button
class _QuizResultBottomButton extends StatelessWidget {
  const _QuizResultBottomButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: CdColors.backgroundLight.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
            )
          ],
        ),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CdColors.gncYellow,
              foregroundColor: CdColors.gncBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Back to Course",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: CdColors.gncBlue,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
