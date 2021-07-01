import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification extends StatefulWidget {
  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  late FlutterLocalNotificationsPlugin flutterNotification;
  String value = "Daily";

  var items = ["Daily", "2x/Day", "3x/Day", "4x/Day", '48 seconds'];

  Time time = Time();

  //TimePicker...

  TimeOfDay _time = TimeOfDay.now();
  Future<void> selectTime(BuildContext context) async {
    _time = (await showTimePicker(context: context, initialTime: _time))!;
  }

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
      var sT = DateTime.now();
      var a = DateTime(sT.year, sT.month, sT.day, _time.hour, _time.minute);
      flutterNotification.schedule(
          1,
          'Notification Set',
          'Notification set to: ${a.hour}:${a.minute}',
          a,
          generalNotificationDetails);
    }

    //3x...
    else if (value == '3x/Day') {
      print(value);
      var sT = DateTime.now();
      var a = DateTime(sT.year, sT.month, sT.day, _time.hour, _time.minute);
      flutterNotification.schedule(
          2,
          'Notification Set',
          'Notification set to: ${a.hour}:${a.minute}',
          a,
          generalNotificationDetails);
    }

    //4x...
    else if (value == '4x/Day') {
      print(value);
      var sT = DateTime.now();
      var a = DateTime(sT.year, sT.month, sT.day, _time.hour, _time.minute);
      flutterNotification.schedule(
          3,
          'Notification Set',
          'Notification set to: ${a.hour}:${a.minute}',
          a,
          generalNotificationDetails);
    }

    //48 Hours...
    else if (value == '48 Hours') {
      print(value);
      var sT = DateTime.now();
      var a = DateTime(sT.year, sT.month, sT.day, _time.hour, _time.minute);
      flutterNotification.schedule(
          4,
          'Notification Set',
          'Notification set to: ${a.hour}:${a.minute}',
          a,
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
            SizedBox(height: 15),
            TextButton(
              child: Text('Set Time'),
              onPressed: () => selectTime(context),
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
