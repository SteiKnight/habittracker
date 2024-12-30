/// given a habit list of completion
/// days is ht ehabit completed today
library;

import 'package:habittracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();

  return completedDays.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}

Map<DateTime, int> getHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};
  for (var habit in habits) {
    for (var date in habit.completedDays) {
      //normalize date to avoid type mismatch
      final normalDate = DateTime(date.year, date.month, date.day);

      //if date already exists, increment
      if (dataset.containsKey(normalDate)) {
        dataset[normalDate] = dataset[normalDate]! + 1;
      }
      //else initialize with a counter of 1
      else {
        dataset[normalDate] = 1;
      }
    }
  }
  return dataset;
}
