import 'package:flutter/cupertino.dart';
import 'package:habittracker/models/app_settings.dart';
import 'package:habittracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  /// S E T U P

  //Initialize database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  //save first date of app startup (heatmap)'
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstOpenDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  //get first date of app startup (heatmap)
  Future<DateTime?> getFirstOpenDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstOpenDate;
  }

  /**
   * CRUD Functions
   */

  //list of habits
  List<Habit> currentHabits = [];

  //create habit
  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;

    //save to db
    await isar.writeTxn(
      () => isar.habits.put(newHabit),
    );

    //fetch from db
    readHabits();
  }

  //read habits from db
  Future<void> readHabits() async {
    //fetch all habits from db
    List<Habit> newHabits = await isar.habits.where().findAll();

    //give to current habits
    currentHabits.clear();
    currentHabits.addAll(newHabits);

    //update ui
    notifyListeners();
  }

  //update habit on and off
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    //find the specific Habit
    final habit = await isar.habits.get(id);
    final today = DateTime.now();
    //update completion status
    if (habit != null) {
      await isar.writeTxn(() async {
        //if habit is completed we add the current date to the database
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          final today = DateTime.now();
          habit.completedDays.add(DateTime(
            today.year,
            today.month,
            today.day,
          ));
        } else if (!isCompleted &&
            habit.completedDays.contains(DateTime.now())) {
          habit.completedDays.removeWhere((date) =>
              date.year == today.year &&
              date.month == today.year &&
              date.day == today.year);
        }
        //save the updated habits
        await isar.habits.put(habit);
      });
    }
    //re-read from db
    readHabits();
  }

  //update habit name
  Future<void> updateHabitName(int id, String name) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      habit.name = name;
      await isar.writeTxn(() async {
        await isar.habits.put(habit);
      });
    }

    readHabits();
  }

  //delete habit
  Future<void> deleteHabit(int id) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(
        () => isar.habits.delete(id),
      );
    }

    readHabits();
  }
}
