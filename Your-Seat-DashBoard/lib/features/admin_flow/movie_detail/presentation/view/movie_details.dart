// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
// import '../../../../../widgets/button/button_builder.dart';
// import '../widgets/crew_names.dart';
// import '../widgets/movie_info.dart';
// import '../widgets/actor_names.dart';
// import '../widgets/story_line.dart';
//
// class MovieDetail extends StatefulWidget {
//   final Map<String, String> movieData;
//   final bool isViewOnly;
//   final bool isEditing;
//   const MovieDetail({super.key, required this.movieData, this.isViewOnly = false,this.isEditing = false,});
//
//   static final GlobalKey<MovieInfoScreenState> _movieInfoKey = GlobalKey<MovieInfoScreenState>();
//
//   @override
//   State<MovieDetail> createState() => _MovieDetailState();
// }
//
// class _MovieDetailState extends State<MovieDetail> {
//   final TextEditingController promoLinkController = TextEditingController();
//   String? promoLinkError;
//
//   @override
//   void initState() {
//     super.initState();
//     promoLinkController.text = widget.movieData['promoUrl'] ?? '';
//   }
//
//   @override
//   void dispose() {
//     promoLinkController.dispose();
//     super.dispose();
//   }
//
//   void onLinkChanged(String value) {
//     setState(() {
//       if (value.isEmpty) {
//         promoLinkError = 'Promo link cannot be empty';
//       } else if (!(Uri.tryParse(value)?.hasAbsolutePath ?? false)) {
//         promoLinkError = 'Invalid URL format';
//       } else {
//         promoLinkError = null;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final directors = widget.movieData['directors']?.split(',').map((e) => e.trim()).toList() ?? [];
//     final actors = widget.movieData['actors']?.split(',').map((e) => e.trim()).toList() ?? [];
//
//     return WillPopScope(
//       onWillPop: () async {
//         StoryLine.clearFields(context);
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Row(
//           children: [
//             Expanded(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return SingleChildScrollView(
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                       child: IntrinsicHeight(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 9.w),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(right: 270.w, top: 20.h),
//                                   child: ButtonBuilder(
//                                     text: 'Back',
//                                     onTap: () {
//
//                                       // Cancel logic
//                                       StoryLine.clearFields(context);
//                                       Navigator.pop(context);
//                                     },
//                                     width: 30.w,
//                                     height: 40.h,
//                                     buttonColor: const Color(0xFF560B76),
//                                     borderShape: BorderRadius.circular(10.r),
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 7.sp,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 20.h),
//
//                               MovieInfoScreen(
//                                 key: MovieDetail._movieInfoKey,
//                                 movieData: widget.movieData,
//                                 isViewOnly: widget.isViewOnly,
//                               ),
//
//                               Padding(
//                                 padding: EdgeInsets.only(left: 70.w, top: 30.h, bottom: 10.h),
//                                 child: Text(
//                                   "Story Line",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 6.sp,
//                                   ),
//                                 ),
//                               ),
//
//                               StoryLine(
//                                 initialValue: widget.movieData['storyLine'] ?? '',
//                                 readOnly: widget.isViewOnly, // هذا سيجعل الحقل للعرض فقط إذا كان isViewOnly = true
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 8.w, right: 2.w, top: 20.h, bottom: 30.h),
//                                 child: ActorNames(
//
//                        actors: actors,
//                                   isViewOnly: widget.isViewOnly,
//                                 ),
//                               ),
//
//                               SizedBox(height: 20.h),
//                               CrewNames(
//                                 key: CrewNames.crewKey,
//                                 directorName: widget.movieData['Director Name'] ?? '',
//                                 writerName: widget.movieData['Writer Name'] ?? '',
//                                 producerName: widget.movieData['Producer Name'] ?? '',
//                                 isViewOnly: widget.isViewOnly,
//                               ),
//                               SizedBox(height: 60.h),
//
//                               if (!widget.isViewOnly)
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     // ButtonBuilder(
//                                     //   text: 'Add Movie',
//                                     //   onTap: () {
//                                     //     MovieCubit.get(context).printControllers();
//                                     //     final isMovieInfoValid = MovieDetail._movieInfoKey.currentState?.validateFields() ?? false;
//                                     //     final isNamesValid = Names.validate();
//                                     //     final isStoryLineValid = StoryLine.validate();
//                                     //
//                                     //     if (isMovieInfoValid && isNamesValid && isStoryLineValid && promoLinkError == null) {
//                                     //       print('All fields are valid');
//                                     //       print('Final Promo Link: ${promoLinkController.text}');
//                                     //       // Save or update movie logic here
//                                     //     } else {
//                                     //       print('Validation failed');
//                                     //     }
//                                     //   },
//                                     //   width: 40.w,
//                                     //   height: 50.h,
//                                     //   buttonColor: const Color(0xFF560B76),
//                                     //   borderShape: BorderRadius.circular(10.r),
//                                     //   style: TextStyle(
//                                     //     color: Colors.white,
//                                     //     fontWeight: FontWeight.bold,
//                                     //     fontSize: 7.sp,
//                                     //   ),
//                                     // ),
//                                     ButtonBuilder(
//                       text: widget.isEditing ? 'Save' : 'Add Movie',
//                                       onTap: () {
//
//                                         // التحقق من صحة البيانات
//                                         final isMovieInfoValid = MovieDetail._movieInfoKey.currentState?.validateFields() ?? false;
//                                         final isNamesValid = ActorNames.validate();
//                                         final isStoryLineValid = StoryLine.validate();
//                                         final isCrewValid = CrewNames.crewKey.currentState?.widget.validate() ?? false;
//
//                                         if (isMovieInfoValid && isNamesValid && isStoryLineValid&&isCrewValid && promoLinkError == null) {
//                                           MovieCubit.get(context).uploadMovieToFirestore();
//
//                                           print('All fields are valid');
//
//                                           MovieCubit.get(context).printControllers();
//
//                                           print('Final Promo Link: ${promoLinkController.text}');
//
//                                           // بعد الفاليديشن الصحيح، استدعاء دالة رفع الفيلم
//                                           MovieCubit.get(context).uploadMovieToFirestore();
//                                         } else {
//                                           print('Validation failed');
//                                         }
//                                         MovieCubit.get(context).uploadMovieToFirestore();
//                                       },
//                                       width: 40.w,
//                                       height: 50.h,
//                                       buttonColor: const Color(0xFF560B76),
//                                       borderShape: BorderRadius.circular(10.r),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 7.sp,
//                                       ),
//                                     ),
//
//                                     SizedBox(width: 10.w),
//                                     ButtonBuilder(
//                                       text: 'Cancel',
//                                       onTap: () {
//                                         StoryLine.clearFields(context);
//                                         Navigator.pop(context);
//                                       },
//                                       width: 40.w,
//                                       height: 50.h,
//                                       buttonColor: const Color(0xFF560B76),
//                                       borderShape: BorderRadius.circular(10.r),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 7.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               const SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
// import 'package:yourseatgraduationproject/utils/app_logs.dart';
// import 'package:yourseatgraduationproject/utils/loading_indicator.dart';
// import 'package:yourseatgraduationproject/utils/navigation.dart';
// import '../../../../../widgets/button/button_builder.dart';
// import '../../../moives/data/movies_cubit/movies_state.dart';
// import '../widgets/crew_names.dart';
// import '../widgets/movie_info.dart';
// import '../widgets/actor_names.dart';
// import '../widgets/story_line.dart';
//
// class MovieDetail extends StatefulWidget {
//   final Map<String, dynamic> movieData;
//   final bool isViewOnly;
//   final bool isEditing;
//   int? index;
//
//    MovieDetail({
//     super.key,
//     this.index,
//     required this.movieData,
//     this.isViewOnly = false,
//     this.isEditing = false,
//   });
//
//   static final GlobalKey<MovieInfoScreenState> _movieInfoKey = GlobalKey<MovieInfoScreenState>();
//
//   @override
//   State<MovieDetail> createState() => _MovieDetailState();
// }
//
// class _MovieDetailState extends State<MovieDetail> {
//   final TextEditingController promoLinkController = TextEditingController();
//   String? promoLinkError;
//
//   @override
//   void initState() {
//     super.initState();
//     promoLinkController.text = widget.movieData['promoUrl'] ?? '';
//     MovieCubit.get(context).currentIndex = widget.index;
//    // AppLogs.errorLog("Current index is :");
//     //print(    MovieCubit.get(context).currentIndex = widget.index);
//   }
//
//   @override
//   void dispose() {
//     promoLinkController.dispose();
//     super.dispose();
//   }
//
//   void onLinkChanged(String value) {
//     setState(() {
//       if (value.isEmpty) {
//         promoLinkError = 'Promo link cannot be empty';
//       } else if (!(Uri.tryParse(value)?.hasAbsolutePath ?? false)) {
//         promoLinkError = 'Invalid URL format';
//       } else {
//         promoLinkError = null;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
// //print(    widget.movieData);
//     // final directors = widget.movieData['directors']?.split(',').map((e) => e.trim()).toList() ?? [];
//      //final actors = widget.movieData['cast']?.split(',').map((e) => e.trim()).toList() ?? [];
//     final actors = List<String>.from(widget.movieData['cast'] ?? []);
//     final crewMap = widget.movieData['crew'];
//       //print(crewMap);
//     final String director = widget.movieData['crew']?['director'] ?? '';
//     //print(director);
//     final String writer = crewMap?['writer'] ?? '';
//     //print(writer);
//     final String producer = crewMap?['producer'] ?? '';
//     //print(producer);
//
//
//     return BlocListener<MovieCubit, MovieState>(
//       listener: (context, state) {
//         if (state.success) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               backgroundColor: Colors.green,
//               content: Text(
//                 "Your Movie is Uploaded Successfully",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           );
//          navigatePop(context: context);
//         }
//         if (state.error != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: Colors.red,
//               content: Text(
//                 "Error: ${state.error}",
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           );
//         }
//       },
//       child: BlocBuilder<MovieCubit, MovieState>(
//
//         builder: (context, state) {
//           return Stack(
//             children: [
//               WillPopScope(
//                 onWillPop: () async {
//                   StoryLine.clearFields(context);
//                   return true;
//                 },
//                 child: Scaffold(
//                   backgroundColor: Colors.white,
//                   body: Row(
//                     children: [
//                       Expanded(
//                         child: LayoutBuilder(
//                           builder: (context, constraints) {
//                             return SingleChildScrollView(
//                               child: ConstrainedBox(
//                                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                                 child: IntrinsicHeight(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 9.w),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                                       children: [
//                                         Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(right: 270.w, top: 20.h),
//                                             child: ButtonBuilder(
//                                               text: 'Back',
//                                               onTap: () {
//                                                 StoryLine.clearFields(context);
//                                                 Navigator.pop(context);
//                                               },
//                                               width: 30.w,
//                                               height: 40.h,
//                                               buttonColor: const Color(0xFF560B76),
//                                               borderShape: BorderRadius.circular(10.r),
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 7.sp,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(height: 20.h),
//                                         MovieInfoScreen(
//                                           key: MovieDetail._movieInfoKey,
//                                           movieData: widget.movieData,
//                                           isViewOnly: widget.isViewOnly,
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 70.w, top: 30.h, bottom: 10.h),
//                                           child: Text(
//                                             "Story Line",
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 6.sp,
//                                             ),
//                                           ),
//                                         ),
//                                         StoryLine(
//                                           initialValue: widget.movieData['description'] ?? '',
//                                           readOnly: widget.isViewOnly,
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 30.h),
//                                           child: ActorNames(
//                                             movieData: widget.movieData,
//                                             actors: actors,
//                                             isViewOnly: widget.isViewOnly,
//                                           ),
//                                         ),
//                                         SizedBox(height: 20.h),
//                                         CrewNames(
//                                           movieData: widget.movieData,
//                                           key: CrewNames.crewKey,
//                                           directorName: director,
//                                           writerName: writer,
//                                           producerName: producer,
//                                           isViewOnly: widget.isViewOnly,
//                                         ),
//                                         SizedBox(height: 60.h),
//                                         if (!widget.isViewOnly)
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               ButtonBuilder(
//                                                 text: widget.isEditing ? 'Save' : 'Add Movie',
//                                                 onTap: () async {
//                                                   final isMovieInfoValid = MovieDetail._movieInfoKey.currentState?.validateFields() ?? false;
//                                                   final isNamesValid = ActorNames.validate();
//                                                   final isStoryLineValid = StoryLine.validate();
//                                                   final isCrewValid = CrewNames.crewKey.currentState?.widget.validate() ?? false;
//
//                                                   if (isMovieInfoValid && isNamesValid && isStoryLineValid && isCrewValid && promoLinkError == null) {
//                                                     if (widget.isEditing) {
//                                                      MovieCubit.get(context).updateMovieInCinemaWithPreparedData(context: context);
//                                                      AppLogs.scussessLog("Finish uploading to cinema");
//                                                      print(MovieCubit.get(context).coverPhoto);
//                                                      MovieCubit.get(context).updateMovieDocumentByName(context: context);
//                                                      AppLogs.scussessLog("Finish uploading to playing now");
//
//                                                      Navigator.pop(context);
//                                                     } else {
//                                                       MovieCubit.get(context).addMovieToCinema();
//                                                       MovieCubit.get(context).uploadMovieToFireStore();
//                                                     }
//                                                   } else {
//                                                     ScaffoldMessenger.of(context).showSnackBar(
//                                                       const SnackBar(
//                                                         backgroundColor: Colors.red,
//                                                         content: Text("Oops Something went wrong please try again", style: TextStyle(color: Colors.white)),
//                                                       ),
//                                                     );
//                                                   }
//                                                 },
//
//                                                 // onTap: () {
//                                                 //   final isMovieInfoValid = MovieDetail._movieInfoKey.currentState?.validateFields() ?? false;
//                                                 //   final isNamesValid = ActorNames.validate();
//                                                 //   final isStoryLineValid = StoryLine.validate();
//                                                 //   final isCrewValid = CrewNames.crewKey.currentState?.widget.validate() ?? false;
//                                                 //
//                                                 //   if (isMovieInfoValid && isNamesValid && isStoryLineValid && isCrewValid && promoLinkError == null) {
//                                                 //     //MovieCubit.get(context).uploadMovieToFirestore();
//                                                 //     MovieCubit.get(context).addMovieToCinema();
//                                                 //     //MovieCubit.get(context).fetchedCinemaMovies;
//                                                 //   } else {
//                                                 //     ScaffoldMessenger.of(context).showSnackBar(
//                                                 //       const SnackBar(
//                                                 //         backgroundColor: Colors.red,
//                                                 //         content: Text("Oops Something went wrong please try again",style: TextStyle(color: Colors.white)),
//                                                 //       ),
//                                                 //     );
//                                                 //   }
//                                                 // },
//                                                 width: 40.w,
//                                                 height: 50.h,
//                                                 buttonColor: const Color(0xFF560B76),
//                                                 borderShape: BorderRadius.circular(10.r),
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 7.sp,
//                                                 ),
//                                               ),
//                                               SizedBox(width: 10.w),
//                                               ButtonBuilder(
//                                                 text: 'Cancel',
//                                                 onTap: () {
//                                                   StoryLine.clearFields(context);
//                                                   Navigator.pop(context);
//                                                 },
//                                                 width: 40.w,
//                                                 height: 50.h,
//                                                 buttonColor: const Color(0xFF560B76),
//                                                 borderShape: BorderRadius.circular(10.r),
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 7.sp,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         const SizedBox(height: 10),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               if (state.loading)
//                 Positioned.fill(
//                   child: Container(
//                     color: Colors.black.withOpacity(0.3),
//                     child: const Center(
//                       child: LoadingIndicator(),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';
import 'package:yourseatgraduationproject/utils/loading_indicator.dart';
import 'package:yourseatgraduationproject/utils/navigation.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../../../moives/data/movies_cubit/movies_state.dart';
import '../widgets/crew_names.dart';
import '../widgets/movie_info.dart';
import '../widgets/actor_names.dart';
import '../widgets/story_line.dart';

class MovieDetail extends StatefulWidget {
  final Map<String, dynamic> movieData;
  final bool isViewOnly;
  final bool isEditing;
  int? index;

  MovieDetail({
    super.key,
    this.index,
    required this.movieData,
    this.isViewOnly = false,
    this.isEditing = false,
  });

  static final GlobalKey<MovieInfoScreenState> _movieInfoKey =
      GlobalKey<MovieInfoScreenState>();

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final TextEditingController promoLinkController = TextEditingController();
  String? promoLinkError;

  @override
  void initState() {
    super.initState();
    promoLinkController.text = widget.movieData['promoUrl'] ?? '';
    MovieCubit.get(context).currentIndex = widget.index;
  }

  @override
  void dispose() {
    promoLinkController.dispose();
    super.dispose();
  }

  void onLinkChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        promoLinkError = 'Promo link cannot be empty';
      } else if (!(Uri.tryParse(value)?.hasAbsolutePath ?? false)) {
        promoLinkError = 'Invalid URL format';
      } else {
        promoLinkError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final actors = List<String>.from(widget.movieData['cast'] ?? []);
    final crewMap = widget.movieData['crew'];
    final String director = widget.movieData['crew']?['director'] ?? '';
    final String writer = crewMap?['writer'] ?? '';
    final String producer = crewMap?['producer'] ?? '';

    return BlocListener<MovieCubit, MovieState>(
      listener: (context, state) {
        if (state is MovieSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Your Movie is Uploaded Successfully",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
          navigatePop(context: context);
        }
        if (state is MovieError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Error: ${state.message}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          bool isLoading = state is MovieLoading;
          return Stack(
            children: [
              WillPopScope(
                onWillPop: () async {
                  StoryLine.clearFields(context);
                  return true;
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Row(
                    children: [
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight),
                                child: IntrinsicHeight(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 9.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 270.w, top: 20.h),
                                            child: ButtonBuilder(
                                              text: 'Back',
                                              onTap: () {
                                                StoryLine.clearFields(context);
                                                Navigator.pop(context);
                                              },
                                              width: 30.w,
                                              height: 40.h,
                                              buttonColor:
                                                  const Color(0xFF560B76),
                                              borderShape:
                                                  BorderRadius.circular(10.r),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 7.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        MovieInfoScreen(
                                          key: MovieDetail._movieInfoKey,
                                          movieData: widget.movieData,
                                          isViewOnly: widget.isViewOnly,
                                          isEditing: widget.isEditing, // هذا ما أضفناه
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 70.w,
                                              top: 30.h,
                                              bottom: 10.h),
                                          child: Text(
                                            "Story Line",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 6.sp,
                                            ),
                                          ),
                                        ),
                                        StoryLine(
                                          initialValue:
                                              widget.movieData['description'] ??
                                                  '',
                                          readOnly: widget.isViewOnly,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 30.h),
                                          child: ActorNames(
                                            movieData: widget.movieData,
                                            actors: actors,
                                            isViewOnly: widget.isViewOnly,
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        CrewNames(
                                          movieData: widget.movieData,
                                          key: CrewNames.crewKey,
                                          directorName: director,
                                          writerName: writer,
                                          producerName: producer,
                                          isViewOnly: widget.isViewOnly,
                                        ),
                                        SizedBox(height: 60.h),
                                        if (!widget.isViewOnly)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ButtonBuilder(
                                                text: widget.isEditing
                                                    ? 'Save'
                                                    : 'Add Movie',
                                                onTap: () async {
                                                  final isMovieInfoValid =
                                                      MovieDetail._movieInfoKey
                                                              .currentState
                                                              ?.validateFields() ??
                                                          false;
                                                  final isNamesValid =
                                                      ActorNames.validate();
                                                  final isStoryLineValid =
                                                      StoryLine.validate();
                                                  final isCrewValid = CrewNames
                                                          .crewKey
                                                          .currentState
                                                          ?.widget
                                                          .validate() ??
                                                      false;

                                                  if (isMovieInfoValid &&
                                                      isNamesValid &&
                                                      isStoryLineValid &&
                                                      isCrewValid &&
                                                      promoLinkError == null) {
                                                    if (widget.isEditing) {
                                                      await MovieCubit.get(
                                                              context)
                                                          .updateMovieInCinemaWithPreparedData(
                                                              context: context);
                                                      AppLogs.scussessLog(
                                                          "Finish uploading to cinema");
                                                      print(MovieCubit.get(
                                                              context)
                                                          .coverPhoto);
                                                      await MovieCubit.get(
                                                              context)
                                                          .updateMovieDocumentByName(
                                                              context: context);
                                                      AppLogs.scussessLog(
                                                          "Finish uploading to playing now");
                                                      await MovieCubit.get(
                                                              context)
                                                          .fetchUserMovies();
                                                      Navigator.pop(context);
                                                    } else {
                                                      await MovieCubit.get(
                                                              context)
                                                          .addMovieToCinema();
                                                      await MovieCubit.get(
                                                              context)
                                                          .uploadMovieToFireStore();
                                                      Navigator.pop(context);
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                            "Oops Something went wrong please try again",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    );
                                                  }
                                                },
                                                width: 40.w,
                                                height: 50.h,
                                                buttonColor:
                                                    const Color(0xFF560B76),
                                                borderShape:
                                                    BorderRadius.circular(10.r),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 7.sp,
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              ButtonBuilder(
                                                text: 'Cancel',
                                                onTap: () {
                                                  StoryLine.clearFields(
                                                      context);
                                                  Navigator.pop(context);
                                                },
                                                width: 40.w,
                                                height: 50.h,
                                                buttonColor:
                                                    const Color(0xFF560B76),
                                                borderShape:
                                                    BorderRadius.circular(10.r),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 7.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
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
              ),
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: LoadingIndicator(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
