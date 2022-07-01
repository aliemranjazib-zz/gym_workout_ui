import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/ExerciseDetailScreen.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/model/ModelExerciseCategory.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/model/ModelExerciseDetail.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


import 'generated/l10n.dart';

class ExerciseCategoryList extends StatefulWidget {
  final ModelExerciseCategory exerciseCategory;

  final List<ModelExerciseCategory> list;

  ExerciseCategoryList(this.exerciseCategory, this.list);

  @override
  _ExerciseCategoryList createState() => _ExerciseCategoryList();
}

class _ExerciseCategoryList extends State<ExerciseCategoryList>
    with TickerProviderStateMixin {
  ModelExerciseCategory? exerciseCategory;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  AnimationController? animationController;

  // final AnimationController animationController;
  Animation<dynamic>? animation;

  // _ExerciseCategoryList(this.exerciseCategory);

  @override
  void initState() {
    setState(() {
      exerciseCategory = widget.exerciseCategory;
    });
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double height = ConstantWidget.getScreenPercentSize(context, 6);
    return WillPopScope(
      onWillPop: _requestPop,
      child:
          // MaterialApp(
          //   theme: ConstantData.themeData,
          //   // locale:new Locale("he",''),
          //   // locale: S.delegate.supportedLocales,
          //   // locale:myLocale,
          //   localizationsDelegates: [
          //     S.delegate,
          //     GlobalMaterialLocalizations.delegate,
          //     GlobalWidgetsLocalizations.delegate,
          //   ],
          //   supportedLocales: S.delegate.supportedLocales,
          //   // title: exerciseCategory.cat_name,
          //   home:
          Scaffold(
            backgroundColor: Colors.white,
        //     appBar: getThemeAppBar(exerciseCategory!.categoryName!, (){
        //       closeActivity();
        //     }),
        // AppBar(
        //   leading: Builder(
        //     builder: (BuildContext context) {
        //       return IconButton(
        //         icon: Icon(Icons.keyboard_backspace_rounded),
        //         onPressed: () {
        //           closeActivity();
        //
        //           // Scaffold.of(context).openDrawer();
        //         },
        //         tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //       );
        //     },
        //   ),
        //   title: getHeaderTitle(exerciseCategory.cat_name),
        // ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                ConstantWidget.getAppBar(context, S.of(context).exercise, () {
                  closeActivity();
                }),

                Container(

                    margin:
                    EdgeInsets.only(top: ConstantWidget.getMarginTop(context)-ConstantWidget.getScreenPercentSize(context,1.2)),
                    child: Column(
                      children: [
                        Container(





                          height: height,
                          child: ListView.builder(
                            itemCount: widget.list.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              bool isSelected =
                              (exerciseCategory!.id == widget.list[index].id);
                              return InkWell(child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: ConstantWidget.getTextWidget(
                                          widget.list[index].categoryName!,
                                          (isSelected)
                                              ? Colors.black
                                              : Colors.black54,
                                          TextAlign.start,
                                          (isSelected)
                                              ? FontWeight.w800:FontWeight.w500,
                                          ConstantWidget.getPercentSize(height, 35)),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        height: 5,
                                        width: ConstantWidget.getWidthPercentSize(context,5),
                                        color: (isSelected)
                                            ? primaryColor
                                            : Colors.transparent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                                onTap: (){
                                  setState(() {
                                    exerciseCategory = widget.list[index];
                                  });
                                },);
                            },
                          ),
                        ),
                        Container(height: 15,color: Colors.white,),
                        Expanded(
                            child: FutureBuilder<List<ModelExerciseDetail>>(
                              future: _databaseHelper.getExerciseCount(
                                  exerciseCategory!.id!, context),
                              builder: (context, snapshot) {
                                List<ModelExerciseDetail> exerciseDetail = [];
                                if (snapshot.hasData) {
                                  exerciseDetail = snapshot.data!;
                                }
                                return (snapshot.hasData)
                                    ? getGridLIst(exerciseDetail)
                                    : getProgressDialog();
                              },
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  getGridLIst(List<ModelExerciseDetail> _list) {

    double height =SizeConfig.safeBlockVertical! * 12;
    return ListView.builder(
      itemBuilder: (context, index) {
        ModelExerciseDetail category = _list[index];
        final Animation<double> animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(
          // Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController!,
            curve: Interval((1 / _list.length) * index, 1.0,
                curve: Curves.fastOutSlowIn),
          ),
        );
        animationController!.forward();

        return AnimatedBuilder(
          animation: animationController!,
          builder: (context, child) {
            return FadeTransition(
                opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 50 * (1.0 - animation.value), 0.0),
                  child: Container(
                    color: Colors.white,
                      height: height,
                      width: double.infinity,
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => ExerciseDetailScreen(),
                              builder: (context) => ExerciseDetailScreen(
                                exerciseDetail: category,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: height,
                              height: double.infinity,
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

                                ConstantWidget.getTextWidget(category.exerciseName!, Colors.black,
                                    TextAlign.start, FontWeight.w600, ConstantWidget.getPercentSize(height, 15)),

                                SizedBox(height: 5,),

                                ConstantWidget.getTextWidget("Difficulty: Beginner", Colors.grey,
                                    TextAlign.start, FontWeight.w400, ConstantWidget.getPercentSize(height, 14)),



                              ],
                            ))


                            // Container(
                            //     width: SizeConfig.safeBlockHorizontal! * 50,
                            //     decoration: new BoxDecoration(
                            //         color: primaryColor,
                            //         //new Color.fromRGBO(255, 0, 0, 0.0),
                            //         borderRadius: new BorderRadius.only(
                            //             topLeft: const Radius.circular(8.0),
                            //             bottomRight: Radius.circular(35.0))),
                            //     margin: EdgeInsets.only(right: 30),
                            //     child: Padding(
                            //       // padding: EdgeInsets.all(0),
                            //       padding: EdgeInsets.only(top: 12, bottom: 12),
                            //       child:
                            //           // Column(
                            //           //   children: [
                            //           Text(
                            //         category.exerciseName!,
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 15,
                            //             color: Colors.black),
                            //         maxLines: 1,
                            //       ),
                            //       // ],
                            //       // ),
                            //     ))
                          ],
                        ),
                      )),
                ));
          },
        );
      },
      // itemCount: 3,
      itemCount: _list.length,
    );

    // return GridView.count(
    //     crossAxisCount: 2,
    //     childAspectRatio: 1.3,
    //     padding: EdgeInsets.all(7),
    //     shrinkWrap: true,
    //     children: List.generate(_list.length, (index) {
    //       ModelExerciseDetail maincat = _list[index];
    //       print("size==$index---${_list.length}");
    //       return ExerciseCatItem(maincat, context);
    //     }));
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  void closeActivity() {
    Navigator.pop(context);
  }
}

class VideoWidget extends StatefulWidget {
  final bool? play;
  final String? url;

  const VideoWidget({Key? key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {


  @override
  void initState() {
    super.initState();


  }

  YoutubePlayerController youtubePlayerController = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=krlBcLYtDbk")!,
    flags: YoutubePlayerFlags(
      autoPlay: true,

    ),
  );



  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    print("video---truw");
    return Container(
      child: Card(
        key: new PageStorageKey(widget.url),
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: AspectRatio(
              //   aspectRatio: videoPlayerController!.value.aspectRatio,
              //   child: VideoPlayer(videoPlayerController!),
              // ),

           child:     YoutubePlayer(
                  controller: youtubePlayerController,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(isExpanded: true),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

// void loaThumbnails() async {
//   final uint8list = await VideoThumbnail.thumbnailData(
//     video:"assets/video1.mp4",
//     imageFormat: ImageFormat.JPEG,
//     maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//     quality: 25,
//   );
//   print("imglist==$uint8list");
//
// }
}
