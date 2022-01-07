import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedBgGradient extends StatefulWidget {
  @override
  _AnimatedBgGradientState createState() => _AnimatedBgGradientState();
}

class _AnimatedBgGradientState extends State<AnimatedBgGradient> {
  List<Color> _colors = [
    Colors.black54,
    Colors.black87,
    Colors.black.withOpacity(.7),
    Colors.black.withOpacity(.63)
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];

  int _index = 0;
  Color _bottomColor = Colors.black38;
  Color _topColor = Colors.black87;
  Alignment _begin = Alignment.bottomLeft;
  Alignment _end = Alignment.topRight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(
        () {
          _index++;
          _bottomColor = _colors[_index % _colors.length];
          _topColor = _colors[(_index + 1) % _colors.length];
          _begin = alignmentList[_index % alignmentList.length];
          _end = alignmentList[(_index + 2) % alignmentList.length];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.99,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: AnimatedContainer(
              duration: Duration(seconds: 10),
              onEnd: () => setState(
                () {
                  _index++;
                  _bottomColor = _colors[_index % _colors.length];
                  _topColor = _colors[(_index + 1) % _colors.length];
                  _begin = alignmentList[_index % alignmentList.length];
                  _end = alignmentList[(_index + 2) % alignmentList.length];
                },
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: _begin,
                  end: _end,
                  tileMode: TileMode.decal,
                  colors: [_bottomColor, _topColor],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
