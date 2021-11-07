// Created by Muhamad Fauzi Ridwan on 24/08/21.

part of '_services.dart';

// class NotificationService {
//   NotificationService._() {
//     init();
//   }
//
//   FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
//   final BehaviorSubject<ReceivedNotification>
//       didReceivedLocalNotificationSubject =
//       BehaviorSubject<ReceivedNotification>();
//   InitializationSettings? initializedSettings;
//
//   Future<void> init() async {
//     Logger().i('Initializing Notification Plugin Service');
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     if (Platform.isIOS) {
//       _requestIOSPermission();
//     }
//     await initializePlatformSpecifics();
//   }
//
//   Future<void> initializePlatformSpecifics() async {
//     try {
//       const initializedSettingAndroid =
//           AndroidInitializationSettings('app_icon');
//       final initializedSettingIOS = IOSInitializationSettings(
//           onDidReceiveLocalNotification: (id, title, body, payload) async {
//         final recievedNotification = ReceivedNotification(
//             id: id, title: title!, body: body!, payload: payload!);
//         didReceivedLocalNotificationSubject.add(recievedNotification);
//       });
//       initializedSettings = InitializationSettings(
//           android: initializedSettingAndroid, iOS: initializedSettingIOS);
//       await flutterLocalNotificationsPlugin!.initialize(initializedSettings!,
//           onSelectNotification: (String? payload) async {
//         if (payload != null) {
//           debugPrint('notification payload: $payload');
//           await onNotificationClick(payload);
//         }
//       });
//     } catch (e) {
//       Logger().e(e.toString());
//     }
//   }
//
//   Future<void> onNotificationClick(dynamic payload) async {
//     if (payload != null) {
//       //todo decode payload
//       //then map notification by type
//     }
//   }
//
//   Future<void> showNotification(
//       int id,
//       String title,
//       String body,
//       String payload,
//       String types,
//       ) async {
//     Logger().i('Showing notification');
//     const androidChannelSpecifics = AndroidNotificationDetails(
//         'CHANNEL_ID', 'CHANNEL_NAME', 'CHANNEL_DESCRIPTION',
//         importance: Importance.max,
//         priority: Priority.high,
//         visibility: NotificationVisibility.public,
//         sound: RawResourceAndroidNotificationSound('notification'),
//         autoCancel: false,
//         timeoutAfter: 5000,
//         icon: 'app_icon',
//         enableLights: true,
//         styleInformation: DefaultStyleInformation(true, true));
//
//     const iosChannelSpecifics = IOSNotificationDetails();
//     const platformChannelSpecifics = NotificationDetails(
//         android: androidChannelSpecifics, iOS: iosChannelSpecifics);
//     final payloads = jsonEncode(<String, String>{
//       'type': payload,
//       'data': types,
//     });
//     await flutterLocalNotificationsPlugin!
//         .show(id, title, body, platformChannelSpecifics, payload: payloads);
//   }
//
//   void setOnNotificationClick(
//   Function(dynamic payload) onNotificationClick,
//   ) {
//     flutterLocalNotificationsPlugin!.initialize(initializedSettings!,
//         onSelectNotification: (String? payloadAndTypes) async {
//       final payloadAndTypesSlice = payloadAndTypes!.split(':');
//       onNotificationClick(payloadAndTypesSlice[1]);
//     });
//   }
//
//   void _requestIOSPermission() {
//     flutterLocalNotificationsPlugin!
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()!
//         .requestPermissions(sound: true);
//   }
//
//   void setListenerForLowerVersion(
//       Function(ReceivedNotification) onLowerVersionNotification) {
//     didReceivedLocalNotificationSubject.listen((receivedNotification) {
//       onLowerVersionNotification(receivedNotification);
//     });
//   }
// }
//
// NotificationService notificationPlugin = NotificationService._();
//
// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });
//
//   final int id;
//   final String title;
//   final String body;
//   final String payload;
// }
