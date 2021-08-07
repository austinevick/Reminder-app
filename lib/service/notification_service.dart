import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String>();

  static Future<void> init() async {
    final settings = InitializationSettings(
        android: AndroidInitializationSettings('ic_notification_icon'));
    await _notifications.initialize(settings,
        onSelectNotification: onSelectNotification);
    tz.initializeTimeZones();
    final locationName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }
  }

  static Future onSelectNotification(String payload) async {
    onNotifications.add(payload);
  }

  static final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          '1', 'Scheduled', 'Scheduled notification',
          enableLights: true, importance: Importance.high));

  static Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime,
      {String payload}) async {
    await _notifications.zonedSchedule(id, title, body,
        tz.TZDateTime.from(scheduledTime, tz.local), notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
