import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/logic/api/videos.dart';
import 'package:americonictv_tv/ui/shared/custom_appbar.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';
import 'package:americonictv_tv/ui/shared/future_no_data.dart';
import 'package:americonictv_tv/ui/shared/video_entry_button.dart';

class ChannelViewScreen extends StatefulWidget {
  final String channelName, channel;

  ChannelViewScreen({@required this.channelName, @required this.channel});

  @override
  State<StatefulWidget> createState() {
    return _ChannelViewScreenState();
  }
}

class _ChannelViewScreenState extends State<ChannelViewScreen> {
  final _scrollController = ScrollController();

  final _closeButtonFocusNode = FocusNode();
  final _previousPageFocusNode = FocusNode();
  final _goToTopButtonFocusNode = FocusNode();
  final _nextPageButtonFocusNode = FocusNode();

  void _scrollTo(double offset) => _scrollController.animateTo(offset,
      duration: const Duration(milliseconds: 300), curve: Curves.ease);

  @override
  void initState() {
    super.initState();
    _closeButtonFocusNode.addListener(() {
      if (_closeButtonFocusNode.hasFocus) _scrollTo(0);
    });
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

  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              shrinkWrap: true,
              controller: _scrollController,
              children: [
                CustomAppBar(
                  label: widget.channelName,
                  closeButtonFocusNode: _closeButtonFocusNode,
                ),
                FutureBuilder(
                  future: VideosAPI.getChannelVideos(
                    widget.channel,
                    _currentPage,
                  ),
                  builder: (context, AsyncSnapshot<VideosResponse> videos) =>
                      videos.connectionState != ConnectionState.done ||
                              videos.hasError ||
                              videos.hasData && videos.data.error != false ||
                              videos.hasData &&
                                  videos.data.response.rows.isEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height -
                                  kToolbarHeight,
                              child: videos.hasData &&
                                      videos.data.response.rows.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No videos found',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                    )
                                  : FutureBuilderNoData(videos),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 16 / 10,
                                  ),
                                  itemCount: videos.data.response.rows.length,
                                  itemBuilder: (context, i) => VideoEntryButton(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    video: videos.data.response.rows[i],
                                    padding: EdgeInsets.fromLTRB(
                                      i % 4 == 0 ? 12 : 6,
                                      6,
                                      (i + 1) % 4 == 0 ? 12 : 6,
                                      6,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_currentPage != 1)
                                        FocusableButton(
                                          focusNode: _previousPageFocusNode,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 36,
                                          label: 'PREVIOUS PAGE',
                                          inverted: true,
                                          onTap: () =>
                                              setState(() => _currentPage -= 1),
                                        ),
                                      if (videos.data.response.rows.length >
                                              6 &&
                                          _currentPage != 1)
                                        const SizedBox(width: 16),
                                      if (videos.data.response.rows.length > 6)
                                        FocusableButton(
                                          focusNode: _goToTopButtonFocusNode,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 36,
                                          label: 'GO TO TOP',
                                          inverted: true,
                                          onTap: () {
                                            _scrollTo(0);
                                            _closeButtonFocusNode
                                                .requestFocus();
                                          },
                                        ),
                                      const SizedBox(width: 16),
                                      if (videos.data.response.rows.length ==
                                          60)
                                        FocusableButton(
                                          focusNode: _nextPageButtonFocusNode,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 36,
                                          label: 'NEXT PAGE',
                                          inverted: true,
                                          onTap: () =>
                                              setState(() => _currentPage += 1),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _previousPageFocusNode.dispose();
    _closeButtonFocusNode.dispose();
    _goToTopButtonFocusNode.dispose();
    _nextPageButtonFocusNode.dispose();
    super.dispose();
  }
}
