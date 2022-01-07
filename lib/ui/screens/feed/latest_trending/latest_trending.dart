import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/ui/screens/feed/bloc/selected_video_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/carousel/bg/bg_carousel.dart';
import 'package:americonictv_tv/ui/screens/feed/carousel/navigation/navigation_carousel.dart';

class LatestAndTrendingDisplay extends StatefulWidget {
  final List<VideoData> videoRows;

  LatestAndTrendingDisplay({@required this.videoRows});

  @override
  State<StatefulWidget> createState() {
    return _LatestAndTrendingDisplayState();
  }
}

class _LatestAndTrendingDisplayState extends State<LatestAndTrendingDisplay>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        SizedBox.expand(
          child: BackgroundCarousel(
            thumbnails: [
              for (var row in widget.videoRows) row.images.thumbsJpg,
            ],
            hqImages: [
              for (var row in widget.videoRows) row.images.poster,
            ],
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1.2,
              focalRadius: 0.5,
              colors: [
                Colors.black.withAlpha(0),
                Colors.black12,
                Colors.black54,
                Colors.black87,
              ],
            ),
          ),
          child: SizedBox.expand(),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black45,
                Colors.black.withAlpha(0),
              ],
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: NavigationCarousel(
              videoRows: widget.videoRows,
            ),
          ),
        ),
        Positioned(
          bottom: 212,
          left: 12,
          right: 12,
          child: StreamBuilder(
            stream: SelectedVideoController.stream,
            builder: (context, video) => AnimatedOpacity(
              opacity: video.hasData ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: (video.data?.category ?? '') + '\n',
                          style: TextStyle(
                            fontSize: 18,
                            foreground: Paint()
                              ..strokeWidth = 2
                              ..color = Colors.black
                              ..style = PaintingStyle.stroke,
                          ),
                        ),
                        TextSpan(
                          text: video.data?.title ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            foreground: Paint()
                              ..strokeWidth = 2
                              ..color = Colors.black
                              ..style = PaintingStyle.stroke,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: (video.data?.category ?? '') + '\n',
                          style: const TextStyle(fontSize: 18),
                        ),
                        TextSpan(
                          text: video.data?.title ?? '',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
