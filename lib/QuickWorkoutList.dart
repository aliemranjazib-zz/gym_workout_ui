import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'ExerciseDetailScreen.dart';
import 'SizeConfig.dart';
import 'db/database_helper.dart';
import 'model/ModelExerciseDetail.dart';
import 'model/WorkoutModel.dart';

class QuickWorkoutList extends StatefulWidget{

  final String title;
  final WorkoutModel subCategory;
  QuickWorkoutList(this.title,this.subCategory);

  @override
  _QuickWorkoutList createState() => _QuickWorkoutList();

}

class   _QuickWorkoutList extends State<QuickWorkoutList>{
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
List<ModelExerciseDetail> list=[];

  void onBackClick() {
    Navigator.of(context).pop();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    new Future.delayed(const Duration(seconds: 1), () {

      _databaseHelper.getAllExerciseList(context).then((value) {
        list  =value;
        setState(() {

        });

      });

    });

  }

  @override
  Widget build(BuildContext context) {
    double height =SizeConfig.safeBlockVertical! * 12;

   return WillPopScope(child: Scaffold(
     backgroundColor: Colors.white,
     body: SafeArea(

       child: CustomScrollView(
         slivers: [
            SliverAppBar(


              // leading: Container(),

             floating: true,
             expandedHeight: ConstantWidget.getScreenPercentSize(context, 25),

              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,

                  title: ConstantWidget.getTextWidget(widget.title, Colors.white,
                      TextAlign.start, FontWeight.w600, ConstantWidget.getScreenPercentSize(context, 1.8)),
                  background: Image.asset(
                    ConstantData.assetImagesPath+widget.subCategory.image!,
                    fit: BoxFit.cover,
                  )),


           ),
           // Next, create a SliverList
           SliverList(
             // Use a delegate to build items as they're scrolled on screen.
             delegate: SliverChildBuilderDelegate(
               // The builder function returns a ListTile with a title that
               // displays the index of the current item.
                   (context, index) => Container(

                       // height: (index==0)?height*1.4:height,
                       width: double.infinity,
                       margin: EdgeInsets.all(8),
                       child: InkWell(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               // builder: (context) => ExerciseDetailScreen(),
                               builder: (context) => ExerciseDetailScreen(
                                 exerciseDetail: list[index],
                               ),
                             ),
                           );
                         },
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [

                             Visibility(
                               child: Padding(padding: EdgeInsets.only(bottom: 12),child: ConstantWidget.getTextWidget(S.of(context).intemediate, Colors.black,
                                   TextAlign.start, FontWeight.bold, ConstantWidget.getPercentSize(height, 15)),),

                               visible: (index==0),
                             ),

                             Container(

                               height: height,
                               child: Row(
                                 children: [



                                   Container(
                                     width: height,
                                     height: double.infinity,
                                     // color: ConstantData.cellColor,
                                     child: ClipRRect(
                                       child: Image.asset(
                                         ConstantData.assetImagesPath + "abs_1.png",
                                         fit: BoxFit.scaleDown,
                                         width: double.infinity,
                                         height: double.infinity,
                                       ),
                                     ),
                                   ),

                                   SizedBox(width: 15,),
                                   Expanded(child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [

                                       ConstantWidget.getTextWidget(list[index].exerciseName!, Colors.black,
                                           TextAlign.start, FontWeight.w600, ConstantWidget.getPercentSize(height, 15)),
                                       SizedBox(height: 5,),

                                       ConstantWidget.getTextWidget("15 Reps", Colors.grey,
                                           TextAlign.start, FontWeight.w400, ConstantWidget.getPercentSize(height, 14)),



                                     ],
                                   ))



                                 ],
                               ),
                             )
                           ],
                         ),
                       )),
               // Builds 1000 ListTiles
               childCount: list.length,
             ),
           ),
         ],

       ),
     ),

   ), onWillPop: () async {
     onBackClick();
     return false;
   },);
  }



}
