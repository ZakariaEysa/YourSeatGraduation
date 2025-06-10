// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yourseatgraduationproject/utils/app_logs.dart';
//
// import '../../../../../widgets/validators/Validators.dart';
// import '../../../moives/data/movies_cubit/movies_cubit.dart';
// import 'NewDropdownField.dart';
// import 'logo .dart';
// import 'movie_text_field_label.dart';
//
// class MovieInfoScreen extends StatefulWidget {
//   final Map<String, dynamic> movieData;
//   final bool isViewOnly;
//
//   const MovieInfoScreen({
//     Key? key,
//     required this.movieData,
//     this.isViewOnly = false,
//   }) : super(key: key);
//
//   @override
//   MovieInfoScreenState createState() => MovieInfoScreenState();
// }
//
// class MovieInfoScreenState extends State<MovieInfoScreen> {
//   static const Color errorColor = Color(0xFFE53935);
//
//
//   // Dropdown values
//   String? selectedGenre;
//   String? selectedLanguage;
//   String? selectedCensorship;
//   String? selectedStatus;
//
//   // Validation errors
//   String? _movieNameError;
//   String? _durationError;
//   String? _movieGenreError;
//   String? _languageError;
//   String? _censorshipError;
//   String? _statusError;
//   String? _promoLinkError;
//   String? _versionError;
//
//
//   // File handling
//   PlatformFile? pickedCover ;
//   String promoUrl = '';
//   String releaseDate = '';
//
//
//   // Options
//   final List<String> genreOptions = [
//     'Action', 'Comedy', 'Drama', 'Horror', 'Adventure', 'Romance', 'Sci-Fi',
//     'Fantasy', 'Thriller', 'Animation', 'Documentary', 'Crime', 'Mystery',
//     'Biography', 'Musical'
//   ];
//
//   final List<String> languageOptions = [
//     'English', 'Arabic', 'French', 'Spanish', 'German', 'Hindi',
//     'Japanese', 'Korean', 'Chinese', 'Turkish'
//   ];
//
//   final List<String> censorshipOptions = [
//     'tv-ma', 'tv-14', 'R', 'TV-PG', 'PG-13', 'PG', 'TV-Y7', 'TV-G', 'G', 'NC-17',
//   ];
//
//   final List<String> statusOptions = ['Playing now', 'Coming soon'];
//
//   @override
//   void initState() {
//     super.initState();
//     final movie = widget.movieData;
//     var cubit = MovieCubit.get(context);
//     selectedLanguage = movie["language"] ;
//     print(movie["category"]);
//     selectedGenre = movie["category"];
//     print(movie["age_rating"]);
//     selectedCensorship = movie["age_rating"];
//     releaseDate = movie['release_date'].toString();
//     String cleanDate = releaseDate.substring(1, releaseDate.length - 1);
//     print(cleanDate);
//
//     // Initialize from movie data
//     MovieCubit.get(context).movieNameController.text = movie['name'] ?? '';
//     MovieCubit.get(context).durationController.text = movie['duration'] ?? '';
//     MovieCubit.get(context).versionController.text = cleanDate ?? '';
//     promoUrl = movie['trailer'] ?? '';
//     MovieCubit.get(context).promoLinkController.text = promoUrl;
//
//     selectedGenre = genreOptions.contains(movie['category']) ? movie['category'] : null;
//     selectedLanguage = languageOptions.contains(movie['language']) ? movie['language'] : null;
//     selectedStatus = statusOptions.contains(movie['status']) ? movie['status'] : null;
//     selectedCensorship = censorshipOptions.contains(movie['age_rating']) ? movie['age_rating'] : null;
//     //selectedCensorship = censorshipOptions.contains(movie['age_rating']) ? movie['age_rating'] : null;
//   }
//
//   void handlePick(PlatformFile? file) {
//     setState(() => pickedCover = file);
//   }
//
//   void handleDelete() {
//     setState(() => pickedCover = null);
//   }
//
//   bool validateFields() {
//     setState(() {
//       _movieNameError = Validators.validateRequired(
//         MovieCubit.get(context).movieNameController.text,
//         'Movie name',
//       );
//       _durationError =   Validators.validateDurationFormat(MovieCubit.get(context).durationController.text);
//       _movieGenreError = Validators.validateRequired(selectedGenre, 'Movie genre');
//       _languageError = Validators.validateRequired(selectedLanguage, 'Language');
//       _censorshipError = Validators.validateRequired(selectedCensorship, 'Censorship');
//       _statusError = Validators.validateRequired(selectedStatus, 'Status');
//       _promoLinkError = Validators.validateYouTubeLink(MovieCubit.get(context).promoLinkController.text);
//       _versionError = Validators.validateVersionNumber(MovieCubit.get(context).versionController.text);
//     });
//
//     return _movieNameError == null &&
//         _durationError == null &&
//         _movieGenreError == null &&
//         _languageError == null &&
//         _censorshipError == null &&
//         _statusError == null &&
//         _promoLinkError == null &&
//         _versionError == null;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 22.w, right: 22.w),
//       child: Container(
//         width: 200.w,
//         height: 450.h,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         padding: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
//         child: IgnorePointer(
//           ignoring: widget.isViewOnly,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: MovieTextFieldLabel(
//                                   label: "Movie Name",
//                                   hintText: "Avengers",
//                                   controller: MovieCubit.get(context).movieNameController,
//                                   errorText: _movieNameError,
//                                   errorColor: errorColor,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _movieNameError =
//                                           Validators.validateRequired(
//                                             value,
//                                             'Movie name',
//                                           );
//                                     });
//                                   },
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Expanded(
//                                 child: MovieTextFieldLabel(
//                                   label: "Duration",
//                                   hintText: "120m",
//                                   controller: MovieCubit.get(context).durationController,
//                                   errorText: _durationError,
//                                   errorColor: errorColor,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _durationError = Validators.validateDurationFormat(value);
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 15.h),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: MovieTextFieldLabel(
//                                   label: "Promo Link",
//                                   hintText: "https://youtube/VIDEO_ID",
//                                   controller: MovieCubit.get(context).promoLinkController,
//                                   errorText: _promoLinkError,
//                                   errorColor: errorColor,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _promoLinkError = Validators.validateYouTubeLink(value);
//                                     });
//                                   },
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Expanded(
//                                 child: MovieTextFieldLabel(
//                                   label: "Version Number",
//                                   hintText:  "YYYY-MM-DD",
//                                   controller: MovieCubit.get(context).versionController,
//                                   errorText: _versionError,
//                                   errorColor: errorColor,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _versionError = Validators.validateVersionNumber(value);
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 15.h),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Language",
//                                         style: TextStyle(
//                                             fontSize: 6.sp,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black)),
//                                     SizedBox(height: 4.h),
//                                     NewDropdownField(
//                                       value: selectedLanguage,
//                                       items: languageOptions,
//                                       hintText: 'English',
//                                       errorText: _languageError,
//                                       errorColor: errorColor,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           selectedLanguage = value;
//                                            print(selectedLanguage);
//                                           MovieCubit.get(context).selectedLanguage = selectedLanguage;
//                                           _languageError = Validators.validateRequired(value, 'Language');
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Censorship",
//                                         style: TextStyle(
//                                             fontSize: 6.sp,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black)),
//                                     SizedBox(height: 4.h),
//                                     NewDropdownField(
//                                       value: selectedCensorship,
//                                       items: censorshipOptions,
//                                       hintText: 'TV-Y7',
//                                       errorText: _censorshipError,
//                                       errorColor: errorColor,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           selectedCensorship = value;
//                                           MovieCubit.get(context).selectedCensorship = selectedCensorship;
//                                           _censorshipError = Validators.validateRequired(value, 'Censorship');
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 15.h),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Status",
//                                         style: TextStyle(
//                                             fontSize: 6.sp,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black)),
//                                     SizedBox(height: 4.h),
//                                     NewDropdownField(
//                                       value: selectedStatus,
//                                       items: statusOptions,
//                                       hintText: 'Coming soon',
//                                       errorText: _statusError,
//                                       errorColor: errorColor,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           selectedStatus = value ;
//                                           MovieCubit.get(context).selectedStatus = selectedStatus;
//                                           _statusError = Validators.validateRequired(value, 'Status');
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Movie Genre",
//                                         style: TextStyle(
//                                             fontSize: 6.sp,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black)),
//                                     SizedBox(height: 4.h),
//                                     NewDropdownField(
//                                       value: selectedGenre,
//                                       items: genreOptions,
//                                       hintText: 'Action, adventure, sci-fi',
//                                       errorText: _movieGenreError,
//                                       errorColor: errorColor,
//                                       onChanged: (value) {
//                                         setState(() {
//                                            selectedGenre = value ;
//                                           MovieCubit.get(context).selectedGenre = selectedGenre;
//                                           _movieGenreError = Validators.validateRequired(value, 'Movie genre');
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(child:  logo(
//                       pickedCover: pickedCover,
//                       onPick: (file) {
//                         setState(() {
//                           pickedCover = file;
//                         });
//                       },
//                       onDelete: () {
//                         setState(() {
//                           pickedCover = null;
//                         });
//                       },
//                       errorColor: Colors.red,
//                       isViewOnly: false,
//                     ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//


import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/logo%20.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';

import '../../../../../widgets/validators/Validators.dart';
import '../../../moives/data/movies_cubit/movies_cubit.dart';
import 'NewDropdownField.dart';
import 'movie_text_field_label.dart';

class MovieInfoScreen extends StatefulWidget {
  final Map<String, dynamic> movieData;
  final bool isViewOnly;
  final bool isEditing;
  const MovieInfoScreen({
    Key? key,
    required this.movieData,
    this.isViewOnly = false,
    this.isEditing = false,
  }) : super(key: key);

  @override
  MovieInfoScreenState createState() => MovieInfoScreenState();
}

class MovieInfoScreenState extends State<MovieInfoScreen> {
  static const Color errorColor = Color(0xFFE53935);

  String? selectedGenre;
  String? selectedLanguage;
  String? selectedCensorship;
  String? selectedStatus;

  String? _movieNameError;
  String? _durationError;
  String? _movieGenreError;
  String? _languageError;
  String? _censorshipError;
  String? _statusError;
  String? _promoLinkError;
  String? _versionError;

  PlatformFile? pickedCover;
  String promoUrl = '';
  String releaseDate = '';

  final List<String> genreOptions = [
    'Action', 'Comedy', 'Drama', 'Horror', 'Adventure', 'Romance', 'Sci-Fi',
    'Fantasy', 'Thriller', 'Animation', 'Documentary', 'Crime', 'Mystery',
    'Biography', 'Musical'
  ];

  final List<String> languageOptions = [
    'English', 'Arabic', 'French', 'Spanish', 'German', 'Hindi',
    'Japanese', 'Korean', 'Chinese', 'Turkish'
  ];

  final List<String> censorshipOptions = [
    'tv-ma', 'tv-14', 'R', 'TV-PG', 'PG-13', 'PG', 'TV-Y7', 'TV-G', 'G', 'NC-17',
  ];

  final List<String> statusOptions = ['Playing now', 'Coming soon'];

  @override
  void initState() {
    super.initState();
    final movie = widget.movieData;

    selectedLanguage = movie["language"]??"";
    selectedGenre = movie["category"]??"";
    selectedCensorship = movie["age_rating"]??"";
    selectedStatus = movie["status"]??"";
    releaseDate = movie['release_date'] ?? ''.toString();


    MovieCubit.get(context).movieNameController.text = movie['name'] ?? '';
    MovieCubit.get(context).durationController.text = movie['duration'] ?? '';
    MovieCubit.get(context).versionController.text = releaseDate;
    promoUrl = movie['trailer'] ?? '';
    MovieCubit.get(context).promoLinkController.text = promoUrl;

    selectedGenre = genreOptions.contains(movie['category']) ? movie['category'] : genreOptions[0];
    selectedLanguage = languageOptions.contains(movie['language']) ? movie['language'] : languageOptions[0];
    selectedStatus = statusOptions.contains(movie['status']) ? movie['status'] : statusOptions[0];
    selectedCensorship = censorshipOptions.contains(movie['age_rating']) ? movie['age_rating'] : censorshipOptions[0];


    MovieCubit.get(context).selectedLanguage = selectedLanguage ?? languageOptions[0];
    MovieCubit.get(context).selectedGenre = selectedGenre ?? genreOptions[0];
    MovieCubit.get(context).selectedCensorship = selectedCensorship ?? censorshipOptions[0];
    MovieCubit.get(context).selectedStatus = selectedStatus ?? statusOptions[0];
    final base64Image = widget.movieData['poster_image'];
    MovieCubit.get(context).coverPhoto = pickedCover;
    if (base64Image != null && base64Image is String && base64Image.isNotEmpty) {
      try {
        Uint8List bytes = base64Decode(base64Image);
        pickedCover = PlatformFile(
          name: 'image_from_base64.jpg',
          bytes: bytes,
          path: '',
          size: bytes.length,
        );
      } catch (e) {
        print('Error decoding base64: \$e');
      }
    }
  }

  void handlePick(PlatformFile? file) {
    setState(() => pickedCover = file);
  }

  void handleDelete() {
    setState(() => pickedCover = null);
  }


  bool validateFields() {
    setState(() {
      _movieNameError = Validators.validateRequired(MovieCubit.get(context).movieNameController.text, 'Movie name');
      _durationError = Validators.validateDurationFormat(MovieCubit.get(context).durationController.text);
      _movieGenreError = Validators.validateRequired(selectedGenre, 'Movie genre');
      _languageError = Validators.validateRequired(selectedLanguage, 'Language');
      _censorshipError = Validators.validateRequired(selectedCensorship, 'Censorship');
      _statusError = Validators.validateRequired(selectedStatus, 'Status');
      _promoLinkError = Validators.validateYouTubeLink(MovieCubit.get(context).promoLinkController.text);
      _versionError = Validators.validateVersionNumber(MovieCubit.get(context).versionController.text);
    });

    return _movieNameError == null &&
        _durationError == null &&
        _movieGenreError == null &&
        _languageError == null &&
        _censorshipError == null &&
        _statusError == null &&
        _promoLinkError == null &&
        _versionError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22.w, right: 22.w),
      child: Container(
        width: 200.w,
        height: 450.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
        child: IgnorePointer(
          ignoring: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MovieTextFieldLabel(
                                  label: "Movie Name",
                                  hintText: "Avengers",
                                  controller: MovieCubit.get(context).movieNameController,
                                  errorText: _movieNameError,
                                  errorColor: errorColor,
                                  readOnly: widget.isViewOnly || widget.isEditing, // جعل الحقل للقراءة فقط عند التحرير

                                  onChanged: (value) {
                                    setState(() {
                                      _movieNameError = Validators.validateRequired(value, 'Movie name');
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: MovieTextFieldLabel(
                                  label: "Duration",
                                  hintText: "120m",
                                  controller: MovieCubit.get(context).durationController,
                                  errorText: _durationError,
                                  errorColor: errorColor,
                                  readOnly: widget.isViewOnly,
                                  onChanged: (value) {
                                    setState(() {
                                      _durationError = Validators.validateDurationFormat(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Expanded(
                                child: MovieTextFieldLabel(
                                  label: "Promo Link",
                                  hintText: "https://youtube/VIDEO_ID",
                                  controller: MovieCubit.get(context).promoLinkController,
                                  errorText: _promoLinkError,
                                  errorColor: errorColor,
                                  readOnly: widget.isViewOnly,

                                  onChanged: (value) {
                                    setState(() {
                                      _promoLinkError = Validators.validateYouTubeLink(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: MovieTextFieldLabel(
                                  label: "Version Number",
                                  hintText: "YYYY-MM-DD",
                                  controller: MovieCubit.get(context).versionController,
                                  errorText: _versionError,
                                  errorColor: errorColor,
                                  readOnly: widget.isViewOnly,

                                  onChanged: (value) {
                                    setState(() {
                                      _versionError = Validators.validateVersionNumber(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Language",
                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                                    SizedBox(height: 4.h),
                                    NewDropdownField(
                                      value: selectedLanguage,
                                      items: languageOptions,
                                      hintText: 'English',
                                      errorText: _languageError,
                                      errorColor: errorColor,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedLanguage = value;
                                          _languageError = Validators.validateRequired(value, 'Language');
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Censorship",
                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                                    SizedBox(height: 4.h),
                                    NewDropdownField(
                                      value: selectedCensorship??"",
                                      items: censorshipOptions,
                                      hintText: 'TV-Y7',
                                      errorText: _censorshipError,
                                      errorColor: errorColor,
                                      readOnly: widget.isViewOnly,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCensorship = value;
                                          MovieCubit.get(context).selectedCensorship = value;
                                          _censorshipError = Validators.validateRequired(value, 'Censorship');
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Status",
                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                                    SizedBox(height: 4.h),
                                    NewDropdownField(
                                      value: selectedStatus??"",
                                      items: statusOptions,
                                      hintText: 'Playing now',
                                      readOnly: widget.isViewOnly || widget.isEditing, // جعل الحقل للقراءة فقط عند التحرير

                                      errorText: _statusError,
                                      errorColor: errorColor,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedStatus = value;
                                          MovieCubit.get(context).selectedStatus = selectedStatus;
                                          _statusError = Validators.validateRequired(value, 'Status');
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Genre",
                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                                    SizedBox(height: 4.h),
                                    NewDropdownField(
                                      value: selectedGenre??"",
                                      items: genreOptions,
                                      hintText: 'Action',
                                      errorText: _movieGenreError,
                                      errorColor: errorColor,
                                      readOnly: widget.isViewOnly,

                                      onChanged: (value) {
                                        setState(() {
                                          selectedGenre = value;
                                          MovieCubit.get(context).selectedGenre = selectedGenre;
                                          _movieGenreError = Validators.validateRequired(value, 'Movie genre');
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      children: [
                        Logo(
                          imageBytes: pickedCover?.bytes,
                          pickedCover: pickedCover,
                          onPick: (PlatformFile? file) {
                            handlePick(file);
                            setState(() {
                              pickedCover = file;
                            });
                          },
                          onDelete: () {
                            handleDelete();
                            setState(() {
                              pickedCover = null;
                            });
                          },
                          errorColor: errorColor,
                            readOnly: widget.isViewOnly,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


