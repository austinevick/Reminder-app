import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reminder_app/model/reminder.dart';
import 'package:reminder_app/provider/reminder_provider.dart';
import 'package:reminder_app/screens/new_reminder_screen.dart';
import 'package:reminder_app/service/notification_service.dart';

import 'confirmation_widget.dart';

class ReminderList extends StatefulWidget {
  final Reminder reminder;
  final ReminderProvider provider;

  const ReminderList({Key key, this.reminder, this.provider}) : super(key: key);

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {
    return Entry.scale(
      delay: Duration(milliseconds: 300),
      duration: Duration(milliseconds: 500),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewReminderScreen(
            reminder: widget.reminder,
          ),
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.alarm,
                                color: widget.reminder.isActive
                                    ? Color(0x0fffd6a02)
                                    : Colors.grey),
                            SizedBox(width: 8),
                            Text(widget.reminder.scheduledTime.substring(0, 5),
                                style: widget.provider.getTextStyle(context,
                                    widget.reminder, 30, FontWeight.w600)),
                            Text(
                              widget.reminder.scheduledTime.substring(5),
                              style: widget.provider.getTextStyle(context,
                                  widget.reminder, 18, FontWeight.w800),
                            ),
                            Spacer(),
                            Switch(
                                activeColor: Color(0x0fffd6a02),
                                value: widget.reminder.isActive,
                                onChanged: (value) {
                                  setState(() {
                                    widget.reminder.isActive =
                                        !widget.reminder.isActive;
                                    if (widget.reminder.isActive) {
                                      LocalNotification.scheduleNotification(
                                          0,
                                          'Reminder',
                                          widget.reminder.title,
                                          widget.reminder.scheduledDate);
                                    } else {
                                      LocalNotification.cancelNotification(0);
                                    }
                                    widget.provider
                                        .updateReminder(widget.reminder);
                                    print(widget.reminder);
                                  });
                                }),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.label_important_outline,
                              color: widget.reminder.isActive
                                  ? Color(0x0fffd6a02)
                                  : Colors.grey,
                            ),
                            SizedBox(width: 6),
                            Text(widget.reminder.title,
                                style: widget.provider
                                    .getTextStyle(context, widget.reminder)),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  ConfirmationBottomSheet.buildBottomSheet(
                                      context, () {
                                    Navigator.of(context).pop();
                                    widget.provider
                                        .deleteReminder(widget.reminder.id);
                                    Fluttertoast.showToast(
                                        msg: 'Reminder deleted');
                                  }, 'Delete Reminder',
                                      'This reminder will be deleted');
                                },
                                icon: Icon(Icons.delete_outline_outlined,
                                    color: widget.reminder.isActive &&
                                            Theme.of(context).brightness ==
                                                Brightness.dark
                                        ? Colors.white
                                        : widget.reminder.isActive &&
                                                Theme.of(context).brightness ==
                                                    Brightness.light
                                            ? Colors.black
                                            : Colors.grey,
                                    size: 28))
                          ]),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

//  Container(
//                         width: 10,
//                         height: 105,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               bottomLeft: Radius.circular(10),
//                             ),
//                             color:
//                                 Color(int.parse(reminder.category, radix: 16))),
//                       ),
