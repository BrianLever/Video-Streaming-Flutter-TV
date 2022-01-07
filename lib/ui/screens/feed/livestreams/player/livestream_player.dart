import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:americonictv_tv/ui/shared/focusable_icon.dart';
import 'package:video_player/video_player.dart';

class LivestreamPlayer extends StatefulWidget {
  final VideoPlayerController playerController;

  LivestreamPlayer({@required this.playerController});

  @override
  State<StatefulWidget> createState() {
    return _LivestreamPlayerState();
  }
}

class _LivestreamPlayerState extends State<LivestreamPlayer> {
  final _keyboardListenerNode = FocusNode(canRequestFocus: false);

  final _visibilityController = StreamController.broadcast();

  Timer _timer;
  void _setTimer() {
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 5),
      () => _visibilityController.add(false),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.playerController.play().whenComplete(() => _setTimer());
  }

  bool _muted = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          SizedBox.expand(
            child: Center(
              child: AspectRatio(
                aspectRatio: widget.playerController.value.aspectRatio,
                child: VideoPlayer(widget.playerController),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: RawKeyboardListener(
              focusNode: _keyboardListenerNode,
              child: StreamBuilder(
                stream: _visibilityController.stream,
                initialData: true,
                builder: (context, visible) => AnimatedOpacity(
                  opacity: visible.data ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black54,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FocusableIcon(
                              icon: Icons.stop,
                              onTap: () =>
                                  visible.data ? Navigator.pop(context) : null,
                            ),
                            const SizedBox(width: 12),
                            FocusableIcon(
                              icon: _muted ? Icons.volume_off : Icons.volume_up,
                              onTap: () async {
                                setState(() => _muted = !_muted);
                                await widget.playerController
                                    .setVolume(_muted ? 0 : 1);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onKey: (key) {
                if (key.runtimeType == RawKeyDownEvent) {
                  _visibilityController.add(true);
                  _setTimer();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _keyboardListenerNode.dispose();
    _visibilityController.close();
    widget.playerController.dispose();
    super.dispose();
  }
}
