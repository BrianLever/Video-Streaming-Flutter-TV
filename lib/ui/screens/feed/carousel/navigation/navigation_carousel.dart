import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/ui/screens/feed/carousel/navigation/nav_carousel_entry.dart';
import 'package:americonictv_tv/ui/screens/feed/trending/bloc/selected_trending_video_controller.dart';

class NavigationCarousel extends StatefulWidget {
  final List<VideoData> videoRows;

  NavigationCarousel({@required this.videoRows});

  @override
  State<StatefulWidget> createState() {
    return _NavigationCarouselState();
  }
}

class _NavigationCarouselState extends State<NavigationCarousel> {
  final _scrollController = ScrollController();
  final _firstEntryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SelectedTrendingVideoController.init();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) => NavCarouselEntry(
        video: widget.videoRows[i % widget.videoRows.length],
        scrollController: _scrollController,
        length: widget.videoRows.length,
        focusNode: i == 0 ? _firstEntryFocusNode : null,
        index: i,
      ),
    );
  }

  @override
  void dispose() {
    SelectedTrendingVideoController.dispose();
    super.dispose();
  }
}
