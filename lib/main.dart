import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/provider/reminder_provider.dart';
import 'package:reminder_app/provider/theme.dart';

import 'screens/reminder_screen.dart';
import 'service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReminderProvider(),
      child: DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: AppThemes.Dark,
        builder: (context, themeData) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reminder App',
          theme: themeData,
          home: ReminderScreen(),
        ),
      ),
    );
  }
}
