import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/database/reminder_db.dart';
import 'package:reminder_app/model/reminder.dart';
import 'package:reminder_app/service/notification_service.dart';

class ReminderProvider extends ChangeNotifier {
  List<Reminder> reminders = [];
  bool isActive = true;

  Future<List<Reminder>> getReminders() async {
    Future<List<Reminder>> list = ReminderDatabaseHelper.getReminder();
    await list.then((reminders) {
      this.reminders = reminders;
      notifyListeners();
    });
    return list;
  }

  void reminderStateChange(bool isActive) {
    notifyListeners();
  }

  void createReminder(Reminder reminder) async {
    if (reminder.title.isEmpty && reminder.content.isEmpty) return;
    await ReminderDatabaseHelper.saveReminder(reminder);
  }

  TextStyle getTextStyle(BuildContext context, Reminder reminder,
     [ double fontSize, FontWeight fontWeight]) {
    if (Theme.of(context).brightness == Brightness.dark)
      return TextStyle(
          color: reminder.isActive ? Colors.white : Colors.grey,
          fontSize: fontSize,
          fontWeight: fontWeight);
    else
      return TextStyle(
          color: reminder.isActive ? Colors.black : Colors.grey,
          fontSize: fontSize,
          fontWeight: fontWeight);
  }

  updateReminder(Reminder reminder) async {
    await ReminderDatabaseHelper.updateReminder(reminder);
    getReminders();
    notifyListeners();
  }

  void deleteReminder(int id) {
    ReminderDatabaseHelper.deleteReminder(id);
    getReminders();
    notifyListeners();
  }
}
