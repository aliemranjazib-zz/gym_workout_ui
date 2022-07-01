import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:healtho_app/FirstPage.dart';

import 'package:healtho_app/HomeScreen.dart';
import 'package:healtho_app/IntroPage.dart';
import 'package:healtho_app/model/ModelReminder.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:healtho_app/utils/PrefData.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/timezone.dart';

import 'ConstantData.dart';
import 'SignUpPage.dart';
import 'Widgets.dart';
import 'db/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'generated/l10n.dart';

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

String selectedNotificationPayload = "";

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await _configureLocalTimeZone();

  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');

  // final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //         requestAlertPermission: false,
  //         requestBadgePermission: false,
  //         requestSoundPermission: false,
  //         onDidReceiveLocalNotification:
  //             (int? id, String? title, String? body, String? payload) async {
  //           didReceiveLocalNotificationSubject.add(ReceivedNotification(
  //               id: id!, title: title!, body: body!, payload: payload!));
  //         });
  // const MacOSInitializationSettings initializationSettingsMacOS =
  //     MacOSInitializationSettings(
  //         requestAlertPermission: false,
  //         requestBadgePermission: false,
  //         requestSoundPermission: false);
  // final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //     macOS: initializationSettingsMacOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String? payload) async {
  //   print("selectnoti==terue");
  //   if (payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   // await Navigator.push(
  //   context,
  //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  // );

  //   selectedNotificationPayload = payload!;
  //   selectNotificationSubject.add(payload);
  // });

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );

  // await AndroidAlarmManager.periodic(
  //     const Duration(seconds: 60), helloAlarmID, printHello);
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  // var locations = tz.timeZoneDatabase.locations;

  // tz.initializeTimeZones();
  // final String timeZoneName = await platform.invokeMethod<String>('getTimeZoneName');
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();

  // final timeZone = TimeZone();
  // String timeZoneName = await timeZone.getTimeZoneName();
  print("getname===$timeZoneName");
  try {
    Location getlocal =
        tz.getLocation(timeZoneName.replaceAll("Calcutta", "Kolkata"));
    tz.setLocalLocation(getlocal);
  } catch (e) {
    print(e);
    Location getlocal = tz.getLocation(ConstantData.defTimeZoneName);
    tz.setLocalLocation(getlocal);
    print("getnamerr=${e.toString()}");
  }
  // tz.setLocalLocation(tz.getLocation(timeZoneName));
  // tz.setLocalLocation(TimeZone.getDefault().id);
}

