import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComingMovies extends StatefulWidget {
  final String image;
  final String title;
  final String smallTitle;
  final String releaseDate;
  final bool isActive;

  const ComingMovies(
      {super.key,
      required this.image,
      required this.title,
      required this.smallTitle,
      required this.releaseDate,
      this.isActive = false});

  @override
  State<ComingMovies> createState() => _ComingMoviesState();
}

class _ComingMoviesState extends State<ComingMovies> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          widget.image,
          width: 170.w,
          height: 228.h,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          widget.title,
          style: theme.textTheme.bodyMedium!
              .copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/calendar.png",
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              widget.releaseDate,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontSize: 12.sp, color: const Color(0xFFDEDEDE)),
            ),
            SizedBox(
              width: 52.w,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isBookmarked = !_isBookmarked;
                });
              },
              child: Icon(
                Icons.bookmark_rounded,
                color: _isBookmarked
                    ? Colors.purple
                    : Colors.grey.withOpacity(0.40),
                size: 30.sp,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/video.png",
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(
              width: 7.w,
            ),
            Text(
              widget.smallTitle,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontSize: 12.sp, color: const Color(0xFFDEDEDE)),
            )
          ],
        )
      ],
    );
  }
}
