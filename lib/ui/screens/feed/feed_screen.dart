import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/videos.dart';
import 'package:americonictv_tv/ui/screens/feed/bloc/feed_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/bloc/selected_video_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/carousel/bg/bloc/bg_carousel_index_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/categories/categories.dart';
import 'package:americonictv_tv/ui/screens/feed/latest_trending/latest_trending.dart';
import 'package:americonictv_tv/ui/screens/feed/livestreams/livestreams_page.dart';
import 'package:americonictv_tv/ui/screens/feed/navigation_bar/bloc/focus_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/navigation_bar/navigation_bar.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedScreenState();
  }
}

class _FeedScreenState extends State<FeedScreen> {
  final _futures = [
    VideosAPI.getLatest(),
    VideosAPI.getTrending(),
    VideosAPI.getLivestreams(),
    VideosAPI.getCategories(),
    VideosAPI.getSeries(),

  ];

  @override
  void initState() {
    super.initState();
    BackgroundCarouselController.init();
    SelectedVideoController.init();
    FeedController.init();
    NavBarFocusController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
          stream: FeedController.stream,
          initialData: 0,
          builder: (context, index) => FutureBuilder(
            future: _futures[index.data],
            builder: (context, response) => response.connectionState !=
                        ConnectionState.done ||
                    response.hasError
                ? Center(
                    child: response.hasError
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(response.error.toString()),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: CircularProgressIndicator(),
                          ),
                  )
                : index.data < 2
                    ? LatestAndTrendingDisplay(
                        videoRows: response.data.response.rows,
                      )
                    : index.data == 2
                        ? LivestreamsDisplay(response: response.data)
                        : CategoriesDisplay(response: response.data),
          ),
        ),
        NavigationBar(),
      ],
    );
  }

  @override
  void dispose() {
    NavBarFocusController.dispose();
    SelectedVideoController.dispose();
    BackgroundCarouselController.dispose();
    FeedController.dispose();
    super.dispose();
  }
}
