

import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/ui/shared/serie_entry_button.dart';
import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/videos.dart';
import 'package:americonictv_tv/ui/screens/feed/categories/bloc/selected_category_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/navigation_bar/navigation_bar.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';
import 'package:americonictv_tv/ui/shared/future_no_data.dart';


class SerieDisplay extends StatefulWidget {
  final Playlist response;

  SerieDisplay({@required this.response});

  @override
  State<StatefulWidget> createState() {
    return _SerieDisplayState();
  }
}

class _SerieDisplayState extends State<SerieDisplay> {
  final _scrollController = ScrollController();
  final _previousPageFocusNode = FocusNode();
  final _goToTopButtonFocusNode = FocusNode();
  final _nextPageButtonFocusNode = FocusNode();

  Future<void> _scrollTo(double offset) async =>
      await _scrollController.animateTo(offset,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);

  @override
  void initState() {
    super.initState();
    SelectedCategoryController.init();
    _previousPageFocusNode.addListener(() {
      if (_previousPageFocusNode.hasFocus)
        _scrollTo(_scrollController.position.maxScrollExtent);
    });
    _goToTopButtonFocusNode.addListener(() {
      if (_goToTopButtonFocusNode.hasFocus)
        _scrollTo(_scrollController.position.maxScrollExtent);
    });
    _nextPageButtonFocusNode.addListener(() {
      if (_nextPageButtonFocusNode.hasFocus)
        _scrollTo(_scrollController.position.maxScrollExtent);
    });
  }

  Key _futureKey = UniqueKey();



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: SelectedCategoryController.stream,
              builder: (context, category) =>
                   FutureBuilder(
                     key: _futureKey,
                    future: VideosAPI.getVideosByPlaylist(widget.response.seriePlaylistsId
                    ),
                     builder: (context, videos) => videos.connectionState !=
                    ConnectionState.done
                        ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                           height: MediaQuery.of(context).size.height -
                           kToolbarHeight,
                           child: videos.hasData
                               ? Center(
                                 child: Text(
                              'No videos found',
                                style: const TextStyle(
                                color: Colors.white,
                                  fontSize: 22,
                               ),
                              ),
                         )
                             : FutureBuilderNoData(videos),
                )
                    : ListView(
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
                            itemCount:videos.data.response.videos.length,
                            padding: const EdgeInsets.only(left: 12),
                            itemBuilder: (context, i) => SerieEntryButton(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              video: videos.data.response.videos[i],
                              animated: false,
                      ),
                    ),
                    //   Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 16,
                    //   ),
                    //    child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       if (_currentPage != 1)
                    //         FocusableButton(
                    //           focusNode: _previousPageFocusNode,
                    //           width: MediaQuery.of(context)
                    //               .size
                    //               .width /
                    //               5,
                    //           height: 36,
                    //           label: 'PREVIOUS PAGE',
                    //           inverted: true,
                    //           onTap: () =>
                    //               setState(() => _currentPage -= 1),
                    //         ),
                    //       if (videos.data.response.videos.length >
                    //           60 &&
                    //           _currentPage != 1)
                    //         const SizedBox(width: 16),
                    //       if (videos.data.response.videos.length > 6)
                    //         FocusableButton(
                    //           focusNode: _goToTopButtonFocusNode,
                    //           width: MediaQuery.of(context)
                    //               .size
                    //               .width /
                    //               5,
                    //           height: 36,
                    //           label: 'GO TO TOP',
                    //           inverted: true,
                    //           onTap: () {
                    //             _scrollTo(0);
                    //             FocusScope.of(context).requestFocus(
                    //                 NavigationBar.state
                    //                     .categoriesButtonFocusNode);
                    //           },
                    //         ),
                    //       if (videos.data.response.videos.length ==
                    //           60)
                    //         const SizedBox(width: 16),
                    //       if (videos.data.response.videos.length==
                    //           60)
                    //         FocusableButton(
                    //           focusNode: _nextPageButtonFocusNode,
                    //           width: MediaQuery.of(context)
                    //               .size
                    //               .width /
                    //               5,
                    //           height: 36,
                    //           label: 'NEXT PAGE',
                    //           inverted: true,
                    //           onTap: () =>
                    //               setState(() => _currentPage += 1),
                    //         ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  @override
  void dispose() {
     // SelectedCategoryController.dispose();
    _scrollController.dispose();
    _previousPageFocusNode.dispose();
    _goToTopButtonFocusNode.dispose();
    _nextPageButtonFocusNode.dispose();
    super.dispose();
  }
}
