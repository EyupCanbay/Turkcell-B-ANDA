import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';
import '../widgets/shared_circle_button.dart';
import 'quiz_result_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CdColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const _QuizHeader(),
                const Expanded(child: _QuizContent())
              ],
            ),
            _QuizBottomButton()
          ],
        ),
      ),
    );
  }
}

// Header
class _QuizHeader extends StatelessWidget {
  const _QuizHeader();

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
                "Social Media Quiz",
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
class _QuizContent extends StatelessWidget {
  const _QuizContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 90, top: 8),
      child: Column(
        children: [
          _progressCard(),
          const SizedBox(height: 16),
          _questionCard(),
          const SizedBox(height: 16),
          _quizOption("Facebook"),
          const SizedBox(height: 10),
          _quizOption("Instagram"),
          const SizedBox(height: 10),
          _quizOption("LinkedIn", selected: true),
          const SizedBox(height: 10),
          _quizOption("TikTok"),
        ],
      ),
    );
  }

  Widget _progressCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: box(),
      child: Column(
        children: [
          const Text("Question 1 / 10",
              style: TextStyle(
                  color: CdColors.gncBlue, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.1,
              minHeight: 8,
              backgroundColor: Color(0xFFDADADA),
              valueColor: AlwaysStoppedAnimation<Color>(CdColors.gncYellow),
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: box(),
      child: const Text(
        "Which platform is known for professional networking?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: CdColors.gncBlue,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
    );
  }

  BoxDecoration box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      );

  Widget _quizOption(String text, {bool selected = false}) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? CdColors.gncYellow : Colors.white,
          foregroundColor: CdColors.gncBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
            side: BorderSide(
                color: selected ? CdColors.gncBlue : Colors.transparent,
                width: 2),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// Bottom button
class _QuizBottomButton extends StatelessWidget {
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizResultPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CdColors.gncYellow,
              foregroundColor: CdColors.gncBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Submit Answer",
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
