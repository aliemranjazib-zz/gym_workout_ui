import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/model/ModelChallengeExerciseData.dart';
import 'package:healtho_app/model/ModelChallengeMainCat.dart';
import 'package:healtho_app/model/ModelEquipment.dart';
import 'package:healtho_app/model/ModelExerciseCategory.dart';
import 'package:healtho_app/model/ModelExerciseDetail.dart';
import 'package:healtho_app/model/ModelMyPlanExercise.dart';
import 'package:healtho_app/model/ModelPlanCategory.dart';
import 'package:healtho_app/model/ModelPlanExerciseData.dart';
import 'package:healtho_app/model/ModelPlanExerciseTime.dart';
import 'package:healtho_app/model/ModelPlanSubCategory.dart';
import 'package:healtho_app/model/ModelReminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'healtho_db.db';
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }

    return _database!;
  }

  _initDatabase() async {
    var databasepath = await getDatabasesPath();
    String path = join(databasepath, _databaseName);

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }

      ByteData data = await rootBundle.load(join("assets", _databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    return await openDatabase(path, version: _databaseVersion, readOnly: false);
  }

  // Future<int> insert(Mode lMainCat mainCat) async {
  //   // Future<int> insert(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   print("insertdata==${mainCat.cat_img}");
  //   var map = new HashMap<String, dynamic>();
  //   // map['id']=modelMainCat.id;
  //   map['cat_img'] = mainCat.cat_img;
  //   map['cat_name'] = mainCat.cat_name;
  //
  //   return await db.insert(table_main_cat, map, nullColumnHack: 'id');
  //   // return await db.insert(table_main_cat, mainCat.toMap(),nullColumnHack: 'id');
  // }

  Future<int> getProgressPercentage(int catId, int subCatid) async {
    Database database = await instance.database;
    var results = await database.query("plan_exercise_data",
        where: "cat_id=? AND sub_cat_id=?", whereArgs: [catId, subCatid]);
    int totalExercise = results.length;
    var results2 = await database.query("plan_complete_data",
        where: "cat_id=? AND sub_cat_id=?", whereArgs: [catId, subCatid]);
    int completeExercise = results2.length;
    print("progress==$results==$results2");
    double percent = ((completeExercise * 100) / totalExercise);
    return percent.toInt();
  }

  Future<int> getMyWorkoutProgressPercentage(int catId) async {
    Database database = await instance.database;
    var results = await database.query("tbl_my_plan_exercise",
        where: "my_plan_id=?", whereArgs: [catId]);
    int totalExercise = results.length;
    var results2 = await database.query("complete_my_plan_data",
        where: "my_plan_id=?", whereArgs: [catId]);
    int completeExercise = results2.length;
    print("progress==$results==$results2");
    double percent = ((completeExercise * 100) / totalExercise);
    if (percent > 0) {
      try {
        int val = percent.toInt();
        return val;
      } catch (e) {
        print(e);
        return 0;
      }
    } else {
      return 0;
    }
  }

  Future<int> getChallengeProgressPercentage(int catId) async {
    Database database = await instance.database;
    var results = await database.query("challege_exercise_data",
        where: "challenge_cat_id=?", whereArgs: [catId]);
    int totalExercise = results.length;
    var results2 = await database.query("complete_challenge_data",
        where: "challenge_id=?", whereArgs: [catId]);
    int completeExercise = results2.length;
    print("progress==$results==$results2");
    double percent = ((completeExercise * 100) / totalExercise);
    return percent.toInt();
  }

  Future<int> getWorkingDays(int catId, int subCatid) async {
    Database database = await instance.database;
    var res = await database.rawQuery(
        "SELECT DISTINCT day FROM plan_exercise_data WHERE cat_id=$catId AND sub_cat_id=$subCatid");
    return res.length;
  }

  Future<int> getChallengesWorkingDays(int challengeId) async {
    Database database = await instance.database;
    var res = await database.rawQuery(
        "SELECT DISTINCT day FROM challege_exercise_data WHERE challenge_cat_id=$challengeId");
    return res.length;
  }

  Future<int> removeAllMyExerciseCompleted(
      int week, int day, int planId) async {
    Database database = await instance.database;
    return database.delete("complete_my_plan_data",
        where: "week=? AND day=? AND my_plan_id=?",
        whereArgs: [week, day, planId]);
  }

  Future<int> addCompleteMyPlanExercise(
      int week, int day, int exerciseId, int planId) async {
    Database database = await instance.database;
    var map = new HashMap<String, dynamic>();
    var res = await database.query("complete_my_plan_data",
        where: "week=? AND day=? AND my_exercise_id=? AND my_plan_id=?",
        whereArgs: [week, day, exerciseId, planId]);
    if (res.isEmpty) {
      map['week'] = week;
      map['day'] = day;
      map['my_exercise_id'] = exerciseId;
      map['my_plan_id'] = planId;
      return await database.insert('"complete_my_plan_data"', map,
          nullColumnHack: 'id');
    } else {
      return await database.delete("complete_my_plan_data",
          where: "week=? AND day=? AND my_exercise_id=? AND my_plan_id=?",
          whereArgs: [week, day, exerciseId, planId]);
    }
  }

  Future<int> isMyExerciseCompleted(
      int week, int day, int exerciseId, int planId) async {
    Database database = await instance.database;
    var res = await database.query("complete_my_plan_data",
        where: "week=? AND day=? AND my_exercise_id=? AND my_plan_id=?",
        whereArgs: [week, day, exerciseId, planId]);
    return res.length;
  }

  Future<int> addCompleteData(
      int planExerciseId, int catId, int subCatId, int week, int day) async {
    Database database = await instance.database;
    var map = new HashMap<String, dynamic>();
    var res = await database.query("plan_complete_data",
        where: "plan_exercise_id=? AND no_week=?",
        whereArgs: [planExerciseId, week]);
    if (res.isEmpty) {
      map['plan_exercise_id'] = planExerciseId;
      map['no_day'] = day;
      map['no_week'] = week;
      map['sub_cat_id'] = subCatId;
      map['cat_id'] = catId;
      return await database.insert('"plan_complete_data"', map,
          nullColumnHack: 'id');
    } else {
      return await database.delete("plan_complete_data",
          where: "plan_exercise_id=? AND no_week=?",
          whereArgs: [planExerciseId, week]);
    }
  }

  Future<int> removeMyPlan(int id) async {
    Database database = await instance.database;
    return await database
        .delete("tbl_add_my_plan", where: "id=?", whereArgs: [id]);
  }

  Future<int> addMyPlan(String name, String desc, int planCatId, int week,
      String color, int isCopy) async {
    Database database = await instance.database;
    var maps = new HashMap<String, dynamic>();
    maps['is_copy'] = isCopy;
    maps['color'] = color;
    maps['no_week'] = week;
    maps['plan_cat_id'] = planCatId;
    maps['description'] = desc;
    maps['name'] = name;

    return await database.insert("tbl_add_my_plan", maps, nullColumnHack: 'id');
  }

  Future<int> addCompleteChallengeData(
      int week, int day, int challengeId) async {
    Database database = await instance.database;
    var map = new HashMap<String, dynamic>();

    var res = await database.query("complete_challenge_data",
        where: "challenge_id=? AND week=? AND day=?",
        whereArgs: [challengeId, week, day]);
    if (res.isEmpty) {
      // map['plan_exercise_id'] = planExerciseId;
      // map['no_day'] = day;
      // map['no_week'] = week;
      // map['sub_cat_id'] = subCatId;
      // map['cat_id'] = catId;
      map['challenge_id'] = challengeId;
      map['week'] = week;
      map['day'] = day;
      print("challengedata==$week==$day==$challengeId");

      return await database.insert('"complete_challenge_data"', map,
          nullColumnHack: 'id');
    } else {
      print("challengedata11==$week==$day==$challengeId");

      return await database.delete("complete_challenge_data",
          where: "challenge_id=? AND week=? AND day=?",
          whereArgs: [challengeId, week, day]);
    }
  }

  Future<int> resetChallengePlanData(int catId, int week) async {
    Database database = await instance.database;
    return await database.delete("complete_challenge_data",
        where: "challenge_id=? AND week=?", whereArgs: [catId, week]);
  }

  Future<int> resetPlanData(int catId, int subCatId, int week, int day) async {
    print("remove==$catId-$subCatId-$week-$day");
    Database database = await instance.database;
    return await database.delete("plan_complete_data",
        where: "cat_id=? AND sub_cat_id=? AND no_week=? AND no_day=?",
        whereArgs: [catId, subCatId, week, day]);
  }

  // Future<int> updateStory(ModelSubCategory mainCat) async {
  //   // Future<int> insert(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   var map = new HashMap<String, dynamic>();
  //   print("imgsave==${mainCat.img}");
  //   map['img'] = mainCat.img;
  //   map['title'] = mainCat.title;
  //   map['story'] = mainCat.story;
  //   map['main_cat_id'] = mainCat.main_cat_id;
  //   map['mark_read'] = mainCat.mark_read;
  //   map['fav'] = mainCat.fav;
  //
  //
  //   return await db.update(table_sub_cat, map, where:  'id = ?',whereArgs: [mainCat.id]);
  //   // return await db.insert(table_main_cat, mainCat.toMap(),nullColumnHack: 'id');
  // }
  //
  // Future<int> insertSubCat(String title, String story, String img) async {
  //   // Future<int> insert(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   var map = new HashMap<String, dynamic>();
  //   map['img'] = img;
  //   map['title'] = title;
  //   map['story'] = story;
  //   map['main_cat_id'] = ConstantDatas.YOUR_STORY_ID;
  //   map['mark_read'] = 0;
  //   map['fav'] = 0;
  //
  //   return await db.insert(table_sub_cat, map, nullColumnHack: 'id');
  //   // return await db.insert(table_main_cat, mainCat.toMap(),nullColumnHack: 'id');
  // }
  //
  // Future<List<ModelExerciseCategory>> getAllExercise(
  //     BuildContext context) async {
  //   Database database = await instance.database;
  //   // var results = await database.query("SELECT * FROM $table_main_cat");
  //   var results = await database.query("tbl_exercise_cat");
  //   List<ModelExerciseCategory> lists = results.isNotEmpty ? results.map((e) =>
  //       ModelExerciseCategory.fromMap(results, context)).toList();
  //   return lists;
  // }

  Future<List<ModelAddMyPlan>> getAllMyPlans() async {
    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database.query("tbl_add_my_plan");
    List<ModelAddMyPlan>? list = results.isNotEmpty
        ? results.map((c) => ModelAddMyPlan.fromMap(c)).toList()
        : null;
    if (list == null) {
      list = [];
    }
    return list;
  }

  Future<ModelAddMyPlan> getCustomPlanById(int planId) async {
    Database database = await instance.database;

    var res = await database
        .query("tbl_add_my_plan", where: "id=?", whereArgs: [planId]);
    ModelAddMyPlan? product =
        res.isNotEmpty ? ModelAddMyPlan.fromMap(res.first) : null;
    return product!;
  }

  // Future<List<ModelPlanExerciseTime>> getPlanExerciseTime(
  //     int week, int planId) async {
  //   Database database = await instance.database;
  //   print("daysdata==$week==$planId");
  //
  //   var results = await database.query("plan_exercise_time_data",
  //       where: "week_no=? AND plan_exercise_id=?", whereArgs: [week, planId]);
  //   print("returnres==$results");
  //   List<ModelPlanExerciseTime> list = results.isNotEmpty
  //       ? results.map((c) => ModelPlanExerciseTime.fromMap(c)).toList()
  //       : null;
  //   return list;
  //   // ModelPlanExerciseTime product = res.isNotEmpty ? ModelPlanExerciseTime.fromMap(res.first) : null;
  //   // return product;
  // }
  Future<ModelPlanExerciseTime> getPlanExerciseTime(
      int week, int planId) async {
    Database database = await instance.database;
    print("daysdata==$week==$planId");

    var res = await database.query("plan_exercise_time_data",
        where: "week_no=? AND plan_exercise_id=?", whereArgs: [week, planId]);
    ModelPlanExerciseTime? product =
        res.isNotEmpty ? ModelPlanExerciseTime.fromMap(res.first) : null;
    return product!;
  }

  Future<List<ModelReminder>> getAllOnReminderData(String time) async {
    Database database = await instance.database;
    // print("daysdata==$week==$planId");

    // var results = await database.query("tbl_reminder");
    var results = await database.query("tbl_reminder",
        where: "time=? AND ison=?", whereArgs: [time, "1"]);
    List<ModelReminder>? list = results.isNotEmpty
        ? results.map((c) => ModelReminder.fromMap(c)).toList()
        : null;
    return list!;
  }

  Future<int> removeReminderById(int myPlanId) async {
    Database database = await instance.database;
    return database
        .delete("tbl_reminder", where: "id=?", whereArgs: [myPlanId]);
  }

  Future<int> addReminderData(String time, String repeat, String ison) async {
    Database database = await instance.database;
    var map = new HashMap<String, dynamic>();
    map['time'] = time;
    map['repeat'] = repeat;
    map['ison'] = ison;
    return await database.insert("tbl_reminder", map, nullColumnHack: 'id');
    //
    // var getRes = await database.query("tbl_my_plan_exercise",
    //     where: "my_plan_id=? AND week=? AND day=? AND exercise_id=?",
    //     whereArgs: [myPlanId, week, day, 0]);
    // return getRes.length;
  }

  Future<int> updateReminderOn(bool isOn, int id) async {
    Database database = await instance.database;
    var maps = new HashMap<String, dynamic>();
    String on = "0";
    if (isOn) {
      on = "1";
    }
    maps['ison'] = on;
    return database
        .update("tbl_reminder", maps, where: "id=?", whereArgs: [id]);
  }

  Future<List<ModelReminder>> getAllReminderData() async {
    Database database = await instance.database;
    // print("daysdata==$week==$planId");

    var results = await database.query("tbl_reminder");
    // var results = await database.query("tbl_reminder",
    //     where: "time=?", whereArgs: [time]);
    List<ModelReminder>? list = results.isNotEmpty
        ? results.map((c) => ModelReminder.fromMap(c)).toList()
        : null;
    return list!;
  }

  Future<List<ModelPlanExerciseData>> getAllPlanExerciseData(
      int catid, int subcat, int day) async {
    Database database = await instance.database;
    print("gteweekdata2=$catid==$subcat==$day");

    var results = await database.query("plan_exercise_data",
        where: "cat_id=? AND sub_cat_id=? AND day=?",
        whereArgs: [catid, subcat, day]);
    // var results = await database.rawQuery(
    //     "SELECT * FROM tbl_my_plan_exercise WHERE my_plan_id=$myPlanId AND week=$weeks AND day=$day");
    List<ModelPlanExerciseData>? list = results.isNotEmpty
        ? results.map((c) => ModelPlanExerciseData.fromMap(c)).toList()
        : null;
    return list!;
  }

  Future<List<ModelPlanExerciseData>> getAllExerciseData(int day) async {
    Database database = await instance.database;

    var results = await database.query("plan_exercise_data",
        where: "day=?", limit: 10, whereArgs: [day]);
    // var results = await database.rawQuery(
    //     "SELECT * FROM tbl_my_plan_exercise WHERE my_plan_id=$myPlanId AND week=$weeks AND day=$day");
    List<ModelPlanExerciseData>? list = results.isNotEmpty
        ? results.map((c) => ModelPlanExerciseData.fromMap(c)).toList()
        : null;
    return list!;
  }

  Future<List<ModelMyPlanExercise>> getMyPlanExerciseByDay(
      int planId, int week, int day) async {
    Database database = await instance.database;
    var results = await database.query("tbl_my_plan_exercise",
        where: "my_plan_id=? AND week=? AND day=?",
        whereArgs: [planId, week, day]);
    List<ModelMyPlanExercise>? list = results.isNotEmpty
        ? results.map((e) => ModelMyPlanExercise.fromMap(e)).toList()
        : null;

    // if(list == null){
    //   list=[];
    // }
    return list!;
  }

  Future<List<int>> getAllExercise(int planId, int week) async {
    Database database = await instance.database;
    var results = await database.query("tbl_my_plan_exercise",
        where: "my_plan_id=? AND week=?", whereArgs: [planId, week]);
    // List<ModelMyPlanExercise>? list = results.isNotEmpty
    //     ? results.map((e) => ModelMyPlanExercise.fromMap(e)).toList()
    //     : null;

    List<int> list =
        List<int>.from(results.map((i) => i["day"]).toList()).toList();

    if (results.isNotEmpty && list.length > 0) {
      List<int> result = LinkedHashSet<int>.from(list).toList();

      return result;
    } else {
      return [];
    }

    // return list;
  }

  Future<ModelChallengeExerciseData> getAllChallengesExerciseData(
      int challenge, int week, int day) async {
    Database database = await instance.database;
    var results = await database.query("challege_exercise_data",
        where: "challenge_cat_id=? AND week=? AND day=?",
        whereArgs: [challenge, week, day]);
    // List<ModelChallengeExerciseData> list = results.isNotEmpty
    //     ? results.map((c) => ModelChallengeExerciseData.fromMap(c)).toList()
    //     : null;
    ModelChallengeExerciseData? product = results.isNotEmpty
        ? ModelChallengeExerciseData.fromMap(results.first)
        : null;
    return product!;
    // return list;
  }

  Future<List<ModelEquipment>> getEquipmentList(
      int id, BuildContext context) async {
    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database.query("tbl_equipment_required",
        where: "reference_detail_id=?", whereArgs: [id]);
    List<ModelEquipment>? list = results.isNotEmpty
        ? results.map((c) => ModelEquipment.fromMap(c, context)).toList()
        : null;
    return list!;
  }

  Future<List<ModelExerciseCategory>> getAllSubCatList(
      BuildContext context) async {
    // Locale myLocale = Localizations.localeOf(context);

    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database.query("tbl_exercise_cat");
    List<ModelExerciseCategory>? list = results.isNotEmpty
        ? results.map((c) => ModelExerciseCategory.fromMap(c, context)).toList()
        : null;
    return list!;
  }

  Future<List<ModelChallengeMainCat>> getAllChallengeCatList(
      BuildContext context) async {
    // Locale myLocale = Localizations.localeOf(context);

    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database.query("challenge_main_cat");
    List<ModelChallengeMainCat>? list = results.isNotEmpty
        ? results.map((c) => ModelChallengeMainCat.fromMap(c, context)).toList()
        : null;
    return list!;
  }

  Future<List<ModelPlanCategory>> getAllWorkoutPlans(
      BuildContext context) async {
    print("getworkoutplan==true");
    // Locale myLocale = Localizations.localeOf(context);

    Database database = await instance.database;
    var results = await database.query("plan_category");
    List<ModelPlanCategory>? list = results.isNotEmpty
        ? results.map((c) => ModelPlanCategory.fromMap(c, context)).toList()
        : null;
    return list!;
  }

  Future<ModelPlanCategory> getWorkoutPlanById(
      int id, BuildContext context) async {
    print("getworkoutplan==true");
    // Locale myLocale = Localizations.localeOf(context);

    Database database = await instance.database;
    var results =
        await database.query("plan_category", where: "id=?", whereArgs: [id]);
    // List<ModelPlanCategory> list = results.isNotEmpty
    //     ? results.map((c) => ModelPlanCategory.fromMap(c, context)).toList()
    //     : null;
    ModelPlanCategory? product = results.isNotEmpty
        ? ModelPlanCategory.fromMap(results.first, context)
        : null;
    return product!;
  }

  Future<int> updateMyPlanRestData(
      int set, String reps, int weight, int rest, int id) async {
    Database database = await instance.database;
    var maps = new HashMap<String, dynamic>();
    maps['rest'] = rest;
    maps['weight'] = weight;
    maps['no_reps'] = reps;
    maps['no_sets'] = set;
    return database
        .update("tbl_my_plan_exercise", maps, where: "id=?", whereArgs: [id]);
  }

  Future<int> removeMyPlanExercise(int myPlanId, int week, int day) async {
    Database database = await instance.database;
    return database.delete("tbl_my_plan_exercise",
        where: "my_plan_id=? AND week=? AND day=? AND exercise_id=?",
        whereArgs: [myPlanId, week, day, 0]);
  }

  Future<int> removeMyPlanById(int myPlanId) async {
    Database database = await instance.database;
    return database
        .delete("tbl_my_plan_exercise", where: "id=?", whereArgs: [myPlanId]);
  }

  Future<int> removeAllMyPlanExercise(int myPlanId, int week, int day) async {
    Database database = await instance.database;
    return database.delete("tbl_my_plan_exercise",
        where: "my_plan_id=? AND week=? AND day=?",
        whereArgs: [myPlanId, week, day]);
  }

  Future<void> addAllMyPlanExercise(
      int myPlanId,
      int week,
      int day,
      List<ModelExerciseDetail> exerciseDetail,
      List<List<int>> intRepsList) async {
    Database database = await instance.database;

    int i = await checkRest(myPlanId, week, day);
    if (i > 0) {
      removeMyPlanExercise(myPlanId, week, day);
    }

    for (int i = 0; i < exerciseDetail.length; i++) {
      var map = new HashMap<String, dynamic>();
      map['day'] = day;
      map['exercise_id'] = exerciseDetail[i].id;
      map['week'] = week;
      map['my_plan_id'] = myPlanId;
      map['no_sets'] = intRepsList[i].length;
      map['no_reps'] = jsonEncode(intRepsList[i]);
      map['weight'] = 0;
      map['rest'] = 0;
      database.insert("tbl_my_plan_exercise", map, nullColumnHack: 'id');
      print("insert==true");
    }
  }

  Future<int> addAllMyPlanExercise1(int myPlanId, int week, int day,
      int exerciseDetail, List<int> intRepsList) async {
    Database database = await instance.database;

    int i = await checkRest(myPlanId, week, day);
    if (i > 0) {
      removeMyPlanExercise(myPlanId, week, day);
    }
    var map = new HashMap<String, dynamic>();
    map['day'] = day;
    map['exercise_id'] = exerciseDetail;
    map['week'] = week;
    map['my_plan_id'] = myPlanId;
    map['no_sets'] = intRepsList.length;
    map['no_reps'] = jsonEncode(intRepsList);
    map['weight'] = 0;
    map['rest'] = 0;
    print("insert==true");
    return database.insert("tbl_my_plan_exercise", map, nullColumnHack: 'id');
  }

  Future<int> copyAllMyPlanExercise1(
      int myPlanId,
      int week,
      int day,
      int exerciseDetail,
      int noSet,
      String noReps,
      int weight,
      int rest) async {
    Database database = await instance.database;

    int i = await checkRest(myPlanId, week, day);
    if (i > 0) {
      removeMyPlanExercise(myPlanId, week, day);
    }
    var map = new HashMap<String, dynamic>();
    map['day'] = day;
    map['exercise_id'] = exerciseDetail;
    map['week'] = week;
    map['my_plan_id'] = myPlanId;
    map['no_sets'] = noSet;
    map['no_reps'] = noReps;
    map['weight'] = weight;
    map['rest'] = rest;
    print("insert==true");
    return database.insert("tbl_my_plan_exercise", map, nullColumnHack: 'id');
  }

  Future<int> checkRest(int myPlanId, int week, int day) async {
    Database database = await instance.database;
    var getRes = await database.query("tbl_my_plan_exercise",
        where: "my_plan_id=? AND week=? AND day=? AND exercise_id=?",
        whereArgs: [myPlanId, week, day, 0]);
    return getRes.length;
  }

  Future<int> addRestDay(int myPlanId, int week, int day) async {
    Database database = await instance.database;
    var map = new HashMap<String, dynamic>();
    map['day'] = day;
    map['exercise_id'] = 0;
    map['week'] = week;
    map['my_plan_id'] = myPlanId;
    map['no_sets'] = 0;
    map['no_reps'] = "";
    map['weight'] = 0;
    map['rest'] = 0;
    return database.insert("tbl_my_plan_exercise", map, nullColumnHack: 'id');
    //
    // var getRes = await database.query("tbl_my_plan_exercise",
    //     where: "my_plan_id=? AND week=? AND day=? AND exercise_id=?",
    //     whereArgs: [myPlanId, week, day, 0]);
    // return getRes.length;
  }

  Future<List<ModelPlanSubCategory>> getPlanSubCategory(
      int id, BuildContext context) async {
    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database
        .query("plan_sub_cat", where: "cat_id=?", whereArgs: [id]);
    List<ModelPlanSubCategory>? list = results.isNotEmpty
        ? results.map((c) => ModelPlanSubCategory.fromMap(c, context)).toList()
        : null;
    return list!;
  }

  Future<List<ModelPlanSubCategory>> getAllPlanSubCategory(
      BuildContext context) async {
    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database.query("plan_sub_cat");
    List<ModelPlanSubCategory>? list = results.isNotEmpty
        ? results.map((c) => ModelPlanSubCategory.fromMap(c, context)).toList()
        : null;
    return list!;
  }

  Future<List<ModelExerciseDetail>> getExerciseCount(
      int id, BuildContext context) async {
    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database
        .query("tbl_exercise_detail", where: "cat_id=?", whereArgs: [id]);
    List<ModelExerciseDetail>? list = results.isNotEmpty
        ? results.map((c) => ModelExerciseDetail.fromMap(c, context)).toList()
        : null;
    return list!;
  }

  Future<List<ModelExerciseDetail>> getAllExerciseList(
      BuildContext context) async {
    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database.query("tbl_exercise_detail");
    List<ModelExerciseDetail>? list = results.isNotEmpty
        ? results.map((c) => ModelExerciseDetail.fromMap(c, context)).toList()
        : null;
    return list!;
  }

// Future<int> update(Map<String, dynamic> row) async {
//   Database database = await instance.database;
//   int id = row['id'];
//   return await database
//       .update(table_main_cat, row, where:  'id = ?', whereArgs: [id]);
// }
//
  Future<int> updateFav(String modelSub, int id) async {
    // Future<int> updateSubCatFav(Map<String, dynamic> row) async {
    Database database = await instance.database;
    var row = new HashMap<String, dynamic>();
    // if(modelSub)
    //   {
    //     row['is_favorite']="1";
    //   }
    // else{
    //   row['is_favorite']="0";
    // }
    row['is_favorite'] = modelSub;
    // row['fav'] = modelSub.fav;
    // row['story'] = modelSub.story;
    // row['title'] = modelSub.title;
    // row['img'] = modelSub.img;
    // row['main_cat_id'] = modelSub.main_cat_id;
    // row['mark_read'] = modelSub.mark_read;
    return await database
        .update("tbl_exercise_detail", row, where: 'id = ?', whereArgs: [id]);
  }

  //
  // Future<List<ModelEquipment>> getAllEquipment(int id) async {
  //   Database database = await instance.database;
  //   var res = await database
  //       .query("tbl_equipment_required", where: "reference_detail_id" + " = ?", whereArgs: [id]);
  //
  //   // .query("tbl_equipment_required", where: "reference_detail_id = ?", whereArgs: [id]);
  //   List<ModelEquipment> equipmentList = res.isNotEmpty
  //       ? res.map((e) => ModelEquipment.fromMap(res)).toList()
  //       : null;
  //   return equipmentList;
  // }

  Future<List<ModelExerciseDetail>> getAllExerciseListData(
      List<ModelPlanExerciseData> dataList, BuildContext context) async {
    List<ModelExerciseDetail> exerciseDetails = [];
    Database database = await instance.database;
    for (int i = 0; i < dataList.length; i++) {
      var res = await database.query("tbl_exercise_detail",
          where: "id" + " = ?", whereArgs: [dataList[i].exerciseId]);
      ModelExerciseDetail? product = res.isNotEmpty
          ? ModelExerciseDetail.fromMap(res.first, context)
          : null;

      // getExerciseDetailByid(dataList[i].exercise_id, context).then((value) {
      //   exerciseDetails.add(value);
      exerciseDetails.add(product!);
      // });
    }
    return Future.value(exerciseDetails);
  }

  Future<bool> isPlanCompleted(int id, int week) async {
    Database database = await instance.database;
    var res = await database.query("plan_complete_data",
        where: "plan_exercise_id=? AND no_week=?", whereArgs: [id, week]);
    print("checkres==$res");
    return res.isNotEmpty;
  }

  Future<bool> isChallengeCompleted(int id, int week, int day) async {
    Database database = await instance.database;
    var res = await database.query("complete_challenge_data",
        where: "challenge_id=? AND week=? AND day=?",
        whereArgs: [id, week, day]);
    return res.isNotEmpty;
  }

  Future<ModelExerciseDetail> getExerciseDetailByid(
      int id, BuildContext context) async {
    Database database = await instance.database;
    var res = await database
        .query("tbl_exercise_detail", where: "id" + " = ?", whereArgs: [id]);
    ModelExerciseDetail? product =
        res.isNotEmpty ? ModelExerciseDetail.fromMap(res.first, context) : null;
    return product!;
  }
//// Future<ModelMainCat> getMainCatByid(int id) async {
//   // Future<ModelMainCat> getMainCatByid(Database assetDB, int id) async {
//   // final db = assetDB;
//   Database database = await instance.database;
//
//   var res = await database
//       .query(table_main_cat, where: "id" + " = ?", whereArgs: [id]);
//   ModelMainCat product =
//       res.isNotEmpty ? ModelMainCat.fromMap(res.first) : null;
//   return product;
// }
//
// Future<List> getAllSubCatByMainCat(int id) async {
//   // Future<ModelMainCat> getMainCatByid(Database assetDB, int id) async {
//   // final db = assetDB;
//   Database database = await instance.database;
//
//   var res = await database
//       .query(table_sub_cat, where: "main_cat_id" + " = ?", whereArgs: [id]);
//   // ModelMainCat product =
//   //     res.isNotEmpty ? ModelMainCat.fromMap(res.first) : null;
//   return res.toList();
// }
//
// Future<List> getAllFavItem() async {
//   // Future<ModelMainCat> getMainCatByid(Database assetDB, int id) async {
//   // final db = assetDB;
//   Database database = await instance.database;
//
//   var res = await database
//       .query(table_sub_cat, where: "fav" + " = ?", whereArgs: [1]);
//   // ModelMainCat product =
//   //     res.isNotEmpty ? ModelMainCat.fromMap(res.first) : null;
//   return res.toList();
// }
//
// Future<ModelSubCategory> getSubCatByid(int id) async {
//   // Future<ModelMainCat> getMainCatByid(Database assetDB, int id) async {
//   // final db = assetDB;
//   Database database = await instance.database;
//   var res = await database
//       .query(table_sub_cat, where: "id" + " = ?", whereArgs: [id]);
//   ModelSubCategory product =
//       res.isNotEmpty ? ModelSubCategory.fromMap(res.first) : null;
//   return product;
// }
//
// Future<int> delete(int ids) async {
//   Database database = await instance.database;
//   return await database.delete(table_main_cat, where: 'id', whereArgs: [ids]);
// }
}
