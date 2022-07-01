import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/model/ModelEquipment.dart';
import 'package:healtho_app/model/ModelExerciseDetail.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final ModelExerciseDetail? exerciseDetail;

  ExerciseDetailScreen({this.exerciseDetail});

  // final String name;
  // final String image;
  @override
  _DetailScreenState createState() => _DetailScreenState(exerciseDetail);
}

class _DetailScreenState extends State<ExerciseDetailScreen> {
  ModelExerciseDetail? exerciseDetail;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  // var text = widget.exerciseDetail.exercise_name;
  // VideoPlayerController? _controller;
  Widget? iconFav;

  _DetailScreenState(this.exerciseDetail);

  void closeActivity() {
    youtubePlayerController.dispose();
    Navigator.pop(context);
  }


  YoutubePlayerController youtubePlayerController = YoutubePlayerController(
    // initialVideoId: "7QUtEmBT_-w",
    initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=krlBcLYtDbk")!,
    flags: YoutubePlayerFlags(
      autoPlay: true,

    ),
  );




  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network("https://www.youtube.com/watch?v=krlBcLYtDbk")
    // // _controller = VideoPlayerController.asset('assets/videos/ex1.mp4')
    // // 'assets/videos/${widget.exerciseDetail!.exerciseImage!}.mp4')
    //   ..initialize().then((_) {
    //     // _controller = VideoPlayerController.network('https://captnotes.com/wp-content/uploads/2020/02/demo_video_02.mp4')..initialize().then((_) {
    //     setState(() {
    //       _controller!.play();
    //     });
    //   });
    // _controller!.setLooping(true);
    // _controller!.setVolume(0.0);

