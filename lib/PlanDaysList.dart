// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:healtho_app/ConstantColors.dart';
// import 'package:healtho_app/ConstantData.dart';
// import 'package:healtho_app/SizeConfig.dart';
// import 'package:healtho_app/Widgets.dart';
// import 'package:healtho_app/db/database_helper.dart';
// import 'package:healtho_app/generated/l10n.dart';
// import 'package:healtho_app/model/ModelExerciseDetail.dart';
// import 'package:healtho_app/model/ModelPlanExerciseData.dart';
// import 'package:healtho_app/model/ModelPlanExerciseTime.dart';
// import 'package:healtho_app/model/ModelPlanSubCategory.dart';
//
// class PlanDaysList extends StatefulWidget {
//   final int week, day;
//   final ModelPlanSubCategory planSubCat;
//
//   PlanDaysList(this.week, this.day, this.planSubCat);
//
//   @override
//   _PlanDaysList createState() => _PlanDaysList();
// }
//
// class _PlanDaysList extends State<PlanDaysList> {
//   DatabaseHelper _databaseHelper = DatabaseHelper.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return WillPopScope(
//       child: Scaffold(
//         appBar: getThemeAppBar(
//             "${S.of(context).week} ${widget.week}-${S.of(context).day} ${widget.day}",
//             () {
//           onBackClick();
//         }),
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           child: FutureBuilder<List<ModelPlanExerciseData>>(
//             future: _databaseHelper.getAllPlanExerciseData(
//                 widget.planSubCat.cat_id, widget.planSubCat.id, widget.day),
//             builder: (context, snapshot) {
//               return (snapshot.hasData)
//                   ? getGridLIst(snapshot.data)
//                   : getProgressDialog();
//             },
//           ),
//         ),
//       ),
//       onWillPop: () async {
//         onBackClick();
//         return false;
//       },
//     );
//   }
//
//   void onBackClick() {
//     Navigator.of(context).pop();
//   }
//
//   getGridLIst(List<ModelPlanExerciseData> data) {
//     return ListView.builder(
//       itemCount: data.length,
//       scrollDirection: Axis.vertical,
//       itemBuilder: (context, index) {
//         // ModelExerciseDetail exerciseDetail;
//         // _databaseHelper
//         //     .getExerciseDetailByid(data[index].exercise_id, context)
//         //     .then((value) {
//         //   setState(() {
//         //     exerciseDetail = value;
//         //   });
//         // });
//         // return FutureBuilder<List<ModelPlanExerciseTime>>(
//         return FutureBuilder<ModelPlanExerciseTime>(
//           future: _databaseHelper.getPlanExerciseTime(widget.week, data[index].id),
//           builder: (context, snapshot) {
//             print("daysdata2==${snapshot.data}");
//             // ModelExerciseDetail exerciseDetail;
//             // _databaseHelper
//             //     .getExerciseDetailByid(data[index].exercise_id, context)
//             //     .then((value) {
//             //   setState(() {
//             //     exerciseDetail = value;
//             //   });
//             // });
//             return (snapshot.hasData)
//                 ? Container(
//                     margin: EdgeInsets.all(12),
//                     padding: EdgeInsets.all(7),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: whiteGray,
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 1,
//                           blurRadius: 5,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8.0),
//                           child: Image.asset(
//                             ConstantData.assetImagesPath +"abs_1.png",
//                             // ConstantData.assetImagesPath +exerciseDetail.exerciseImage,
//                             width: SizeConfig.safeBlockHorizontal * 20,
//                             height: SizeConfig.safeBlockHorizontal * 20,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             margin: EdgeInsets.only(
//                                 left: 12, right: 10, top: 7, bottom: 7),
//                             child: Column(
//                               children: [
//                                 Text("exerciseName",style: getTextStyles(Colors.black54,16),
//                                 maxLines: 1,),
//                                 SizedBox(
//                                   height: 7,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: getNormalText(14,
//                                           "Sets", Colors.black),
//                                       flex: 1,
//                                     ),
//                                     Expanded(
//                                       child: getNormalText(14,
//                                           "${snapshot.data.set}",
//                                           Colors.black54),
//                                       flex: 2,
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 7,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: getNormalText(
//                                           14, "Reps", Colors.black),
//                                       flex: 1,
//                                     ),
//                                     Expanded(
//                                       child: getNormalText(
//                                           14,
//                                           "${snapshot.data.reps_count}"
//                                               .replaceAll("[", "")
//                                               .replaceAll("]", "")
//                                               .replaceAll(",", " - ").trim(),
//                                           Colors.black54),
//                                       flex: 2,
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 7,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: getNormalText(
//                                           14, "Rest", Colors.black),
//                                       flex: 1,
//                                     ),
//                                     Expanded(
//                                       child: getNormalText(
//                                           14,
//                                           "${snapshot.data.rest_time} ${S.of(context).sec}",
//                                           Colors.black54),
//                                       flex: 2,
//                                     )
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                           flex: 1,
//                         ),
//                         Icon(
//                           CupertinoIcons.right_chevron,
//                           color: Colors.grey,
//                         )
//                       ],
//                     ),
//                   )
//                 : getProgressDialog();
//           },
//         );
//       },
//     );
//   }
// }
