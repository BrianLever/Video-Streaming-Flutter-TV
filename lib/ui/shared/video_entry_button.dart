import 'package:americonictv_tv/ui/screens/feed/categories_ee/Serieslist_page.dart';
import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/ui/screens/video_view/video_view_screen.dart';

class VideoEntryButton extends StatefulWidget {
  final double width, height, borderRadius;
  final VideoData video;
  final Function onTap;
  final FocusNode focusNode;
  final Color color, focusColor, textColor;
  final bool autofocus, inverted;
  final int index;
  final EdgeInsets padding;
  final bool animated;

  VideoEntryButton({
    @required this.width,
    @required this.height,
    @required this.video,
    this.onTap,
    this.focusNode,
    this.color,
    this.focusColor,
    this.textColor,
    this.autofocus: false,
    this.borderRadius,
    this.inverted: false,
    this.index,
    this.padding,
    this.animated: true,
  });

  @override
  State<StatefulWidget> createState() {
    return _VideoEntryButtonState();
  }
}

class _VideoEntryButtonState extends State<VideoEntryButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addListener(() => setState(() {}));
    _scale = Tween<double>(begin: 1, end: 1.05).animate(_animationController);
  }

  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [
        InkWell(
        autofocus: widget.autofocus,
        focusColor: widget.focusColor ?? Theme.of(context).focusColor,
        focusNode: widget.focusNode,
        child: Transform.scale(
          scale: widget.animated ? _scale.value : 1,
          child: Padding(
            padding:
            widget.padding != null ? widget.padding : EdgeInsets.zero,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: widget.color ?? widget.inverted
                      ? Colors.white70
                      : Colors.black54,
                  boxShadow: _isFocused && widget.focusColor == null
                  ? [
                  BoxShadow(
                    color: widget.inverted
                        ? Colors.white70
                        : Colors.black54,
                  ),
                  ]
                      : null,
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            ),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? 0,
              ),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: Stack(
                  children: [
                    Image.network(
                      widget.video.images.thumbsJpg,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                    if (_isFocused)
                      Container(
                        decoration: BoxDecoration(
                          color: widget.inverted
                              ? Colors.white70
                              : Colors.black54,
                          border: Border.all(
                            color: _isFocused
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Stack(
                          children: [
                            Text(
                              widget.video.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = _isFocused
                                      ? widget.inverted
                                      ? Colors.white70
                                      : Colors.black54
                                      : Colors.black54,
                              ),
                            ),
                            Text(
                              widget.video.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _isFocused
                                    ? Theme.of(context).primaryColor
                                    : widget.textColor ?? Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
          onTap: () {
          if(widget.video.playlists!=null){
               Navigator.of(context).push(MaterialPageRoute(
               builder:(BuildContext context) =>
            SerieslistDisplay(response: widget.video.playlists)));
           }
          else{
             Navigator.of(context).push(MaterialPageRoute(
               builder:(BuildContext context) =>
                VideoViewScreen(video: widget.video)));
            }

            if (widget.onTap != null) widget.onTap();
          },
          onFocusChange: (isFocused) {
            _isFocused = isFocused;
            _isFocused
                ? _animationController.forward()
                : _animationController.reverse();
            },
        ),
      ],
    );



  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
