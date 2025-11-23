import 'package:bi_anda/core/di/service_locator.dart';
import 'package:bi_anda/features/home/data/models/category_model.dart';
import 'package:bi_anda/features/home/data/models/lesson_model.dart';
import 'package:bi_anda/features/home/domain/usecases/get_categories.dart';
import 'package:bi_anda/features/home/domain/usecases/get_lessons.dart';
import 'package:bi_anda/features/home/presentation/widgets/category_chip.dart';
import 'package:bi_anda/features/home/presentation/widgets/course_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> _categories = [];
  List<LessonModel> _lessons = [];

  int _selectedCategoryId = 0; // 0 = Hepsi
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    try {
      final getCategories = getIt<GetCategoriesUseCase>();
      final getLessons = getIt<GetLessonsUseCase>();

      final categories = await getCategories();
      final lessons = await getLessons();

      setState(() {
        _categories = categories;
        _lessons = lessons;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("HomePage load error: $e");
    }
  }

  List<LessonModel> get _filteredPopularLessons {
    if (_selectedCategoryId == 0) return _lessons;
    return _lessons.where((l) => l.categoryId == _selectedCategoryId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BottomNav bu sayfada değil, MainNavigationPage içinde olmalı
      backgroundColor: const Color(0xFFF5F7F8),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadHomeData,
                child: Stack(
                  children: [
                    // ÜST SARI ARKA PLAN (ekranın yarısı)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Container(
                        color: const Color(0xFFFFD500),
                      ),
                    ),

                    // Tüm içerik
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HEADER
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(
                                    Icons.menu,
                                    color: Color(0xFF002B5C),
                                    size: 30,
                                  ),
                                ),
                                const Expanded(
                                  child: Text(
                                    "Welcome Back!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF002B5C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.notifications_none,
                                      color: Color(0xFF002B5C),
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // KATEGORİ CHIPLER
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CategoryChip(
                                    label: "Hepsi",
                                    isSelected: _selectedCategoryId == 0,
                                    onTap: () {
                                      setState(() => _selectedCategoryId = 0);
                                    },
                                  ),
                                  ..._categories.map(
                                    (c) => CategoryChip(
                                      label: c.name,
                                      isSelected: _selectedCategoryId == c.id,
                                      onTap: () {
                                        setState(
                                            () => _selectedCategoryId = c.id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // POPÜLER KURSLAR TITLE
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Popüler Kurslar",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF002B5C),
                                  ),
                                ),
                                Text(
                                  "Tümünü Gör",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF002B5C),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // POPÜLER KURSLAR LİSTESİ
                          SizedBox(
                            height: 220,
                            child: _filteredPopularLessons.isEmpty
                                ? const Center(
                                    child: Text(
                                      "Bu kategoride kurs bulunamadı.",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(left: 16),
                                    itemCount: _filteredPopularLessons.length,
                                    itemBuilder: (context, index) {
                                      final lesson =
                                          _filteredPopularLessons[index];
                                      return CourseCard(lesson: lesson);
                                    },
                                  ),
                          ),

                          const SizedBox(height: 20),

                          // LEVEL CARD (statik)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Expert Level",
                                    style: TextStyle(
                                      color: Color(0xFF002B5C),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "You're doing great, keep it up!",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    "Latest Quiz Score",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Level Progress",
                                        style: TextStyle(
                                          color: Color(0xFF002B5C),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "75%",
                                        style: TextStyle(
                                          color: Color(0xFF002B5C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(999),
                                    child: LinearProgressIndicator(
                                      value: 0.75,
                                      minHeight: 8,
                                      color: const Color(0xFF002B5C),
                                      backgroundColor: const Color(0xFF002B5C)
                                          .withOpacity(0.15),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    height: 44,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF002B5C),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        "Take Next Quiz",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // DERSLERİM
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Derslerim",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF002B5C),
                                  ),
                                ),
                                Text(
                                  "Tümünü Gör",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF002B5C),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            height: 220,
                            child: _lessons.isEmpty
                                ? const Center(
                                    child: Text(
                                      "Henüz dersiniz yok.",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(left: 16),
                                    itemCount: _lessons.length,
                                    itemBuilder: (context, index) {
                                      final lesson = _lessons[index];
                                      return CourseCard(lesson: lesson);
                                    },
                                  ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
