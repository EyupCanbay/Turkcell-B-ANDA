import 'package:flutter/material.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/category_chips_row.dart';
import '../widgets/section_header.dart';
import '../widgets/course_card.dart';
import '../widgets/progress_card.dart';
import '../widgets/gnc_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color primaryColor = Color(0xFF002B5C);
  static const Color backgroundLight = Color(0xFFF5F7F8);
  static const Color turkcellYellow = Color(0xFFFFD500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          // Üst yarı sarı alan
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: turkcellYellow,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const HomeAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        const CategoryChipsRow(),
                        const SizedBox(height: 16),

                        // Popüler Kurslar
                        const SectionHeader(
                          title: "Popüler Kurslar",
                        ),
                        const SizedBox(height: 8),

                        SizedBox(
                          height: 210,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              CourseCard(
                                title: "İngilizce A1 Seviyesi",
                                description:
                                    "Temel dilbilgisi ve kelime bilgisi.",
                                imageUrl:
                                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBIh_83gXfqjTh6co_E_eTSBcVlVW5TCpqxSPmPuxlgJ18pyEKok8bSuZqg_0bQw_hEndVA99DSZ3XT9h3_Y93gsKV-XEpf0te9EgmtNQChxG1-gCHfJCZTgxy1FIAKk_RoO-quVbdt5RPQPfvGV3HY4Pe2CbM-e4mRPbU88CevHWhVW2TSJAPGkQeF-ANpdlL1cSlomG9K5efrbmoyHFtOnaPKKGjSpBeZ9cZZhWVJkPWo7CGAv_r8dp6o_WLrYH2M61xDzOwc7y8",
                              ),
                              SizedBox(width: 12),
                              CourseCard(
                                title: "Girişimcilik 101",
                                description: "Kendi işini kurmanın temelleri.",
                                imageUrl:
                                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBIh_83gXfqjTh6co_E_eTSBcVlVW5TCpqxSPmPuxlgJ18pyEKok8bSuZqg_0bQw_hEndVA99DSZ3XT9h3_Y93gsKV-XEpf0te9EgmtNQChxG1-gCHfJCZTgxy1FIAKk_RoO-quVbdt5RPQPfvGV3HY4Pe2CbM-e4mRPbU88CevHWhVW2TSJAPGkQeF-ANpdlL1cSlomG9K5efrbmoyHFtOnaPKKGjSpBeZ9cZZhWVJkPWo7CGAv_r8dp6o_WLrYH2M61xDzOwc7y8",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        const ProgressCard(
                          levelTitle: "Expert Level",
                          subtitle: "You're doing great, keep it up!",
                          description: "Latest Quiz Score",
                          progressLabel: "Level Progress",
                          progressPercentText: "75%",
                          progressValue: 0.75,
                        ),

                        const SizedBox(height: 20),

                        const SectionHeader(title: "Derslerim"),
                        const SizedBox(height: 8),

                        SizedBox(
                          height: 210,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              CourseCard(
                                title: "Python Programlama",
                                description:
                                    "Başlangıç seviyesi Python dersleri.",
                                imageUrl:
                                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBIh_83gXfqjTh6co_E_eTSBcVlVW5TCpqxSPmPuxlgJ18pyEKok8bSuZqg_0bQw_hEndVA99DSZ3XT9h3_Y93gsKV-XEpf0te9EgmtNQChxG1-gCHfJCZTgxy1FIAKk_RoO-quVbdt5RPQPfvGV3HY4Pe2CbM-e4mRPbU88CevHWhVW2TSJAPGkQeF-ANpdlL1cSlomG9K5efrbmoyHFtOnaPKKGjSpBeZ9cZZhWVJkPWo7CGAv_r8dp6o_WLrYH2M61xDzOwc7y8",
                              ),
                              SizedBox(width: 12),
                              CourseCard(
                                title: "Grafik Tasarım",
                                description: "Tasarımın temellerini öğrenin.",
                                imageUrl:
                                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBIh_83gXfqjTh6co_E_eTSBcVlVW5TCpqxSPmPuxlgJ18pyEKok8bSuZqg_0bQw_hEndVA99DSZ3XT9h3_Y93gsKV-XEpf0te9EgmtNQChxG1-gCHfJCZTgxy1FIAKk_RoO-quVbdt5RPQPfvGV3HY4Pe2CbM-e4mRPbU88CevHWhVW2TSJAPGkQeF-ANpdlL1cSlomG9K5efrbmoyHFtOnaPKKGjSpBeZ9cZZhWVJkPWo7CGAv_r8dp6o_WLrYH2M61xDzOwc7y8",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
                const GnCBottomNavBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
