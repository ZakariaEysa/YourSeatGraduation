// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meta/meta.dart';
//
// part 'search_state.dart';
//
// class SearchCubit extends Cubit<SearchState> {
//   SearchCubit() : super(SearchInitial());
//
//   Future<List<Map<String, dynamic>>> searchInCollections(String searchTerm) async {
//     final db = FirebaseFirestore.instance;
//     Set<String> seenIds = {};
//     List<Map<String, dynamic>> results = [];
//
//     if (searchTerm.isEmpty) return results;
//
//     try {
//       String lowerCaseSearchTerm = searchTerm.toLowerCase();
//
//       // 🔥 اجلب كل الأفلام أولًا ثم قم بتصفية النتائج محليًا
//       QuerySnapshot moviesSnapshot = await db.collection('MoviesBackUp').get();
//
//       for (var doc in moviesSnapshot.docs) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         String movieName = data['name']?.toString().toLowerCase() ?? '';
//
//         // ✅ البحث يكون بالاسم الذي يبدأ بنفس الحروف التي أدخلها المستخدم
//         if (movieName.startsWith(lowerCaseSearchTerm) && !seenIds.contains(doc.id)) {
//           seenIds.add(doc.id);
//           results.add({'id': doc.id, ...data});
//         }
//       }
//
//       // 🔥 البحث عن السينمات بنفس الطريقة
//       QuerySnapshot cinemasSnapshot = await db.collection('Cinemas').get();
//       for (var doc in cinemasSnapshot.docs) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         String cinemaName = data['name']?.toString().toLowerCase() ?? '';
//
//         if (cinemaName.startsWith(lowerCaseSearchTerm) && !seenIds.contains(doc.id)) {
//           seenIds.add(doc.id);
//           results.add({'id': doc.id, ...data});
//         }
//       }
//     } catch (e) {
//       // print('❌ Error searching: $e'); // Removed: was used for debugging search errors
//     }
//
//     return results;
//   }
//
//
// }
