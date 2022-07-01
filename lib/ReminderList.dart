import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelReminder.dart';
import 'package:healtho_app/ConstantColors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

import 'package:timezone/timezone.dart' as tz;

class ReminderList extends StatefulWidget {
  @override
  _ReminderList createState() => _ReminderList();
}

class _ReminderList extends State<ReminderList> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<String> countries = <String>[
    'Belgium',
    'France',
    'Italy',
    'Germany',
    'Spain',
    'Portugal'
  ];
  bool checkboxValueCity = true;
  List<String> allCities = ['Sun', 'Mon', 'Tue', "Wed", "Thu", "Fri", "Sat"];
  List<String> selectedCities = [];
  List<String> selectedCitiesTemp = [];
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      child: Scaffold(
        appBar: getThemeAppBar(S.of(context).reminder, () {
          onBackClick();
        }),
        body: Container(
          margin: EdgeInsets.all(5),
          child: FutureBuilder<List<ModelReminder>>(
            future: _databaseHelper.getAllReminderData(),
            builder: (context, snapshot) {
              return (snapshot.hasData)
                  ? ListView.builder(
                      primary: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print("inrec1==true");
                        ModelReminder modelReminder = snapshot.data![index];
                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.only(left: 7, right: 7),
                          width: double.infinity,
                          height: SizeConfig.safeBlockVertical! * 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteGray),
                          // height: double.infinity,
                          // width: SizeConfig.safeBlockHorizontal * 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: getSmallBoldText(
                                        S.of(context).workoutReminder,
                                        Colors.black54),
                                    flex: 1,
                                  ),
                                  Switch(
                                    value: modelReminder.ison == "1"
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      _databaseHelper.updateReminderOn(
                                          value, modelReminder.id!);
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: getSmallBoldText(
                                        modelReminder.time!, Colors.black54),
                                    flex: 1,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  getSmallBoldText(S.of(context).repeat + " - ",
                                      primaryColor),
                                  Expanded(
                                    child: Text(
                                      modelReminder.repeat!
                                          .replaceAll("[", "")
                                          .replaceAll("]", "")
                                          .replaceAll("\"", ""),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                          fontFamily: ConstantData.fontsFamily,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                    flex: 1,
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.delete,
                                      color: primaryColor,
                                    ),
                                    onTap: () {
                                      _databaseHelper.removeReminderById(
                                          modelReminder.id!);
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : getProgressDialog();
              // if (snapshot.hasData) {
              //   List<ModelReminder> remindersList = snapshot.data;
              // }
            },
          ),
          // ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _MyDialog(
                    cities: allCities,
                    selectedCities: selectedCities,
                    onSelectedCitiesListChanged: (cities) {
                      setState(() {
                        selectedCitiesTemp = cities;
                      });
                    },
                    onSelectedValue: (values) {
                      // showTimePicker()
                      showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      ).then((value) {
                        if (values.length > 0) {
                          String amPm = "PM";
                          if (value!.period == DayPeriod.am) {
                            amPm = "AM";
                          }
                          String time = (value.hourOfPeriod < 10 ? "0" : "") +
                              value.hourOfPeriod.toString() +
                              ":" +
                              (value.minute < 10 ? "0" : "") +
                              value.minute.toString() +
                              " " +
                              amPm;
                          String s = jsonEncode(values);
                          print("gteval===--$time==$s");
                          _databaseHelper
                              .addReminderData(time, s, "1")
                              .then((value1) {
                            selectedCities.forEach((element) {
                              print("getval--$value--$element"
                                  "");
                              _scheduleWeeklyMondayTenAMNotification(value1,
                                  int.parse(element), value.hour, value.minute);
                            });
                          });
                          checkReminderData();

                          setState(() {});
                        }

                        return value!;
                      });
                    },
                  );
                });
            // _showDialog();
          },
        ),
      ),
      onWillPop: () async {
        onBackClick();
        return false;
      },
    );
  }

  TZDateTime _nextInstanceOfMondayTenAM(int day, int hour, int minute) {
    TZDateTime scheduledDate = _nextInstanceOfTenAM(hour, minute);
    print("schedule===${scheduledDate.weekday}--${DateTime.monday}");
    while (scheduledDate.weekday != day) {
      print("schedule123===${scheduledDate.weekday}--${DateTime.monday}");
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  TZDateTime _nextInstanceOfTenAM(int orgRemindHour, int orgRemindMinute) {
    final TZDateTime now = tz.TZDateTime.now(tz.local);
    TZDateTime scheduledDate = TZDateTime(
        tz.local, now.year, now.month, now.day, orgRemindHour, orgRemindMinute);
    print("schedule===$scheduledDate--$now--${scheduledDate.isBefore(now)}");
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  Future<void> _scheduleWeeklyMondayTenAMNotification(
      int id, int day, int hour, int minute) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Brain Challenge',
        'Your are one step away to connect with GeeksforGeeks',
        // _nextInstanceOfTenAM(),
        _nextInstanceOfMondayTenAM(day, hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'com.example.flutter_maths_brain_challenge',
            'com.example.flutter_maths_brain_challenge channel',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,

        // matchDateTimeComponents: DateTimeComponents.time);
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }
}

void checkReminderData() {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<ModelReminder> list;
  DateTime currentTime = DateTime.now();
  DateFormat formatter = DateFormat('hh:mm a');
  DateFormat formatterDays = DateFormat('EEE');
  // DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(currentTime);
  final String formattedDay = formatterDays.format(currentTime);
  print("Hello, world");
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
  _databaseHelper.getAllOnReminderData(formatted).then((value) {
    // print("remindersize===${value}==$formatted");

    list = value;
    for (int i = 0; i < list.length; i++) {
      ModelReminder modelRemind = list[i];
      var getData = jsonDecode(modelRemind.repeat!);
      List<String> jsonDecodeTags = new List<String>.from(getData);
      print("chkremind===--${jsonDecodeTags.toString()}==$formattedDay");
      if (jsonDecodeTags.contains(formattedDay)) {
        _showNotificationWithDefaultSound(flip);
      }
      // List<String> tags = ['tagA', 'tagB', 'tagC'];
      // String jsonTags = jsonEncode(tags);
      // var getData=jsonDecode(jsonTags);
      // List<String> jsonDecodeTags =new List<String>.from(getData);
      // // List<String> jsonDecodeTags = jsonDecode(jsonTags) as List<String>;
      // print("tags=$jsonTags==$tags==$jsonDecodeTags");

    }
  });

  print("eminder_notify==true$formatted===$formattedDay");

  // // print("Hello, world! [$now] isolate=${isolateId} function='$printHello'");
  // // print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

Future _showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  // androidPlatformChannelSpecifics,
  // iOSPlatformChannelSpecifics
  // );
  await flip.show(0, "Reminder", 'Daily Reminder', platformChannelSpecifics,
      payload: 'Default_Sound');
}

class _MyDialog extends StatefulWidget {
  _MyDialog(
      {this.cities,
      this.selectedCities,
      this.onSelectedCitiesListChanged,
      this.onSelectedValue});

  final List<String>? cities;
  final List<String>? selectedCities;
  final ValueChanged<List<String>>? onSelectedCitiesListChanged;
  final ValueChanged<List<String>>? onSelectedValue;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<String> _tempSelectedCities = [];

  @override
  void initState() {
    _tempSelectedCities = widget.selectedCities!;
    // _tempSelectedCities=widget.cities;
    super.initState();
  }

  @override
  Widget build(BuildContext contextz) {
    return Dialog(
        child: Container(
      height: 500,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(7),
                child: Text(
                  "select days",
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.cities!.length,
                itemBuilder: (BuildContext context, int index) {
                  final cityName = widget.cities![index];
                  return Container(
                    child: CheckboxListTile(
                        title: Text(cityName),
                        value: _tempSelectedCities.contains(cityName),
                        onChanged: (bool? value) {
                          if (value!) {
                            if (!_tempSelectedCities.contains(cityName)) {
                              setState(() {
                                _tempSelectedCities.add(cityName);
                              });
                            }
                          } else {
                            if (_tempSelectedCities.contains(cityName)) {
                              setState(() {
                                _tempSelectedCities.removeWhere(
                                    (String city) => city == cityName);
                              });
                            }
                          }
                          widget.onSelectedCitiesListChanged!(
                              _tempSelectedCities);
                        }),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: getSmallBoldText("OK", Theme.of(context).primaryColor),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onSelectedValue!(_tempSelectedCities);
                },
              ),
            ],
          )
        ],
      ),
    ));
  }
}

// class MyDialogContent extends StatefulWidget {
//   MyDialogContent({
//     Key key,
//     this.countries,
//   }) : super(key: key);
//
//   final List<String> countries;
//
//   @override
//   _MyDialogContentState createState() => new _MyDialogContentState();
// }
//
// class _MyDialogContentState extends State<MyDialogContent> {
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   _getContent() {
//     if (widget.countries.length == 0) {
//       return new Container();
//     }
//
//     return new Column(
//         children: new List<RadioListTile<int>>.generate(widget.countries.length,
//             (int index) {
//       return new RadioListTile<int>(
//         value: index,
//         groupValue: _selectedIndex,
//         title: new Text(widget.countries[index]),
//         onChanged: (int value) {
//           setState(() {
//             _selectedIndex = value;
//           });
//         },
//       );
//     }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _getContent();
//   }
// }
