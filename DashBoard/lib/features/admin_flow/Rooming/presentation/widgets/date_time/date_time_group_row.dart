import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../movie_room/movie_select.dart';
import '../movie_room/room_Select.dart';
import 'Date_Time_Row_Wrapper.dart';
import 'Delete_Button.dart';

class DateTimeGroupRow extends StatelessWidget {
  final int startIndex;
  final List<Map<String, String>> dateTimePairs;
  final List<bool> dateErrors;
  final List<bool> timeErrors;
  final void Function(int index) onRemove;
  final VoidCallback onUpdate;

  const DateTimeGroupRow({
    super.key,
    required this.startIndex,
    required this.dateTimePairs,
    required this.dateErrors,
    required this.timeErrors,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final int endIndex = startIndex + 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: RoomDropdownWidget(
                  initialValue: dateTimePairs[startIndex]['room'],
                  onChanged: (value) {
                    dateTimePairs[startIndex]['room'] = value ?? '';
                    onUpdate();
                  },
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 2,
                child: MovieDropdownWidget(
                  initialValue: dateTimePairs[startIndex]['movie'],
                  onChanged: (value) {
                    dateTimePairs[startIndex]['movie'] = value ?? '';
                    onUpdate();
                  },
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 3,
                child: DateTimeRowWrapper(
                  index: startIndex,
                  dateTimePairs: dateTimePairs,
                  dateErrors: dateErrors,
                  timeErrors: timeErrors,
                  onUpdate: onUpdate,
                  label: 'Start',
                ),
              ),
              SizedBox(width: 8.w),
              if (endIndex < dateTimePairs.length)
                Expanded(
                  flex: 3,
                  child: DateTimeRowWrapper(
                    index: endIndex,
                    dateTimePairs: dateTimePairs,
                    dateErrors: dateErrors,
                    timeErrors: timeErrors,
                    onUpdate: onUpdate,
                    label: 'End',
                  ),
                )
              else
                const Spacer(),
            ],
          ),
          if (dateTimePairs.length > 2 && startIndex >= 2)
            DeleteButton(
              onPressed: () => onRemove(startIndex),
            ),
        ],
      ),
    );
  }
}
