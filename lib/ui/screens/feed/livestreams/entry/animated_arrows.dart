import 'package:flutter/material.dart';

class AnimatedArrows extends StatefulWidget {
  final int index, length;

  AnimatedArrows({
    @required this.index,
    @required this.length,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimatedArrowsState();
  }
}

class _AnimatedArrowsState extends State<AnimatedArrows>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          _animationController
              .reverse()
              .whenComplete(() => _animationController.forward());
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animation.value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.index != 0
              ? Icon(Icons.keyboard_arrow_left, size: 60)
              : const SizedBox(),
          widget.index < widget.length - 1
              ? Icon(Icons.keyboard_arrow_right, size: 60)
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
