import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:notify/notification_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
class LocalNotifictionServiece {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static ontap(NotificationResponse notificationResponse) {

    Get.to(()=>NotificationScreen(payload: notificationResponse.payload,));
       print("you are in man");
  }
  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: ontap,
      onDidReceiveNotificationResponse: ontap,
    );
  }

  //   basic notification
 static void showBasicNotification() async {
    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails(
      "id 0",
      "basic",
          sound: RawResourceAndroidNotificationSound("sound"),
          importance: Importance.max,
          priority: Priority.max,
    ));
    await flutterLocalNotificationsPlugin.show(
        0, "the basic noty",
        payload:"the payload show",
        "basic noty", details);
  }


  static void repeatnotify(
      {required String repeat, required String title,
        required String note, required String date,
        required String start,
        required String end,
        required int iscompleted,
        required int remind,
        required int color,
        required int id,
      })async{
    // 'None', 'Daily', 'Weekly', 'Monthly'];
    RepeatInterval repeated=RepeatInterval.everyMinute;
    switch(repeat){
      case "Daily":
        {
          repeated=RepeatInterval.daily;
          break;
        }
      case "Weekly":
        {
          repeated=RepeatInterval.weekly;
          break;
        }
      case "Hourly":
        {
          repeated=RepeatInterval.hourly;
          break;
        }
      default:
    }
    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails(
          "id 0",
          "repeat",
          sound: RawResourceAndroidNotificationSound("sound"),
          importance: Importance.max,
          priority: Priority.max,
        )
    );
     await flutterLocalNotificationsPlugin.periodicallyShow(
      id,

      "Your Repeat For",
      title,

      repeated,
         details ,
      payload: "$title|$date|$note|$start|$end|$repeat|$remind|$iscompleted|$color",
       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
    );
  }

  static void showschaduleNotification() async {

    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails(
          "id 0",
          "basic",
          sound: RawResourceAndroidNotificationSound("sound"),
          importance: Importance.max,
          priority: Priority.max,
        ));

    // String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation("Africa/Cairo"));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "scaduale 1800",
      "1800 s",
      payload: "the payload Schedule",
      // tz.TZDateTime(tz.local,2024,6,5,4,26,50),
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 1800)),
      details,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<String> showschadule_mody_Notification(
      {
        required String repeat,
        required String start,
        required String end,
        required int iscompleted,
        required int color,
        required int id,
        required String title,
        required int reminder,
        required String note,
        required int year,
        required String date,
        required int month,
        required int day,
        required int hour,
        required int minute
      }) async {
    NotificationDetails details = const NotificationDetails(

        android: AndroidNotificationDetails(
          "id 4",
          "moody_schedule",
          sound: RawResourceAndroidNotificationSound("sound"),
          importance: Importance.max,
          priority: Priority.max,
        ));
    int hourstep=0;
    String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.initializeTimeZones();

    if(timeZoneName=="Africa/Cairo"){
      hourstep=2;
    }else{
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    }
      try{
        var notificationResponseType;
      await flutterLocalNotificationsPlugin.zonedSchedule(
        androidScheduleMode: AndroidScheduleMode.exact,

        id,
        "Your schedule for",
        title,
        payload: "$title|$date|$note|$start|$end|$repeat|$reminder|$iscompleted|$color",
        tz.TZDateTime(tz.local, year, month, day, hour, minute).subtract(Duration(hours:hourstep,minutes: reminder)),
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      return "succeed";
    }catch (err){
      print(err);
      return "fail";
    }
  }

  }

