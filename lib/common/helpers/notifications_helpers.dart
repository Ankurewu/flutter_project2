import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'package:to_do_riverpod/common/models/task_model.dart';
import 'package:to_do_riverpod/features/todo/pages/view_notis.dart';
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class NotificationsHelper{
  final WidgetRef ref;

  NotificationsHelper({required this.ref});



  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=
  FlutterLocalNotificationsPlugin();  //

  String? selectedNotificationPayload;

  final BehaviorSubject<String?> selectNotificationSubject=
  BehaviorSubject<String?>();

  initilizeNotification()async{
    _configureSelectNotificationSUbject();
    await _configureLocalTimeZone();

    final DarwinInitializationSettings initializationSettingsIOS=
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      
      final AndroidInitializationSettings androidInitializationSettings=
      const AndroidInitializationSettings("calendar");

      final InitializationSettings  initializationSettings=
      InitializationSettings(
      android: androidInitializationSettings,
      iOS:initializationSettingsIOS,
      ) ;

      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:(data)async{
        debugPrint('notification payload:${data.payload!}');
      selectNotificationSubject.add(data.payload);
      });

  }


void requestIOSPermissions(){
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void>_configureLocalTimeZone()async{
  tz.initializeTimeZones();
  const String timeZoneName= 'Asia/Dhaka';  //use the specfic time zone identifier
   tz.setLocalLocation(tz.getLocation(timeZoneName)
   );

}

Future onDidReceiveLocalNotification(
  int id,
  String? title,
  String? body,
  String? payload)async{

    showDialog(
      context: ref.context, 
      builder: (BuildContext context) =>CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
            ),
            CupertinoDialogAction(
              child: const Text('View'),
              onPressed: () {
                 Navigator.pop(context);
              },
              ),
        ],
      ),
      );
    }

  scheduleNotification(int days,
     int hours,
     int minutes,
     int seconds,
     Task task) async{
        await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id?? 0,
      task.title,
      task.desc,
      tz.TZDateTime.now(tz.local)
      .add(Duration(days: days,
      hours: hours,
      minutes: minutes,
      seconds:seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id', 'your channel name',
        )),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
         UILocalNotificationDateInterpretation.absoluteTime,
         matchDateTimeComponents: DateTimeComponents.time,
         payload: 
         "${task.title}|${task.desc}|${task.date}|${task.startTime}|${task.endTime}",
     );
     
       void _configureSelectNotificationSubject() {}
  }

void _configureSelectNotificationSUbject(){
  selectNotificationSubject.stream.listen((String? payload)async{
    var title= payload!.split('|')[0];
    var body= payload.split('|')[1];

    showDialog(
      context: ref.context,
       builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body,textAlign: TextAlign.justify,maxLines: 4,),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () { Navigator.pop(context);},
            child: const Text('Close'),

          ),
          CupertinoDialogAction(
            child: const Text('View'),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsPage(payload: payload),)
                );
            },
            )
        ],
       ),
    );
  });
}

}

