
import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/models/category_model.dart';
import 'package:americonictv_tv/logic/api/videos.dart';
import 'package:americonictv_tv/ui/screens/feed/categories/bloc/selected_category_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/categories/category_entry.dart';
import 'package:americonictv_tv/ui/screens/feed/navigation_bar/navigation_bar.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';
import 'package:americonictv_tv/ui/shared/future_no_data.dart';
import 'package:americonictv_tv/ui/shared/video_entry_button.dart';

class CategoriesDisplay extends StatefulWidget {
  final CategoryResponse response;

  CategoriesDisplay({@required this.response});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesDisplayState();
  }
}

class _CategoriesDisplayState extends State<CategoriesDisplay> {
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

  int _currentPage = 1;
  int _seriesFilter;

  final _seriesFilterFocusNode = FocusNode();
  final _moviesFilterFocusNode = FocusNode();

  Key _futureKey = UniqueKey();

  void _seriesFilterOnTap(int option) => setState(() {
    _futureKey = UniqueKey();
    _seriesFilter = _seriesFilter == option ? null : option;
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Row(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: SelectedCategoryController.stream,
              builder: (context, category) => !category.hasData
                  ? Center(
                      child: Text(
                  'Select a category',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              )
                  : FutureBuilder(
                   key: _futureKey,
                  future: VideosAPI.getVideosByCategory(
                    category.data, _currentPage, _seriesFilter),
                   builder: (context, videos) => videos.connectionState !=
                    ConnectionState.done ||
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
                            'No videos found in this category',
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
                        itemCount:videos.data.response.rows.length,
                        padding: const EdgeInsets.only(left: 12),
                        itemBuilder: (context, i) => VideoEntryButton(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        video: videos.data.response.rows[i],
                        animated: false,
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
                                  5,
                              height: 36,
                              label: 'PREVIOUS PAGE',
                              inverted: true,
                              onTap: () =>
                                  setState(() => _currentPage -= 1),
                            ),
                          if (videos.data.response.rows.length >
                              60 &&
                              _currentPage != 1)
                            const SizedBox(width: 16),
                          if (videos.data.response.rows.length > 6)
                            FocusableButton(
                              focusNode: _goToTopButtonFocusNode,
                              width: MediaQuery.of(context)
                                  .size
                                  .width /
                                  5,
                              height: 36,
                              label: 'GO TO TOP',
                              inverted: true,
                              onTap: () {
                                _scrollTo(0);
                                FocusScope.of(context).requestFocus(
                                    NavigationBar.state
                                        .categoriesButtonFocusNode);
                              },
                            ),
                          if (videos.data.response.rows.length ==
                              60)
                            const SizedBox(width: 16),
                          if (videos.data.response.rows.length ==
                              60)
                            FocusableButton(
                              focusNode: _nextPageButtonFocusNode,
                              width: MediaQuery.of(context)
                                  .size
                                  .width /
                                  5,
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
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30,0,30,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CategoryEntry(
                    label: 'Movies',
                    onTap: () => _seriesFilterOnTap(0),
                    filter: _seriesFilter,
                    index: 0,
                  ),
                  CategoryEntry(
                    label: 'Series',
                    onTap: () => _seriesFilterOnTap(1),
                    filter: _seriesFilter,
                    index: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'CATEGORIES',
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        for (int i = 0;
                        i < widget.response.response.length;
                        i++)
                          CategoryEntry(
                            category: widget.response.response[i],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
     SelectedCategoryController.dispose();
    _scrollController.dispose();
    _previousPageFocusNode.dispose();
    _goToTopButtonFocusNode.dispose();
    _nextPageButtonFocusNode.dispose();
    _seriesFilterFocusNode.dispose();
    _moviesFilterFocusNode.dispose();
    super.dispose();
  }
}
