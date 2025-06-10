import '../../../../rooming_sechduling/presentation/widgets/schedule_item.dart';

class DateTimeFieldsController {
  List<Map<String, String>> dateTimePairs = [
    {'date': '', 'time': '', 'room': '', 'movie': ''},
    {'date': '', 'time': '', 'room': '', 'movie': ''},
  ];

  List<Map<String, String>> lastSavedDateTimePairs = [];
  List<bool> dateErrors = [false, false];
  List<bool> timeErrors = [false, false];

  void addDateTimePair() {
    for (int i = 0; i < 2; i++) {
      dateTimePairs.add({'date': '', 'time': '', 'room': '', 'movie': ''});
      dateErrors.add(false);
      timeErrors.add(false);
    }
  }

  void removeDateTimeGroup(int index) {
    if (dateTimePairs.length <= 2) return;
    dateTimePairs.removeAt(index);
    dateErrors.removeAt(index);
    timeErrors.removeAt(index);
    if (index < dateTimePairs.length) {
      dateTimePairs.removeAt(index);
      dateErrors.removeAt(index);
      timeErrors.removeAt(index);
    }
  }

  List<ScheduleItem> getAllSchedules() {
    List<ScheduleItem> items = [];
    Set<String> seenEntries = {};

    for (int i = 0; i < dateTimePairs.length; i += 2) {
      final room = dateTimePairs[i]['room'] ?? '';
      final movie = dateTimePairs[i]['movie'] ?? '';
      final startDate = dateTimePairs[i]['date'] ?? '';
      final startTime = dateTimePairs[i]['time'] ?? '';
      final endDate = (i + 1 < dateTimePairs.length)
          ? dateTimePairs[i + 1]['date'] ?? ''
          : '';
      final endTime = (i + 1 < dateTimePairs.length)
          ? dateTimePairs[i + 1]['time'] ?? ''
          : '';

      if (room.isNotEmpty &&
          movie.isNotEmpty &&
          startDate.isNotEmpty &&
          startTime.isNotEmpty &&
          endDate.isNotEmpty &&
          endTime.isNotEmpty) {
        final key = '$room|$movie|$startDate|$startTime|$endDate|$endTime';
        if (!seenEntries.contains(key)) {
          seenEntries.add(key);
          items.add(ScheduleItem(
            room: room,
            movie: movie,
            startDate: startDate,
            startTime: startTime,
            endDate: endDate,
            endTime: endTime,
          ));
        }
      }
    }
    return items;
  }
}
