import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/leaderboard_bloc.dart';
import '../bloc/leaderboard_event.dart';
import '../bloc/leaderboard_state.dart';
import '../widgets/top_three_podium.dart';
import '../widgets/leaderboard_list_item.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int _selectedIndex = 0; // 0: Leaderboard, 1: My Progress

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<LeaderboardBloc>()..add(LoadLeaderboardEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F5), // background-light
        body: SafeArea(
          child: Column(
            children: [
              // 1. HEADER (Custom App Bar)
              _buildHeader(),

              // 2. SEGMENTED CONTROL (Toggle)
              _buildSegmentedControl(),

              // 3. İÇERİK
              Expanded(
                child: _selectedIndex == 0
                    ? _buildLeaderboardView()
                    : _buildMyProgressView(), // Şimdilik boş veya placeholder
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Geri butonu yok (istek üzerine)
          const Expanded(
            child: Text(
              "Progress & Leaderboard",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1), // Hafif lacivert zemin
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _buildSegmentButton("Leaderboard", 0),
          _buildSegmentButton("My Progress", 1),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String text, int index) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.designYellow : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.designYellow.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textSub, // Primary lacivert
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardView() {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoading) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.designYellow));
        } else if (state is LeaderboardError) {
          return Center(child: Text(state.message));
        } else if (state is LeaderboardLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Filtreler
                _buildFilters(),

                // Kürsü (İlk 3)
                TopThreePodium(users: state.topThree),

                // Liste (Geri Kalanlar)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.rest.length,
                    itemBuilder: (context, index) {
                      // Sıralama 4'ten başlar
                      return LeaderboardListItem(
                        user: state.rest[index],
                        rank: index + 4,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildFilterChip("This Week", true),
          const SizedBox(width: 8),
          _buildFilterChip("My City", false),
          const SizedBox(width: 8),
          _buildFilterChip("My University", false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.designYellow : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.primary : AppColors.textMain,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down,
                size: 18, color: AppColors.primary),
          ]
        ],
      ),
    );
  }

  Widget _buildMyProgressView() {
    return const Center(
      child: Text("My Progress Sayfası Yakında..."),
    );
  }
}
