import 'package:flutter/material.dart';
import 'date_time_row.dart';

class DateTimeRowWrapper extends StatelessWidget {
  final int index;
  final List<Map<String, String>> dateTimePairs;
  final List<bool> dateErrors;
  final List<bool> timeErrors;
  final VoidCallback onUpdate;
  final String label;

  const DateTimeRowWrapper({
    super.key,
    required this.index,
    required this.dateTimePairs,
    required this.dateErrors,
    required this.timeErrors,
    required this.onUpdate,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return DateTimeRow(
      index: index,
      dateTimePairs: dateTimePairs,
      dateErrors: dateErrors,
      timeErrors: timeErrors,
      onUpdate: onUpdate,
      datePlaceholder: '$label Date',
      timePlaceholder: '$label Time',
    );
  }
}
