// import 'package:flutter/material.dart';
// import '../../data/models/lesson_model.dart';

// class LessonCard extends StatelessWidget {
//   final LessonModel lesson;

//   const LessonCard({super.key, required this.lesson});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             lesson.title ?? "Ders",
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF002B5C),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             lesson.description ?? "",
//             style: const TextStyle(
//               fontSize: 14,
//               color: Color(0xFF444444),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
