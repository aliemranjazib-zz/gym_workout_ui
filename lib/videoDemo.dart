// //import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
//
// class VideoDemo extends StatefulWidget {
//   @override
//   _VideoDemoState createState() => _VideoDemoState();
// }
//
// class _VideoDemoState extends State<VideoDemo> {
//   VideoPlayerController? _controller;
//
//   String screenText = "";
//   String screenSubText = "";
//   Timer? timer;
//   int position = 0;
//   List<String> screenTextList = ["Welcome", "Enjoy", "Search"];
//   List<String> screenSubTextList = [
//     "This is a cool example of the video player.",
//     "Programming with Flutter is fun.",
//     "Looking for a special video, please checkout my playlist."
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     // _controller = VideoPlayerController.asset('assets/ex1.mp4')
//     //   ..initialize().then((_) {
//     //     // _controller = VideoPlayerController.network('https://captnotes.com/wp-content/uploads/2020/02/demo_video_02.mp4')..initialize().then((_) {
//     //     setState(() {
//     //       _controller!.play();
//     //     });
//     //   });
//     // _controller!.setLooping(true);
//     // _controller!.setVolume(0.0);
//
//     _controller = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//
//     Timer.periodic(Duration(seconds: 15), (Timer t) {
//       setState(() {
//         screenText = screenTextList[position];
//         screenSubText = screenSubTextList[position];
//         position++;
//       });
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Video Demo',
//       home: Scaffold(
//         body: Stack(
//           fit: StackFit.expand,
//           children: <Widget>[
//             Container(
//               child: _controller!.value.isInitialized
//                   ? AspectRatio(
//                       aspectRatio: _controller!.value.aspectRatio,
//                       child: VideoPlayer(_controller!),
//                     )
//                   : Container(),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 16.0,
//                     right: 16.0,
//                   ),
//                   child: Container(
//                     child: Text(
//                       screenText,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 16.0,
//                     right: 16.0,
//                   ),
//                   child: Container(
//                     child: Text(
//                       screenSubText,
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 16.0,
//                     right: 16.0,
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: RaisedButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(30.0)),
//                       child: Text('LOG IN'),
//                       onPressed: () {},
//                       color: Color(0xff222327),
//                       textColor: Colors.black,
//                       padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                       splashColor: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 16.0,
//                     right: 16.0,
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                               borderRadius: new BorderRadius.circular(30.0)),
//
//
//                             ),
//                         backgroundColor: MaterialStateProperty.all<Color>(Color(0xff648f01))
//     ,
//
//
//
//
//                         // shape: RoundedRectangleBorder(
//                         //     borderRadius: new BorderRadius.circular(30.0)),
//                       ),
//
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                         child: Text('SIGN IN'),
//                       ),
//                       onPressed: () {},
//                       // color: Color(0xff648f01),
//                       // textColor: Colors.black,
//                       // padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                       // c
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
