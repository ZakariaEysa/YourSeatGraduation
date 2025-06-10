import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/chat_message_model.dart';

class ChatMessageItem extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.type == MessageType.user;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isRTL = locale == 'ar';

    return Padding(
      // padding: EdgeInsetsDirectional.only(
      //   start: isUser ? 50.w : 16.w,
      //   end: isUser ? 16.w : 50.w,
      //   top: 8.h,
      //   bottom: 8.h,
      // ),
      padding: EdgeInsetsDirectional.only(top: 12.h, start: 20.w, end: 20.w),

      child: Align(
        alignment: isUser
            ? (isRTL ? Alignment.centerLeft : Alignment.centerRight)
            : (isRTL ? Alignment.centerRight : Alignment.centerLeft),
        child: Container(
          constraints: BoxConstraints(maxWidth: 270.w),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: isUser ? Colors.purple[300] : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.message,
                style: TextStyle(
                  color: isUser ? Colors.white : const Color(0xFF27125B),
                  fontSize: 14.sp,
                ),
              ),
              if (message.recommendations != null &&
                  message.recommendations!.isNotEmpty)
                ..._buildRecommendations(
                    message.recommendations!, theme, isRTL),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRecommendations(
      List<MovieRecommendation> recommendations, ThemeData theme, bool isRTL) {
    return [
      SizedBox(height: 8.h),
      Divider(color: Colors.grey[300], thickness: 1),
      SizedBox(height: 8.h),
      Text(
        isRTL ? 'التوصيات:' : 'Recommendations:',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
          color: const Color(0xFF27125B),
        ),
      ),
      SizedBox(height: 4.h),
      ...recommendations.map((movie) => _buildMovieItem(movie, theme, isRTL)),
    ];
  }

  Widget _buildMovieItem(
      MovieRecommendation movie, ThemeData theme, bool isRTL) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment:
            isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: const Color(0xFF27125B),
            ),
          ),
          Text(
            isRTL
                ? '${movie.genre} • ${movie.releaseYear} • ${movie.imdbScore}/10'
                : '${movie.genre} • ${movie.releaseYear} • ${movie.imdbScore}/10',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
          ),
          Text(
            isRTL ? 'المخرج: ${movie.director}' : 'Director: ${movie.director}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
          ),
          Text(
            isRTL
                ? 'الممثلين: ${movie.cast.join(", ")}'
                : 'Cast: ${movie.cast.join(", ")}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
