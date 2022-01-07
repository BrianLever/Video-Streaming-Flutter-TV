import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:americonictv_tv/data/user_data.dart';
import 'package:americonictv_tv/logic/api/models/user_info.dart';
import 'package:americonictv_tv/logic/api/models/user_model.dart';
import 'package:americonictv_tv/logic/api/auth.dart';
import 'package:americonictv_tv/logic/api/social.dart';
import 'package:americonictv_tv/ui/shared/authenticating_dialog.dart';
import 'package:flutter/services.dart';

class LoginDisplay extends StatefulWidget {
  final Function authSuccess;

  LoginDisplay({this.authSuccess});

  @override
  State<StatefulWidget> createState() {
    return _LoginDisplayState();
  }
}

class _LoginDisplayState extends State<LoginDisplay> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _labelController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      if (_usernameFocusNode.hasFocus) _labelController.add('Username');
    });
    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) _labelController.add('Password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  // padding: EdgeInsets.fromLTRB(
                  //    MediaQuery.of(context).size.width /4,
                  //    0,
                  //    MediaQuery.of(context).size.width / 4,
                  //    MediaQuery.of(context).size.height/3,
                padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4,
                ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          focusNode: _usernameFocusNode,
                          controller: _usernameTextController,
                          decoration: InputDecoration(labelText: 'Username',hintText: 'Enter your username.'),
                          onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          focusNode: _passwordFocusNode,
                          controller: _passwordTextController,
                          decoration: InputDecoration(labelText: 'Password',hintText: 'Enter your password.'),
                          onSubmitted: (_) async {
                            FocusScope.of(context).unfocus();
                            if (_usernameTextController.text.isEmpty ||
                                _passwordTextController.text.isEmpty) {
                              await showDialog(
                                  context: context,
                                  builder: (context) => AuthenticatingDialog(
                                      label: 'Please check your input'));
                              _usernameFocusNode.requestFocus();
                            } else {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => Center(
                                      child: CircularProgressIndicator()));
                              try {
                                print('Sending login request');
                                final response = await Auth.login(
                                  _usernameTextController.text,
                                  _passwordTextController.text,
                                );
                                print('Request finished');
                                final decoded = jsonDecode(response.body);
                                if (decoded['id'] != false) {
                                  print('Login successful');
                                  final infoResponse =
                                      await Auth.getUserInfo(decoded['id']);
                                  final info = UserInfo.fromMap(
                                      jsonDecode(infoResponse.body));
                                  if (info.response.user.tags
                                          .firstWhere((e) =>
                                              e.text.startsWith('E-Mail'))
                                          .type !=
                                      'success') throw "Email not verified.";
                                  final data = UserData.fromJson(decoded);
                                  print('Saving user data');
                                  await User.setInstance(data, true);
                                  await Social.getSaved();
                                  print('Saved user data');
                                  Navigator.pop(context);
                                  Navigator.pop(context, true);
                                  if (widget.authSuccess != null)
                                    widget.authSuccess();
                                } else {
                                  print('Login failed');
                                  Navigator.pop(context);
                                  await showDialog(
                                    context: context,
                                    builder: (context) => AuthenticatingDialog(
                                      label: decoded['error'] != null &&
                                              decoded['error'].runtimeType ==
                                                  String
                                          ? decoded['error']
                                          : 'Login unsuccessful. Please check your details.',
                                    ),
                                  );
                                }
                              } catch (e) {
                                print('Request failed');
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AuthenticatingDialog(label: '$e'));
                              }
                              if (mounted) _usernameFocusNode.requestFocus();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: StreamBuilder(
              stream: _labelController.stream,
              initialData: 'Login',
              builder: (context, label) => label.hasData
                  ? Text(
                      label.data,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _labelController.close();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
