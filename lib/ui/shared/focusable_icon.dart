import 'package:flutter/material.dart';

class FocusableIcon extends StatefulWidget {
  final IconData icon;
  final Function onTap;
  final bool autoFocus;
  final FocusNode focusNode;
  final Color focusColor;
  final bool canRequestFocus;

  FocusableIcon({
    @required this.icon,
    @required this.onTap,
    this.autoFocus: false,
    this.focusNode,
    this.focusColor,
    this.canRequestFocus: true,
  });

  @override
  State<StatefulWidget> createState() {
    return _FocusableIconState();
  }
}

class _FocusableIconState extends State<FocusableIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() => setState(() {}));
    _scale = Tween<double>(begin: 1, end: 1.2).animate(_animationController);
  }

  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      canRequestFocus: widget.canRequestFocus,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      child: Transform.scale(
        scale: _scale.value,
        child: Icon(
          widget.icon,
          size: 26,
          color: _isFocused
              ? (widget.focusColor ?? Colors.red.shade300)
              : Colors.white70,
        ),
      ),
      onTap: () => widget.onTap(),
      onFocusChange: (isFocused) {
        _isFocused = isFocused;
        if (_isFocused)
          _animationController.forward();
        else
          _animationController.reverse();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
