import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:americonictv_tv/data/user_data.dart';
import 'package:americonictv_tv/global/button_keycodes.dart';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/logic/api/social.dart';
import 'package:americonictv_tv/logic/cache/prefs.dart';
import 'package:americonictv_tv/logic/string_processing.dart';
import 'package:americonictv_tv/ui/screens/channel_view/channel_view_screen.dart';
import 'package:americonictv_tv/ui/screens/video_view/bloc/buffering_controller.dart';
import 'package:americonictv_tv/ui/screens/video_view/player/player_screen.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';
import 'package:video_player/video_player.dart';

class VideoViewScreen extends StatefulWidget {
  final VideoData video;

  VideoViewScreen({@required this.video});

  @override
  State<StatefulWidget> createState() {
    return _VideoViewScreenState();
  }
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  VideoPlayerController _videoPlayerController;

  int _currentPosition;

  StreamController _positionController;
  void _setPositionController(
      [int currenPosition = 0, VideoPlayerController controller]) {
    _currentPosition = currenPosition;
    _positionController = StreamController.broadcast();
    VideoPlayerController currentController =
        controller ?? _videoPlayerController;
    currentController.addListener(() {
      _currentPosition = currentController.value.position.inSeconds;
      _positionController.add(currentController.value.position.inSeconds);
      if (currentController.value.isBuffering && !BufferingController.buffering)
        BufferingController.change(true);
      else if (!currentController.value.isBuffering &&
          BufferingController.buffering) BufferingController.change(false);
    });
  }

  bool _animated = false;

  Set<String> _videoQualities;

