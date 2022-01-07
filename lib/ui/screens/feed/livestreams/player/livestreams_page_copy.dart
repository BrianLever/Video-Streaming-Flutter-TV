// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:americonictv_tv/ui/screens/feed/livestreams/entry/livestream_entry.dart';
//
// class LivestreamsDisplay extends StatefulWidget {
//   final dynamic response;
//
//   LivestreamsDisplay({@required this.response});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _LivestreamsDisplayState();
//   }
// }
//
// class _LivestreamsDisplayState extends State<LivestreamsDisplay> {
//   final _pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.response.runtimeType == String ||Map<String, dynamic>.from(widget.response)['error']==true)
//        {
//       return Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'No livestreams found.',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           );
//     } else {
//       return PageView(
//             controller: _pageController,
//             children: [
//               for (int i = 0; i < widget.response['applications'].length; i++)
//                 LivestreamEntry(
//                   index: i,
//                   length: 5,
//                   livestream: widget.response['applications'][i],
//                   viewers: widget.response['nclients'],
//                   pageController: _pageController,
//                 ),
//             ],
//           );
//     }
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
// }
