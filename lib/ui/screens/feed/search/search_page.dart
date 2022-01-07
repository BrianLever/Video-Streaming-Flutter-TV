import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:americonictv_tv/global/button_keycodes.dart';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/logic/api/videos.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';
import 'package:americonictv_tv/ui/shared/focusable_icon.dart';
import 'package:americonictv_tv/ui/shared/future_no_data.dart';
import 'package:americonictv_tv/ui/shared/video_entry_button.dart';

enum KeyboardMode { alphabetical, numerical }

class CustomKeyboardSymbol extends StatefulWidget {
  final String symbol;
  final Function onTap;
  final FocusNode focusNode;
  final double width;

  CustomKeyboardSymbol({
    @required this.symbol,
    @required this.onTap,
    this.focusNode,
    this.width,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomKeyboardSymbolState();
  }
}

class _CustomKeyboardSymbolState extends State<CustomKeyboardSymbol> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: widget.focusNode,
      child: AnimatedOpacity(
        opacity: _isFocused ? 1 : 0.4,
        duration: const Duration(milliseconds: 200),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(3),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: widget.width != null
                ? const EdgeInsets.symmetric(vertical: 5)
                : const EdgeInsets.all(5),
            child: SizedBox(
              width: widget.width,
              child: Center(
                child: Text(
                  widget.symbol.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: () => widget.onTap(),
      onFocusChange: (isFocused) => setState(() => _isFocused = isFocused),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchTermController = TextEditingController();

  static final _letters = const [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];

  static final _numbers = const [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];

  final _keyboardListenerFocusNode = FocusNode(canRequestFocus: false);
  final _leftMostFocusNode = FocusNode();
  final _rightMostFocusNode = FocusNode();

  final _modeController = StreamController.broadcast();

  int _currentPage = 1;

  int _seriesFilter;

  Key _futureKey = UniqueKey();

  void _seriesFilterOnTap(int option) => setState(() {
        _futureKey = UniqueKey();
        _seriesFilter = _seriesFilter == option ? null : option;
      });

  final _searchController = StreamController.broadcast();

  final _scrollController = ScrollController();

  final _previousPageFocusNode = FocusNode();
  final _goToTopButtonFocusNode = FocusNode();
  final _nextPageButtonFocusNode = FocusNode();
  final _closeButtonFocusNode = FocusNode();

  void _scrollTo(double offset) => _scrollController.animateTo(offset,
      duration: const Duration(milliseconds: 300), curve: Curves.ease);

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          controller: _searchTermController,
                          decoration: InputDecoration(
                            hintText: 'Enter a search term',
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      FocusableButton(
                        width: 100,
                        height: 30,
                        label: 'Series',
                        textColor: _seriesFilter == 1 ? Colors.white : null,
                        fontWeight: _seriesFilter == 1 ? FontWeight.bold : null,
                        onTap: () => _seriesFilterOnTap(1),
                      ),
                      FocusableButton(
                        width: 100,
                        height: 30,
                        label: 'Movies',
                        textColor: _seriesFilter == 0 ? Colors.white : null,
                        fontWeight: _seriesFilter == 0 ? FontWeight.bold : null,
                        onTap: () => _seriesFilterOnTap(0),
                      ),
                      FocusableIcon(
                        focusNode: _closeButtonFocusNode,
                        autoFocus: true,
                        icon: Icons.close,
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RawKeyboardListener(
                      focusNode: _keyboardListenerFocusNode,
                      child: StreamBuilder(
                        stream: _modeController.stream,
                        initialData: KeyboardMode.alphabetical,
                        builder: (context, mode) => Row(
                          mainAxisAlignment:
                              mode.data == KeyboardMode.alphabetical
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.center,
                          children: [
                            CustomKeyboardSymbol(
                              focusNode: _leftMostFocusNode,
                              symbol: mode.data == KeyboardMode.alphabetical
                                  ? '123'
                                  : 'ABC',
                              onTap: () => _modeController.add(
                                  mode.data == KeyboardMode.alphabetical
                                      ? KeyboardMode.numerical
                                      : KeyboardMode.alphabetical),
                            ),
                            if (mode.data == KeyboardMode.numerical)
                              const SizedBox(width: 8),
                            CustomKeyboardSymbol(
                              symbol: 'SPACE',
                              onTap: () => _searchTermController.text =
                                  _searchTermController.text + ' ',
                            ),
                            if (mode.data == KeyboardMode.numerical)
                              const SizedBox(width: 8),
                            for (var symbol
                                in mode.data == KeyboardMode.alphabetical
                                    ? _letters
                                    : _numbers)
                              Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        mode.data == KeyboardMode.alphabetical
                                            ? 0
                                            : 8),
                                child: CustomKeyboardSymbol(
                                  symbol: symbol,
                                  onTap: () => _searchTermController.text =
                                      _searchTermController.text +
                                          symbol.toUpperCase(),
                                  width: 20,
                                ),
                              ),
                            CustomKeyboardSymbol(
                              symbol: '⌫',
                              onTap: () {
                                if (_searchTermController.text.isNotEmpty)
                                  _searchTermController.text =
                                      _searchTermController.text.substring(
                                          0,
                                          _searchTermController.text.length -
                                              1);
                              },
                            ),
                            if (mode.data == KeyboardMode.numerical)
                              const SizedBox(width: 8),
                            CustomKeyboardSymbol(
                              focusNode: _rightMostFocusNode,
                              symbol: '🔍',
                              onTap: () => _searchController
                                  .add(_searchTermController.text),
                            ),
                          ],
                        ),
                      ),
                      onKey: (key) {
                        if (key.runtimeType == RawKeyDownEvent) {
                          final bool _leftKey = key.data
                              .toString()
                              .contains('keyCode: ${Buttons.left.code}');
                          final bool _rightKey = key.data
                              .toString()
                              .contains('keyCode: ${Buttons.right.code}');
                          if (_leftKey && _leftMostFocusNode.hasFocus)
                            _rightMostFocusNode.requestFocus();
                          else if (_rightKey && _rightMostFocusNode.hasFocus)
                            _leftMostFocusNode.requestFocus();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _searchController.stream,
              initialData: '',
              builder: (context, term) => FutureBuilder(
                key: _futureKey,
                future: VideosAPI.searchVideos(
                    term.data, _currentPage, _seriesFilter),
                builder: (context, AsyncSnapshot<VideosResponse> videos) =>
                    !term.hasData ||
                            videos.connectionState != ConnectionState.done ||
                            videos.hasError ||
                            videos.hasData && videos.data.error != false ||
                            videos.hasData && videos.data.response.rows.isEmpty
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height -
                                kToolbarHeight,
                            child: videos.hasData &&
                                    term.hasData &&
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
                        : ListView(
                            shrinkWrap: true,
                            controller: _scrollController,
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 16 / 10,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        height: 36,
                                        label: 'PREVIOUS PAGE',
                                        inverted: true,
                                        onTap: () =>
                                            setState(() => _currentPage -= 1),
                                      ),
                                    if (videos.data.response.rows.length > 6 &&
                                        _currentPage != 1)
                                      const SizedBox(width: 16),
                                    if (videos.data.response.rows.length > 6)
                                      FocusableButton(
                                        focusNode: _goToTopButtonFocusNode,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        height: 36,
                                        label: 'GO TO TOP',
                                        inverted: true,
                                        onTap: () {
                                          _scrollTo(0);
                                          _closeButtonFocusNode.requestFocus();
                                        },
                                      ),
                                    const SizedBox(width: 16),
                                    if (videos.data.response.rows.length == 60)
                                      FocusableButton(
                                        focusNode: _nextPageButtonFocusNode,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        height: 36,
                                        label: 'NEXT PAGE',
                                        inverted: true,
                                        onTap: () =>
                                            setState(() => _currentPage += 1),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _closeButtonFocusNode.dispose();
    _previousPageFocusNode.dispose();
    _goToTopButtonFocusNode.dispose();
    _nextPageButtonFocusNode.dispose();
    _keyboardListenerFocusNode.dispose();
    _leftMostFocusNode.dispose();
    _rightMostFocusNode.dispose();
    _modeController.close();
    _searchTermController.dispose();
    super.dispose();
  }
}