  bool _favorited;
  Future<void> _favorite() async {
    if (User.loggedIn) {
      try {
        if (!_favorited) {
          await Social.favorite(widget.video.id);
        } else {
          await Social.removeFavorite(widget.video.id);
        }
        setState(() => _favorited = !_favorited);
        await Prefs.instance.setBool('${widget.video.id} saved', _favorited);
      } catch (e) {
        print('$e');
      }
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must be logged in to do that')));
  }

  bool _watchLatered;
  Future<void> _watchLater() async {
    if (User.loggedIn) {
      try {
        if (!_watchLatered) {
          await Social.watchLater(widget.video.id);
        } else {
          await Social.removeWatchLater(widget.video.id);
        }
        setState(() => _watchLatered = !_watchLatered);
        await Prefs.instance.setBool('${widget.video.id} later', _watchLatered);
      } catch (e) {
        print('$e');
      }
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must be logged in to do that')));
  }

  final _keyboardListenerFocusNode = FocusNode(canRequestFocus: false);
  final _descriptionScrollController =
      ScrollController(initialScrollOffset: 8000);
  final _descriptionFocusNode = FocusNode();
  final _descriptionFocusController = StreamController.broadcast();
  StreamSubscription _descriptionFocusSubscription;

  @override
  void initState() {
    super.initState();
    _favorited = Prefs.instance.getBool('${widget.video.id} saved') ?? false;
    _watchLatered = Prefs.instance.getBool('${widget.video.id} later') ?? false;

      _videoQualities = {
        widget.video.videos.mp4.hd,
        widget.video.videos.mp4.sd,
        widget.video.videos.mp4.low
      };
      _videoQualities.removeWhere((element) => element == null);
      _videoPlayerController =
          VideoPlayerController.network(_videoQualities.elementAt(0) ?? '');


    BufferingController.init();
    _descriptionFocusSubscription =
        _descriptionFocusController.stream.listen((event) {});
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) setState(() => _animated = true);
            }));
  }

  Future<bool> _getLargeImage() async {
    await precacheImage(
      NetworkImage(widget.video.images.poster),
      context,
    );
    return true;
  }

  Future<void> _changeVideoQuality(String videoURL) async {
    _videoPlayerController.pause();
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    final int currentPositionInSecs =
        (_videoPlayerController.value.position.inMilliseconds / 1000).round();
    try {
      _videoPlayerController.removeListener(() {});
      final _newPlayerController = VideoPlayerController.network(videoURL);
      await _newPlayerController.initialize();
      await _newPlayerController
          .seekTo(Duration(seconds: currentPositionInSecs));
      _setPositionController(currentPositionInSecs, _newPlayerController);
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => VideoPlayerScreen(
            UniqueKey(),
            playerController: _newPlayerController,
            positionController: _positionController,
            currentPosition: _currentPosition,
            video: widget.video,
            videoQualities: _videoQualities,
            changeVideoQuality: _changeVideoQuality,
          ),
        ),
      );
      await _videoPlayerController.dispose();
      _videoPlayerController = _newPlayerController;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _getLargeImage(),
            builder: (context, cached) => AnimatedCrossFade(
              firstChild: Image.network(
                widget.video.images.thumbsJpg,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              secondChild: Image.network(
                widget.video.images.poster,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              crossFadeState: cached.hasData
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              curve: Curves.ease,
              opacity: _animated ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black87,
                            Colors.black.withOpacity(0),
                          ],
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 30, 30),
                    child: Stack(
                      children: [
                        Text(
                          widget.video.title,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.black,
                          ),
                        ),
                        Text(
                          widget.video.title,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: User.loggedIn
                                    ? const EdgeInsets.symmetric(vertical: 10)
                                    : EdgeInsets.zero,
                                child: FocusableButton(
                                  width: 160,
                                  height: 36,
                                  label: 'Channel',
                                  inverted: true,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChannelViewScreen(
                                        channelName: widget.video.name,
                                        channel: widget.video.channelName,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (User.loggedIn)
                                FocusableButton(
                                  width: 160,
                                  height: 36,
                                  inverted: !_favorited,
                                  label: 'Favorite',
                                  color: _favorited ? Colors.green : null,
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Center(
                                            child:
                                                CircularProgressIndicator()));
                                    try {
                                      await _favorite();
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text('$e')));
                                    }
                                    Navigator.pop(context);
                                  },
                                ),
                              if (User.loggedIn)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: FocusableButton(
                                    width: 160,
                                    height: 36,
                                    inverted: !_watchLatered,
                                    label: 'Watch Later',
                                    color: _watchLatered ? Colors.green : null,
                                    onTap: () async {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => Center(
                                              child:
                                                  CircularProgressIndicator()));
                                      try {
                                        await _watchLater();
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                SnackBar(content: Text('$e')));
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Stack(
                                  children: [
                                    Text(
                                      '${NumberFormat.compact().format(widget.video.likes)} likes · '
                                      '${NumberFormat.compact().format(widget.video.viewsCount)} views',
                                      style: TextStyle(
                                        fontSize: 12,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1
                                          ..color = Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${NumberFormat.compact().format(widget.video.likes)} likes · '
                                      '${NumberFormat.compact().format(widget.video.viewsCount)} views',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              FocusableButton(
                                width: 160,
                                height: 36,
                                label: 'Play',
                                inverted: true,
                                onTap: (User.instance == null ||
                                            User.instance.subscription !=
                                                    null &&
                                                User.instance.subscription
                                                    .isEmpty) &&
                                        widget.video.onlyForPaid == 1
                                    ? () => ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'You must be subscribed in order to view this video.',
                                            ),
                                          ),
                                        )
                                    : /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              VLCVideoPlayerScreen(
                                                  key: UniqueKey(),
                                                  video: widget.video),
                                        ),
                                      ),*/
                                    () async {
                                        bool error = false;
                                        if (_currentPosition == null) {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) => Center(
                                                  child:
                                                      CircularProgressIndicator()));
                                          try {
                                            await _videoPlayerController
                                                .initialize();
                                            _setPositionController();
                                          } catch (e) {
                                            error = true;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text('$e')));
                                          }
                                          Navigator.pop(context);
                                        }
                                        if (!error) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  VideoPlayerScreen(
                                                UniqueKey(),
                                                playerController:
                                                    _videoPlayerController,
                                                positionController:
                                                    _positionController,
                                                currentPosition:
                                                    _currentPosition,
                                                video: widget.video,
                                                videoQualities: _videoQualities,
                                                changeVideoQuality:
                                                    _changeVideoQuality,
                                              ),
                                            ),
                                          );
                                          FocusScope.of(context)
                                              .previousFocus();
                                        }
                                      },
                              ),
                              const SizedBox(height: 8),
                              FocusableButton(
                                width: 160,
                                height: 36,
                                label: 'Back',
                                autofocus: true,
                                inverted: true,
                                onTap: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: RawKeyboardListener(
                            focusNode: _keyboardListenerFocusNode,
                            child: StatefulBuilder(
                              builder: (context, newState) => InkWell(
                                focusNode: _descriptionFocusNode,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: AnimatedOpacity(
                                    opacity: _descriptionFocusNode.hasFocus
                                        ? 1
                                        : 0.3,
                                    duration: const Duration(milliseconds: 200),
                                    child: Scrollbar(
                                      controller: _descriptionScrollController,
                                      isAlwaysShown: true,
                                      child: ListView(
                                        controller:
                                            _descriptionScrollController,
                                        reverse: true,
                                        children: [
                                          Stack(
                                            children: [
                                              Text(
                                                StringProcessing
                                                    .removeAllHtmlTags(
                                                  widget.video.description,
                                                ),
                                                style: TextStyle(
                                                  foreground: Paint()
                                                    ..style =
                                                        PaintingStyle.stroke
                                                    ..strokeWidth = 1
                                                    ..color = Colors.black,
                                                ),
                                              ),
                                              Text(
                                                StringProcessing
                                                    .removeAllHtmlTags(
                                                  widget.video.description,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {},
                                onFocusChange: (isFocused) => newState(() {}),
                              ),
                            ),
                            onKey: (key) {
                              if (key.runtimeType == RawKeyDownEvent &&
                                  _descriptionFocusNode.hasFocus) {
                                final bool _upKey = key.data
                                    .toString()
                                    .contains('keyCode: ${Buttons.up.code}');
                                final bool _downKey = key.data
                                    .toString()
                                    .contains('keyCode: ${Buttons.down.code}');
                                if (_upKey)
                                  _descriptionScrollController.animateTo(
                                    _descriptionScrollController.offset + 20,
                                    duration: const Duration(milliseconds: 50),
                                    curve: Curves.linear,
                                  );
                                if (_downKey)
                                  _descriptionScrollController.animateTo(
                                    _descriptionScrollController.offset - 20,
                                    duration: const Duration(milliseconds: 50),
                                    curve: Curves.linear,
                                  );
                              }
                            },
                          ),
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
    _positionController?.close();
    _videoPlayerController.dispose();
    BufferingController.dispose();
    _keyboardListenerFocusNode.dispose();
    _descriptionScrollController.dispose();
    _descriptionFocusNode.dispose();
    _descriptionFocusSubscription.cancel();
    _descriptionFocusController.close();
    super.dispose();
  }
}
