import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:americonictv_tv/global/button_keycodes.dart';
import 'package:americonictv_tv/ui/screens/feed/livestreams/entry/animated_arrows.dart';
import 'package:americonictv_tv/ui/screens/feed/livestreams/player/livestream_player.dart';
import 'package:americonictv_tv/ui/screens/feed/navigation_bar/bloc/focus_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/navigation_bar/navigation_bar.dart';
import 'package:video_player/video_player.dart';

class LivestreamEntry extends StatefulWidget {
  final int index, length;
  final Map livestream;
  final num viewers;
  final ScrollController scrollController;

  LivestreamEntry({
    @required this.index,
    @required this.length,
    @required this.livestream,
    @required this.viewers,
    @required this.scrollController,
  });

  @override
  State<StatefulWidget> createState() {
    return _LivestreamEntryState();
  }
}

class _LivestreamEntryState extends State<LivestreamEntry> {
  final _focusController = StreamController.broadcast();

  final _keyboardListenerFocusNode = FocusNode(canRequestFocus: false);
  final _playButtonFocusNode = FocusNode();

  VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
              image: NetworkImage(widget.livestream['poster']),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder(
            stream: _focusController.stream,
            initialData: false,
            builder: (context, inFocus) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: SizedBox.expand(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (inFocus.data)
                      AnimatedArrows(
                        index: widget.index,
                        length: widget.length,
                      ),
                    RawKeyboardListener(
                      focusNode: _keyboardListenerFocusNode,
                      child: InkWell(
                        autofocus: widget.index != 0,
                        focusNode: _playButtonFocusNode,
                        child: Icon(
                          Icons.play_arrow,
                          color: inFocus.data ? Colors.white : Colors.white24,
                          size: 100,
                        ),
                        onTap: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) =>
                                  Center(child: CircularProgressIndicator()));
                          final playerController =
                              VideoPlayerController.network(
                                  widget.livestream['source']);
                          try {
                            await playerController.initialize();
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    LivestreamPlayer(
                                  playerController: playerController,
                                ),
                              ),
                            );
                          } catch (e) {
                            Navigator.pop(context);
                            playerController.dispose();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('$e')));
                          }
                        },
                        onFocusChange: (isFocused) {
                          if (isFocused) NavBarFocusController.change(false);
                          _focusController.add(isFocused);
                        },
                      ),
                      onKey: (key) {
                        final bool _upKey = key.data
                            .toString()
                            .contains('keyCode: ${Buttons.up.code}');
                        if (key.runtimeType == RawKeyDownEvent) {
                          final bool _leftKey = key.data
                              .toString()
                              .contains('keyCode: ${Buttons.left.code}');
                          final bool _rightKey = key.data
                              .toString()
                              .contains('keyCode: ${Buttons.right.code}');
                          if (_leftKey && widget.index != 0 ||
                              _rightKey && widget.index < widget.length - 1) {
                            FocusScope.of(context).unfocus();
                            if (_leftKey && widget.index != 0)
                              widget.scrollController.jumpTo(0);
                            else if (_rightKey &&
                                widget.index < widget.length - 1)
                              widget.scrollController.jumpTo(1);
                            Future.delayed(
                              const Duration(milliseconds: 300),
                                  () => FocusScope.of(context).focusInDirection(
                                  _leftKey
                                      ? TraversalDirection.left
                                      : TraversalDirection.right),
                            );
                          } else if (_upKey) NavBarFocusController.change(true);
                        }

                        if (_upKey)
                          NavigationBar.state.liveVideosButtonFocusNode
                              .requestFocus();
                         },

                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.livestream['UserPhoto'],
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          widget.livestream['title'],
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Text(
                    widget.viewers.toString() + ' viewing',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focusController.close();
    _keyboardListenerFocusNode.dispose();
    _playButtonFocusNode.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }
}
