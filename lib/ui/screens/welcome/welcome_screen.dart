import 'dart:async';

import 'package:flutter/material.dart';
import 'package:americonictv_tv/ui/bloc/main_view_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/feed_screen.dart';
import 'package:americonictv_tv/ui/screens/user_auth/login/login_display.dart';
import 'package:americonictv_tv/ui/screens/user_auth/register/register_display.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';

class _MenuOption extends StatelessWidget {
  final Stream stream;
  final int index;
  final String label;
  final FocusNode focusNode;
  final Function onTap;

  _MenuOption({
    @required this.stream,
    @required this.index,
    @required this.label,
    @required this.focusNode,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder(
          stream: stream,
          initialData: 0,
          builder: (context, selected) => DecoratedBox(
            decoration: BoxDecoration(
              color: selected.data == index ? Colors.white : Colors.transparent,
            ),
            child: const SizedBox(width: 0.5, height: 100),
          ),
        ),
        FocusableButton(
          focusNode: focusNode,
          width: MediaQuery.of(context).size.width / 5,
          height: 50,
          label: label,
          fontSize: 22,
          autofocus: true,
          borderRadius: 32,
          onTap: onTap,
          color: Colors.transparent,
          focusColor: Colors.transparent,
        ),
        StreamBuilder(
          stream: stream,
          initialData: 0,
          builder: (context, selected) => DecoratedBox(
            decoration: BoxDecoration(
              color: selected.data == index ? Colors.white : Colors.transparent,
            ),
            child: const SizedBox(width: 0.5, height: 100),
          ),
        ),
      ],
    );

  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _hidden = false;

  final _animationDuration = const Duration(milliseconds: 800);

  final _loginButtonFocusNode = FocusNode();
  final _registerButtonFocusNode = FocusNode();

  void _authSuccess() => MainViewController.change(FeedScreen());

  final _selectedButtonController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _loginButtonFocusNode.addListener(() {
      if (_loginButtonFocusNode.hasFocus) _selectedButtonController.add(0);
    });
    _registerButtonFocusNode.addListener(() {
      if (_registerButtonFocusNode.hasFocus) _selectedButtonController.add(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.ease,
      opacity: _hidden ? 0 : 1,
      duration: _animationDuration,
     child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 70),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _MenuOption(
                    stream: _selectedButtonController.stream,
                    index: 0,
                    label: 'LOGIN',
                    focusNode: _loginButtonFocusNode,
                    onTap: () async {
                      final success = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginDisplay(authSuccess: _authSuccess)));
                      if (!success) _loginButtonFocusNode.requestFocus();
                    },
                  ),
                  const SizedBox(width: 20),
                  _MenuOption(
                    stream: _selectedButtonController.stream,
                    index: 1,
                    label: 'REGISTER',
                    focusNode: _registerButtonFocusNode,
                    onTap: () async {
                      final success = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterDisplay(authSuccess: _authSuccess)));
                      if (!success) _loginButtonFocusNode.requestFocus();
                    },
                  ),
                ],
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Image.asset(
              'assets/images/atv_logo.png',
              fit: BoxFit.fitHeight,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginButtonFocusNode.dispose();
    _registerButtonFocusNode.dispose();
    _selectedButtonController.close();
    super.dispose();
  }
}
