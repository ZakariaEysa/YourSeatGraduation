import '../../../rooming_sechduling/presentation/widgets/schedule_item.dart';

class RoomingValidator {
  static String? validateScheduleItems(List<ScheduleItem> items) {
    for (int i = 0; i < items.length; i++) {
      final itemA = items[i];
      final startA = _parseDateTime(itemA.startDate, itemA.startTime);
      final endA = _parseDateTime(itemA.endDate, itemA.endTime);

      if (startA == null || endA == null) {
        return 'Invalid date/time format.';
      }

      if (!startA.isBefore(endA)) {
        return 'Start date/time must be before end date/time.';
      }

      // ✅ Check for overlapping schedules in the same room
      for (int j = i + 1; j < items.length; j++) {
        final itemB = items[j];
        if (itemA.room == itemB.room) {
          final startB = _parseDateTime(itemB.startDate, itemB.startTime);
          final endB = _parseDateTime(itemB.endDate, itemB.endTime);

          if (startB == null || endB == null) continue;

          final isOverlap = startA.isBefore(endB) && endA.isAfter(startB);
          if (isOverlap) {
            return 'Schedule conflict in ${itemA.room}: ${itemA.movie} overlaps with ${itemB.movie}.';
          }
        }
      }
    }
    return null;
  }

  static String? checkConflictWithExisting(
      List<ScheduleItem> existing, List<ScheduleItem> newItems) {
    for (var newItem in newItems) {
      final newStart = _parseDateTime(newItem.startDate, newItem.startTime);
      final newEnd = _parseDateTime(newItem.endDate, newItem.endTime);

      if (newStart == null || newEnd == null) continue;

      for (var existingItem in existing) {
        if (newItem.room == existingItem.room) {
          final existStart =
              _parseDateTime(existingItem.startDate, existingItem.startTime);
          final existEnd =
              _parseDateTime(existingItem.endDate, existingItem.endTime);

          if (existStart == null || existEnd == null) continue;

          final isOverlap =
              newStart.isBefore(existEnd) && newEnd.isAfter(existStart);
          if (isOverlap) {
            return 'Schedule conflict in ${newItem.room}: ${newItem.movie} overlaps with existing movie ${existingItem.movie}.';
          }
        }
      }
    }
    return null;
  }

  static DateTime? _parseDateTime(String date, String time) {
    try {
      final dateParts = date.contains('-') ? date.split('-') : date.split('/');
      int day, month, year;

      if (date.contains('-')) {
        year = int.parse(dateParts[0]);
        month = int.parse(dateParts[1]);
        day = int.parse(dateParts[2]);
      } else {
        day = int.parse(dateParts[0]);
        month = int.parse(dateParts[1]);
        year = int.parse(dateParts[2]);
      }

      final timeParts = time.trim().split(RegExp(r'[:\s]+'));
      int hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final meridian = timeParts.length == 3 ? timeParts[2].toUpperCase() : "";

      if (meridian == "PM" && hour < 12) {
        hour += 12;
      } else if (meridian == "AM" && hour == 12) {
        hour = 0;
      }

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      return null;
    }
  }
}
