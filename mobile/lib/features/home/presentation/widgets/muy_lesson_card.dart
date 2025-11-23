// import 'package:flutter/material.dart';
// import '../../data/models/lesson_model.dart';

// class MyLessonCard extends StatelessWidget {
//   final LessonModel lesson;

//   const MyLessonCard({
//     super.key,
//     required this.lesson,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
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
//           // Thumbnail
//           Container(
//             height: 120,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(18),
//                 topRight: Radius.circular(18),
//               ),
//               image: DecorationImage(
//                 image: NetworkImage(
//                   lesson.thumbnail ??
//                       "https://picsum.photos/200?random=${lesson.id}",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // Title / Desc
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   lesson.title ?? "Ders",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     color: Color(0xFF002B5C),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   lesson.description ?? "",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Colors.black.withOpacity(0.6),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
