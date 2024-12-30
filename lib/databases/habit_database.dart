import 'package:habittracker/models/app_settings.dart';
import 'package:habittracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase {
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
  //create habit
  //read habit
  //update habit on and off
  //update habit name
  //delete habit
}