    // _controller = VideoPlayerController.network(
    //     'https://www.youtube.com/watch?v=krlBcLYtDbk')
    //     // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     _controller!.play();
    //     setState(() {
    //
    //     });
    //
    //
    //   });
    setFavIcons();

  }

  getEquipmentList(List<ModelEquipment> equipmentList) {
    print("inrec==true");
    return Container(
      height: SizeConfig.safeBlockHorizontal! * 30,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          print("inrec1==true");
          return Container(
            margin: EdgeInsets.all(5),
            height: double.infinity,
            width: SizeConfig.safeBlockHorizontal! * 30,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    ConstantData.assetImagesPath +
                        equipmentList[index].equipmentImage!,
                    fit: BoxFit.contain,
                  ),
                  flex: 1,
                ),
                Text(
                  equipmentList[index].bodyName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: ConstantData.fontsFamily,
                      fontSize: 14,
                      color: Colors.black87),
                )
              ],
            ),
          );
        },
      ),
    );
    // return ListView.builder(
    //   primary: false,
    //   shrinkWrap: true,
    //   scrollDirection: Axis.horizontal,
    //   itemCount: equipmentList.length,
    //   itemBuilder: (context, index) {
    //     print("inrec1==true");
    //     return Container(
    //       height: SizeConfig.safeBlockHorizontal * 20,
    //       width: SizeConfig.safeBlockHorizontal * 20,
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: Image.asset(
    //               ConstantData.assetImagesPath +
    //                   equipmentList[index].equpment_image,
    //               fit: BoxFit.contain,
    //             ),
    //             flex: 1,
    //           ),
    //           Text(
    //             equipmentList[index].body_name,
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //                 fontFamily: ConstantData.fontsFamily,
    //                 fontSize: 14,
    //                 color: Colors.black87),
    //           )
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: getThemeAppBar(widget.exerciseDetail!.exerciseName!, () {
        //   closeActivity();
        // }),
        body: SafeArea(
          child: Container(



            child: GestureDetector(
              onTap: () {
                closeActivity();
              },
              child: Stack(
                children: [

                  ConstantWidget.getAppBar(context, widget.exerciseDetail!.exerciseName!, () {
                    closeActivity();
                  }),


                Container(
                  margin:
                  EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),

                  child: Stack(
                  children: [Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                          tag: "ex2.mp4",
                          child: Container(
                            margin: EdgeInsets.all(12),
                            height: SizeConfig.safeBlockVertical! * 30,

                            child: Center(
                              child:
                              // _controller!.value.isInitialized
                              //     ?
                              // VideoPlayer(_controller)


                              YoutubePlayer(

                                controller: youtubePlayerController,
                                bottomActions: [
                                  CurrentPosition(),
                                  ProgressBar(isExpanded: true),
                                ],
                              )



                                // AspectRatio(
                              //   aspectRatio:
                              //   _controller!.value.aspectRatio,
                              //   child: VideoPlayer(_controller!),
                              // )
                              //     : getProgressDialog(),
                              // : Container(color: Colors.amber),
                            ),
                          )),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 16.0,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: ConstantData.themeData.backgroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.all(7),
                              child: getMediumBoldText(
                                  widget.exerciseDetail!.exerciseName!,
                                  Colors.black),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7),
                              child: getSmallNormalText(
                                  widget.exerciseDetail!.exerciseDetail!,
                                  Colors.black54),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.all(7),
                            //   child: getSmallBoldText(
                            //       S
                            //           .of(context)
                            //           .equipmentRequired,
                            //       Colors.black),
                            // ),
                            // FutureBuilder<List<ModelEquipment>>(
                            //   future: _databaseHelper
                            //       .getEquipmentList(exerciseDetail!.id!, context),
                            //   builder: (context, snapshot) {
                            //     print("idsnap===${snapshot.data}");
                            //     return (snapshot.hasData)
                            //         ? getEquipmentList(snapshot.data!)
                            //         : getProgressDialog();
                            //   },
                            // )
                          ],
                        ),
                      ),

                    ],
                  ), Align(
                    alignment: Alignment.topRight,
                    // alignment: Alignment.bottomRight,
                    child: Card(
                      margin: EdgeInsets.only(right: 14,
                          top: SizeConfig.safeBlockVertical! * 30,
                          bottom: 14,
                          left: 14),
                      // margin: EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: iconFav!,
                            color: primaryColor,
                            onPressed: () {
                              if (exerciseDetail!.isFavorite! == "1") {
                                _databaseHelper.updateFav(
                                    "0", exerciseDetail!.id!);
                              } else {
                                _databaseHelper.updateFav(
                                    "1", exerciseDetail!.id!);
                              }
                              // setState(() {
                              _databaseHelper
                                  .getExerciseDetailByid(
                                  exerciseDetail!.id!, context)
                                  .then((value) {
                                setState(() {
                                  exerciseDetail = value;
                                  setFavIcons();
                                });
                              });
                              // setFavIcons();
                              // });
                            },
                          ),
                          // SizedBox(width: 5,),
                          IconButton(
                            icon: Icon(Icons.share),
                            color: primaryColor,
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  )

                  ],
                ),)



              ],
            ),
      ),
      // child: Stack(
      //   children: [
      //     SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Hero(
      //               tag: widget.exerciseDetail.exerciseImage,
      //               child: Container(
      //                 margin: EdgeInsets.all(12),
      //                 height: SizeConfig.safeBlockVertical * 30,
      //                 color: Colors.white,
      //                 child: Center(
      //                   child: _controller.value.initialized
      //                       ?
      //                       // VideoPlayer(_controller)
      //                       AspectRatio(
      //                           aspectRatio:
      //                               _controller.value.aspectRatio,
      //                           child: VideoPlayer(_controller),
      //                         )
      //                       : getProgressDialog(),
      //                   // : Container(color: Colors.amber),
      //                 ),
      //               )),
      //
      //           Container(
      //             width: double.infinity,
      //             decoration: BoxDecoration(
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.black12,
      //                   blurRadius: 16.0,
      //                 ),
      //               ],
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(30),
      //                   topRight: Radius.circular(30)),
      //               color: ConstantData.themeData.backgroundColor,
      //             ),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.all(7),
      //                   child: getMediumBoldText(
      //                       widget.exerciseDetail.exerciseName,
      //                       Colors.black),
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.all(7),
      //                   child: getSmallNormalText(
      //                       widget.exerciseDetail.exerciseDetail,
      //                       Colors.black54),
      //                 ),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.all(7),
      //                   child: getSmallBoldText(
      //                       S.of(context).equipmentRequired,
      //                       Colors.black),
      //                 ),
      //                 FutureBuilder<List<ModelEquipment>>(
      //                   future: _databaseHelper
      //                       .getEquipmentList(exerciseDetail.id,context),
      //                   builder: (context, snapshot) {
      //                     print("idsnap===${snapshot.data}");
      //                     return (snapshot.hasData)
      //                         ? getEquipmentList(snapshot.data)
      //                         : getProgressDialog();
      //                   },
      //                 )
      //               ],
      //             ),
      //           ),
      //
      //         ],
      //       ),
      //     ),
      //     Align(
      //       alignment: Alignment.topRight,
      //       // alignment: Alignment.bottomRight,
      //       child: Card(
      //         margin: EdgeInsets.only(right: 14,top: SizeConfig.safeBlockVertical * 30,bottom: 14,left: 14),
      //         // margin: EdgeInsets.all(14),
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(25)),
      //         child: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             SizedBox(
      //               width: 10,
      //             ),
      //             IconButton(
      //               icon: iconFav,
      //               color: ConstantData.themeData.accentColor,
      //               onPressed: () {
      //                 if (exerciseDetail.isFavorite == "1") {
      //                   _databaseHelper.updateFav(
      //                       "0", exerciseDetail.id);
      //                 } else {
      //                   _databaseHelper.updateFav(
      //                       "1", exerciseDetail.id);
      //                 }
      //                 // setState(() {
      //                 _databaseHelper
      //                     .getExerciseDetailByid(
      //                         exerciseDetail.id, context)
      //                     .then((value) {
      //                   setState(() {
      //                     exerciseDetail = value;
      //                     setFavIcons();
      //                   });
      //                 });
      //                 // setFavIcons();
      //                 // });
      //               },
      //             ),
      //             // SizedBox(width: 5,),
      //             IconButton(
      //               icon: Icon(CupertinoIcons.share),
      //               color: ConstantData.themeData.accentColor,
      //               onPressed: () {},
      //             ),
      //             SizedBox(
      //               width: 10,
      //             )
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // )
      // ),
    ),
        )),
    onWillPop
    :
    _requestPop
    );
    // return new WillPopScope(
    //   onWillPop: _requestPop,
    //   child: MaterialApp(
    //     theme: ConstantData.themeData,
    //     // locale:new Locale("he",''),
    //     // locale: S.delegate.supportedLocales,
    //     // locale:myLocale,
    //     localizationsDelegates: [
    //       S.delegate,
    //       GlobalMaterialLocalizations.delegate,
    //       GlobalWidgetsLocalizations.delegate,
    //     ],
    //     supportedLocales: S.delegate.supportedLocales,
    //     home: SafeArea(
    //       child: Scaffold(
    //         body: GestureDetector(
    //           onTap: () {
    //             Navigator.pop(context);
    //           },
    //           child: SingleChildScrollView(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Hero(
    //                   tag: widget.exerciseDetail.exercise_img,
    //                   child: ClipRRect(
    //                     borderRadius: new BorderRadius.circular(12.0),
    //                     child: Image.asset(
    //                       "assets/imgs/abs_1.png",
    //                       fit: BoxFit.cover,
    //                       height: 400,
    //                       width: MediaQuery
    //                           .of(context)
    //                           .size
    //                           .width,
    //                     ),
    //                   ),
    //                 ),
    //                 // 16.height,
    //                 Text(widget.exerciseDetail.exercise_name),
    //                 // 16.height,
    //                 Text(
    //                   widget.exerciseDetail.exercise_detail,
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   )
    //
    // );
    //
    // // return SafeArea(
    // //   child: Scaffold(
    // //     body: GestureDetector(
    // //       onTap: () {
    // //         Navigator.pop(context);
    // //       },
    // //       child: SingleChildScrollView(
    // //         child: Column(
    // //           crossAxisAlignment: CrossAxisAlignment.start,
    // //           children: <Widget>[
    // //             Hero(
    // //               tag: widget.exerciseDetail.exercise_img,
    // //               child: ClipRRect(
    // //                 borderRadius: new BorderRadius.circular(12.0),
    // //                 child: Image.asset(
    // //                   "assets/imgs/abs_1.png",
    // //                   fit: BoxFit.cover,
    // //                   height: 400,
    // //                   width: MediaQuery.of(context).size.width,
    // //                 ),
    // //               ),
    // //             ),
    // //             // 16.height,
    // //             Text(widget.exerciseDetail.exercise_name),
    // //             // 16.height,
    // //             Text(
    // //               widget.exerciseDetail.exercise_detail,
    // //             )
    // //           ],
    // //         ),
    // //       ),
    // //     ),
    // //   ),
    // // );
  }

  Future<bool> _requestPop() {
    closeActivity();
    return new Future.value(true);
  }

  void setFavIcons() {
    if (exerciseDetail!.isFavorite! == "1") {
      iconFav = new Icon(Icons.favorite);
    } else {
      iconFav = new Icon(Icons.favorite_border);
    }
  }
}
