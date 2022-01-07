import 'dart:convert';

import 'package:americonictv_tv/ui/shared/video_entry_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:americonictv_tv/ui/screens/feed/livestreams/entry/livestream_entry.dart';

class LivestreamsDisplay extends StatefulWidget {
  final dynamic response;

  LivestreamsDisplay({@required this.response});

  @override
  State<StatefulWidget> createState() {
    return _LivestreamsDisplayState();
  }
}

class _LivestreamsDisplayState extends State<LivestreamsDisplay> {
  final _pageController = PageController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.response.runtimeType == String ||Map<String, dynamic>.from(widget.response)['error']==true)
       {
      return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'No livestreams found.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          );
    } else {
      return ListView(
            padding: EdgeInsets.symmetric(vertical: 60),
            controller: _scrollController,
            shrinkWrap: true,
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 16 / 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: widget.response['applications'].length,
                  padding: const EdgeInsets.only(left: 12),
                itemBuilder: (context, i) => LivestreamEntry(
                  index: i,
                  length: widget.response['applications'].length,
                  livestream: widget.response['applications'][i],
                  viewers: widget.response['nclients'],
                  scrollController: _scrollController,
                ),
              ),
            ],
          );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
