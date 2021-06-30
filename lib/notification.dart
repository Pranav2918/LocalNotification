import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification extends StatefulWidget {
  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  late FlutterLocalNotificationsPlugin flutterNotification;
  String value = "Daily";

  var items = ["Daily", "2x/Day", "3x/Day", "4x/Day", '48 Hours'];

  var time = Time(20, 00, 00);

  @override
  void initState() {
    super.initState();
    var androidInitialize =
        AndroidInitializationSettings('app_icon'); //Notification_Icon
    var iosInitialize = IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterNotification = FlutterLocalNotificationsPlugin();
    flutterNotification.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  //Show_notification...
  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "channelId", "From Pranav", "New Notification",
        styleInformation: BigPictureStyleInformation(
            DrawableResourceAndroidBitmap('app_icon'),
            largeIcon: DrawableResourceAndroidBitmap('app_icon')),
        importance: Importance.max);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    flutterNotification.show(
        0, "Main Notification", "Completing Tasks", generalNotificationDetails);
    //Daily...
    if (value == 'Daily') {
      print(value);
      flutterNotification.showDailyAtTime(1, 'Daily Notification',
          'This is Daily Notification', time, generalNotificationDetails);
    }
    //2x...
    else if (value == '2x/Day') {
      print(value);
      var scheduleTime = DateTime.now().add(Duration(hours: 12));
      flutterNotification.schedule(
          1,
          'Every 12 hours',
          'This is every 12 hours notification',
          scheduleTime,
          generalNotificationDetails);
    }
    //3x...
    else if (value == '3x/Day') {
      print(value);
      var scheduleTime = DateTime.now().add(Duration(hours: 6));
      flutterNotification.schedule(
          2,
          'Every 6 hours',
          'This is every 6 hours notification',
          scheduleTime,
          generalNotificationDetails);
    }
    //4x...
    else if (value == '4x/Day') {
      print(value);
      var scheduleTime = DateTime.now().add(Duration(hours: 4));
      flutterNotification.schedule(
          3,
          'Every 4 hours',
          'This is every 4 hours notification',
          scheduleTime,
          generalNotificationDetails);
    }
    //48 Hours...
    else if (value == '48 Hours') {
      print(value);
      var scheduleTime = DateTime.now().add(Duration(hours: 48));
      flutterNotification.schedule(
          4,
          'Every 48 Hours',
          'This is every 48 Hours notification',
          scheduleTime,
          generalNotificationDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Local Notification'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            DropdownButton(
              items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              value: value,
              onChanged: (String? newValue) {
                setState(() {
                  value = newValue!;
                });
              },
            ),
            TextButton(
              child: Text('Set notification'),
              onPressed: _showNotification,
            )
          ],
        )));
  }

  Future notificationSelected(dynamic payload) async {}
}