void printHello() {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<ModelReminder> list;
  DateTime currentTime = DateTime.now();
  DateFormat formatter = DateFormat('hh:mm a');
  DateFormat formatterDays = DateFormat('EEE');
  final String formatted = formatter.format(currentTime);
  final String formattedDay = formatterDays.format(currentTime);
  print("Hello, worlds");
  FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

  // app_icon needs to be a added as a drawable
  // resource to the Android head project.
  var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  var ios = new IOSInitializationSettings();

  // initialise settings for both Android and iOS device.
  var settings = new InitializationSettings(android: android, iOS: ios);
  flip.initialize(settings);
  // _databaseHelper
  // .getMyWorkoutProgressPercentage(2)
  // .then((value) => {print("remindersize1===${list.length}")});
  // _databaseHelper.getAllOnReminderData(formatted).then((value) {
  //   print("remindersize===$formatted");

  //   list = value;
  // for (int i = 0; i < list.length; i++) {
  //   ModelReminder modelRemind = list[i];
  //   var getData = jsonDecode(modelRemind.repeat!);
  //   List<String> jsonDecodeTags = new List<String>.from(getData);
  //   print("chkremind===--${jsonDecodeTags.toString()}==$formattedDay");
  //   if (jsonDecodeTags.contains(formattedDay)) {
  //     _showNotificationWithDefaultSound(flip, true);
  //   }
  // List<String> tags = ['tagA', 'tagB', 'tagC'];
  // String jsonTags = jsonEncode(tags);
  // var getData=jsonDecode(jsonTags);
  // List<String> jsonDecodeTags =new List<String>.from(getData);
  // // List<String> jsonDecodeTags = jsonDecode(jsonTags) as List<String>;
  // print("tags=$jsonTags==$tags==$jsonDecodeTags");

  // }
  // });
  // _showNotificationWithDefaultSound(flip,false);

  // print("eminder_notify==true$formatted===$formattedDay");

  // // print("Hello, world! [$now] isolate=${isolateId} function='$printHello'");
  // // print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

// Future _showNotificationWithDefaultSound(flip, bool val) async {
//   // Show a notification after every 15 minute with the first
//   // appearance happening a minute after invoking the method
//   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//       'your channel id', 'your channel name',
//       importance: Importance.max, priority: Priority.high);
//   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

//   // initialise channel platform for both Android and iOS device.
//   var platformChannelSpecifics = new NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);
//   // androidPlatformChannelSpecifics,
//   // iOSPlatformChannelSpecifics
//   // );
//   if (val) {
//     await flip.show(0, "Reminder", 'Daily Reminder', platformChannelSpecifics,
//         payload: 'Default_Sound');
//   } else {
//     await flip.show(
//         0,
//         'GeeksforGeeks',
//         'Your are one step away to connect with GeeksforGeeks',
//         platformChannelSpecifics,
//         payload: 'Default_Sound');
//   }
// }

class MyApp extends StatelessWidget {
  // void _requestPermissions() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           MacOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  // }

  // void _configureDidReceiveLocalNotificationSubject(BuildContext context) {
  //   didReceiveLocalNotificationSubject.stream
  //       .listen((ReceivedNotification receivedNotification) async {
  //     print("notificationreceive==true");
  //     await showDialog(
  //       context: context,
  //       builder: (BuildContext context) => CupertinoAlertDialog(
  //         title: Text(receivedNotification.title),
  //         content: Text(receivedNotification.body),
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             isDefaultAction: true,
  //             onPressed: () async {
  //               Navigator.of(context, rootNavigator: true).pop();
  //               // await Navigator.push(
  //               //   context,
  //               //   MaterialPageRoute<void>(
  //               //     builder: (BuildContext context) =>
  //               //         SecondPage(receivedNotification.payload),
  //               //   ),
  //               // );
  //             },
  //             child: const Text('Ok'),
  //           )
  //         ],
  //       ),
  //     );
  //   });
  // }

  // void _configureSelectNotificationSubject() {
  //   selectNotificationSubject.stream.listen((String payload) async {
  //     print("selectnoti==true");
  //     // await Navigator.pushNamed(context, '/secondPage');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(primaryColor);

    // _requestPermissions();
    // _configureDidReceiveLocalNotificationSubject(context);
    // _configureSelectNotificationSubject();
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English US
        const Locale('en', 'GB'), // English UK
        // ... other locales the app supports
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: SplashScreen(),
      // home: MyHomePage(),
      // home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  bool _isSignIn = false;
  bool _isIntro = false;
  bool _isFirstTime = false;

  @override
  void initState() {
    super.initState();
    signInValue();

    Timer(Duration(seconds: 3), () {
      print("isIntro=----$_isIntro---$_isSignIn");
      if (_isIntro) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IntroPage()));
      } else if (!_isSignIn) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpPage(),
            ));
      } else {
        if (_isFirstTime) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(0),
              ));
        }
      }
    });
  }

  void signInValue() async {
    _isSignIn = await PrefData.getIsSignIn();
    _isIntro = await PrefData.getIsIntro();
    _isFirstTime = await PrefData.getIsFirstTime();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: new ExactAssetImage(
            ConstantData.assetImagesPath + "splash_bg.png",
          ),
          fit: BoxFit.fill,
        ),
      ),

      child: Stack(
        children: [
          Center(
            child: ConstantWidget.getCustomTextFont(
                "Fitness Workout",
                Colors.white,
                1,
                TextAlign.start,
                FontWeight.bold,
                ConstantWidget.getScreenPercentSize(context, 5),
                meriendaOneFont),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(ConstantData.assetImagesPath + "splash_icon.png",
                height: ConstantWidget.getScreenPercentSize(context, 25)),
          )
        ],
      ),
      // child: Image.asset(ConstantData.assetHomeImagesPath+"logo.png",
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width)
    );
  }
}
