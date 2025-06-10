import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/navigation.dart';
import '../../../../../../widgets/network_image/image_replacer.dart';
import '../../../../cinema_details/presentation/views/cinema_details.dart';
import '../../../../movie_details/data/model/movies_details_model/crew.dart';
import '../../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../../../movie_details/presentation/views/movie_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      fetchData();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.all(14.0.w),
        child: Column(
          children: [
            TextFormField(
              focusNode: _focusNode,
              controller: _controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0.r),
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    navigatePop(context: context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Icon(
                      Icons.cancel_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                hintText: lang.search,
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.3),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 14.sp,
              ),
            ),
            searchResults.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 17.0),
                      child: Text(
                        lang.noResultsFound,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final result = searchResults[index];
                        return Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: InkWell(
                            onTap: () {
                              if (result['id'].toString().contains('Cinema') ||
                                  result['id'].toString().contains('admin')) {
                                navigateTo(
                                  context: context,
                                  screen: CinemaDetails(
                                    cinemaModel: result,
                                  ),
                                );
                              } else {
                                navigateTo(
                                    context: context,
                                    screen: MovieDetails(
                                        model: MoviesDetailsModel(
                                      name: result['name'],
                                      castImages: result['cast_images'],
                                      ageRating: result['ageRating'],
                                      cast: result['cast'],
                                      category: result['category'],
                                      crew: Crew(
                                          director: result['crew']['director'],
                                          producer: result['crew']['producer'],
                                          writer: result['crew']['writer']),
                                      description: result['description'],
                                      duration: result['duration'],
                                      language: result['language'],
                                      posterImage: result['poster_image'],
                                      rating: result['rating'],
                                      releaseDate: result['releaseDate'],
                                      trailer: result['trailer'],
                                    )));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0.r),
                                color: Colors.black.withOpacity(0.2),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    child: ImageReplacer(
                                      imageUrl: result['poster_image'] ??
                                          'https://via.placeholder.com/50',
                                      width: 80.w,
                                      height: 100.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          result['name'] ??
                                              result['title'] ??
                                              'Unknown',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          result['category'] ?? 'Cinema',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              fontSize: 14.sp),
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          children: [
                                            Text(
                                              result['rating']
                                                      ?.toStringAsFixed(1) ??
                                                  'Unknown',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontSize: 14.sp),
                                            ),
                                            SizedBox(width: 5.w),
                                            Icon(Icons.star,
                                                color: Colors.yellow,
                                                size: 17.sp),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    String searchTerm = _controller.text.trim();
    if (searchTerm.isEmpty) {
      setState(() => searchResults.clear());
      return;
    }

    List<Map<String, dynamic>> results = await searchInCollections(searchTerm);
    if (mounted) {
      setState(() {
        searchResults = results;
      });
    }
  }

  Future<List<Map<String, dynamic>>> searchInCollections(
      String searchTerm) async {
    final db = FirebaseFirestore.instance;
    Set<String> seenIds = {};
    List<Map<String, dynamic>> results = [];

    if (searchTerm.isEmpty) return results; // ✅ تفريغ الليستة لو البحث فاضي

    try {
      String lowerCaseSearchTerm = searchTerm.toLowerCase();
      bool isSingleLetter = lowerCaseSearchTerm.length ==
          1; // ✅ التحقق إذا كان البحث بحرف واحد فقط

      QuerySnapshot moviesSnapshot =
          await db.collection('playing now films').get();

      for (var doc in moviesSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String movieName = data['name']?.toString().toLowerCase() ?? '';
        List<dynamic> castList = data['cast'] ?? [];

        bool movieMatches = isSingleLetter
            ? movieName.startsWith(
                lowerCaseSearchTerm) // ✅ لو حرف واحد، يبحث فقط في بداية اسم الفيلم
            : movieName.contains(
                lowerCaseSearchTerm); // ✅ لو أكثر من حرف، يمكن أن يكون في أي مكان

        bool actorMatches = !isSingleLetter &&
            castList.any((actor) =>
                actor.toString().toLowerCase() == lowerCaseSearchTerm);
        // ✅ البحث عن اسم الممثل كاملاً فقط إذا كان البحث بأكثر من حرف

        if ((movieMatches || actorMatches) && !seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add({'id': doc.id, ...data});
        }
      }

      QuerySnapshot comingSoonMoviesSnapshot =
          await db.collection('Movies').get();

      for (var doc in comingSoonMoviesSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String movieName = data['name']?.toString().toLowerCase() ?? '';
        List<dynamic> castList = data['cast'] ?? [];

        bool movieMatches = isSingleLetter
            ? movieName.startsWith(
                lowerCaseSearchTerm) // ✅ لو حرف واحد، يبحث فقط في بداية اسم الفيلم
            : movieName.contains(
                lowerCaseSearchTerm); // ✅ لو أكثر من حرف، يمكن أن يكون في أي مكان

        bool actorMatches = !isSingleLetter &&
            castList.any((actor) =>
                actor.toString().toLowerCase() == lowerCaseSearchTerm);
        // ✅ البحث عن اسم الممثل كاملاً فقط إذا كان البحث بأكثر من حرف

        if ((movieMatches || actorMatches) && !seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add({'id': doc.id, ...data});
        }
      }

      // ✅ البحث في السينمات بنفس منطق البحث عن الأفلام
      QuerySnapshot cinemasSnapshot = await db.collection('Cinemas').get();
      for (var doc in cinemasSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String cinemaName = data['name']?.toString().toLowerCase() ?? '';
        if (cinemaName.startsWith(lowerCaseSearchTerm) &&
            !seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add({'id': doc.id, ...data});
        }
      }
    } catch (e) {
      // print('❌ Error searching: $e'); // Removed: was used for debugging search errors
    }

    return results; // ✅ إرجاع النتائج بعد التحديث
  }
}
