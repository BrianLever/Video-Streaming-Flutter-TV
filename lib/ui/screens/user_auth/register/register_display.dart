import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:americonictv_tv/logic/api/auth.dart';
import 'package:americonictv_tv/ui/shared/authenticating_dialog.dart';

class RegisterDisplay extends StatefulWidget {
  final Function authSuccess;

  RegisterDisplay({this.authSuccess});

  @override
  State<StatefulWidget> createState() {
    return _RegisterDisplayState();
  }
}

class _RegisterDisplayState extends State<RegisterDisplay> {
  final _nameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _labelController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus) _labelController.add('Full Name');
    });
    _usernameFocusNode.addListener(() {
      if (_usernameFocusNode.hasFocus) _labelController.add('Username');
    });
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) _labelController.add('Email');
    });
    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) _labelController.add('Password');
    });
    _confirmPasswordFocusNode.addListener(() {
      if (_confirmPasswordFocusNode.hasFocus)
        _labelController.add('Repeat Password');
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
                          focusNode: _nameFocusNode,
                          controller: _nameTextController,
                          decoration: InputDecoration(labelText: 'Your name',hintText: 'Enter your name.'),
                          onSubmitted: (_) => _usernameFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          focusNode: _usernameFocusNode,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          controller: _usernameTextController,
                          decoration: InputDecoration(labelText: 'Username',hintText: 'Enter your username.'),
                          onSubmitted: (_) => _emailFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          focusNode: _emailFocusNode,
                          textAlign: TextAlign.center,
                          controller: _emailTextController,
                          decoration: InputDecoration(labelText: 'Email',hintText: 'Enter your email.'),
                          keyboardType: TextInputType.emailAddress,
                          onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          obscureText: true,
                          focusNode: _passwordFocusNode,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          controller: _passwordTextController,
                          decoration: InputDecoration(labelText: 'Password',hintText: 'Enter your password.'),
                          onSubmitted: (_) =>
                              _confirmPasswordFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          obscureText: true,
                          focusNode: _confirmPasswordFocusNode,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          controller: _confirmPasswordTextController,
                          decoration:
                              InputDecoration(labelText: 'Repeat Password',hintText: 'Repeat your password.'),
                          onSubmitted: (_) async {
                            FocusScope.of(context).unfocus();
                            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_emailTextController.text) &&
                                _nameTextController.text.isNotEmpty &&
                                _usernameTextController.text.isNotEmpty &&
                                _passwordTextController.text.isNotEmpty &&
                                _confirmPasswordTextController
                                    .text.isNotEmpty &&
                                _emailTextController.text.isNotEmpty &&
                                _confirmPasswordTextController.text ==
                                    _passwordTextController.text) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => Center(
                                      child: CircularProgressIndicator()));
                              try {
                                final response = await Auth.register(
                                  _usernameTextController.text,
                                  _emailTextController.text,
                                  _passwordTextController.text,
                                  _nameTextController.text,
                                );
                                final decoded = jsonDecode(response.body);
                                if (decoded['error'] == null) {
                                  Navigator.pop(context);
                                  Navigator.pop(context, true);
                                  // Login without email verification. Delete above 2 lines if uncommenting.
                                  /*
                                  final int id = int.parse(decoded['status']);
                                  final userInfoResponse =
                                      await Auth.getUserInfo(id);
                                  final decodedUserInfo =
                                      jsonDecode(userInfoResponse.body);
                                  if (decodedUserInfo['error'] == true)
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'User created but couldn\'t fetch data. Please try logging in.')));
                                  else {
                                    print(userInfoResponse.body);
                                    final userData = UserData.fromJson(
                                        decodedUserInfo['response']['user']);
                                    await User.setInstance(userData, true);
                                    await Social.getSaved();
                                    Navigator.pop(context);
                                    Navigator.pop(context, true);
                                    if (widget.authSuccess != null)
                                      widget.authSuccess();
                                  }
                                  */
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(decoded['error'])));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$e')));
                              }
                              if (mounted) _nameFocusNode.requestFocus();
                            } else {
                              final bool passwordsNoMatch =
                                  _confirmPasswordTextController.text !=
                                      _passwordTextController.text;
                              passwordsNoMatch
                                  ? _passwordFocusNode.requestFocus()
                                  : _nameFocusNode.requestFocus();
                              await showDialog(
                                  context: context,
                                  builder: (context) => AuthenticatingDialog(
                                      label: passwordsNoMatch
                                          ? 'Passwords don\'t match'
                                          : 'All fields must be submitted for registration'));
                              _usernameFocusNode.requestFocus();
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
              initialData: 'Register',
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
    _nameTextController.dispose();
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _nameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }
}
