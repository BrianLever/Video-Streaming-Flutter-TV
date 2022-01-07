
import 'package:americonictv_tv/logic/api/videos.dart';
import 'package:americonictv_tv/ui/screens/feed/categories_ee/Serieslist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/ui/screens/feed/bloc/selected_video_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/carousel/bg/bloc/bg_carousel_index_controller.dart';
import 'package:americonictv_tv/ui/screens/video_view/video_view_screen.dart';

class NavCarouselEntry extends StatefulWidget {
  final VideoData video;
  final ScrollController scrollController;
  final FocusNode focusNode;
  int length, index;

  NavCarouselEntry({
    @required this.video,
    @required this.scrollController,
    @required this.length,
    @required this.focusNode,
    @required this.index,
  });

  @override
  State<StatefulWidget> createState() {
    return _NavCarouselEntryState();
  }
}

class _NavCarouselEntryState extends State<NavCarouselEntry> {
  bool _isFocused = false;
  static final _animationDuration = const Duration(milliseconds: 300);

  final _futures = [
    VideosAPI.getSeries(),
  ];
  Future<void> _scrollTo(double offset) async => await widget.scrollController
      .animateTo(offset, duration: _animationDuration, curve: Curves.ease);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.ease,
        width: MediaQuery
            .of(context)
            .size
            .width / (_isFocused ? 3.6 : 4.5),
        height: MediaQuery
            .of(context)
            .size
            .height,
        margin: EdgeInsets.fromLTRB(
            widget.index == 0 ? 12 : 0, _isFocused ? 0 : 50, 12, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[_isFocused ? 16 : 0],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.video.images.thumbsJpg,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5,
                            color: _isFocused
                                ? Colors.red
                                : Colors.transparent
                        ),
                      ),
                    ),

                    AnimatedOpacity(
                      opacity: _isFocused ? 0 : 0.6,
                      duration: _animationDuration,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black54,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 25.0, // soften the shadow
                              spreadRadius: 5.0, //extend the shadow
                              offset: Offset(
                                15.0, // Move to right 10  horizontally
                                15.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],),
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedOpacity(
                  opacity: _isFocused ? 0 : 1,
                  duration: _animationDuration,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Rubik',
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                widget.video.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.video.viewsCount.toString() +
                                      ' views',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(
              builder: widget.video.videos!=null? (BuildContext context) =>
                  VideoViewScreen(video: widget.video):(BuildContext context) =>SerieslistDisplay(response: widget.video.playlists))),
      onFocusChange: (isFocused) {
        if (_isFocused && !isFocused) SelectedVideoController.change(null);
        setState(() => _isFocused = isFocused);
        if (isFocused) {
          _scrollTo(
              widget.index * (MediaQuery
                  .of(context)
                  .size
                  .width / 4.5 + 12));
          BackgroundCarouselController.change(widget.index % widget.length);
          SelectedVideoController.change(widget.video);
        }
      },
    );
  }




}
