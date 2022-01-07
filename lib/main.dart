import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:americonictv_tv/data/user_data.dart';
import 'package:americonictv_tv/logic/api/auth.dart';
import 'package:americonictv_tv/logic/api/models/user_model.dart';
import 'package:americonictv_tv/ui/main_view.dart';
import 'package:americonictv_tv/ui/shared/overscroll_effect.dart';
import 'logic/cache/prefs.dart';

void main() async {
  // Required by the framework
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();

  runApp(TVDisplay());
}

class TVDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TVDisplayState();
  }
}

class _TVDisplayState extends State<TVDisplay> {
  bool _loaded = false;

  String _error;

  @override
  void initState() {
    super.initState();
    User.instance?.id == null
        ? _loaded = true
        : WidgetsBinding.instance.addPostFrameCallback((_) async {
            try {
              final response =
                  await Auth.login(User.instance.user, User.instance.pass);

              final decoded = jsonDecode(response.body);

              User.setInstance(UserData.fromJson(decoded));

              setState(() => _loaded = true);
            } catch (e) {
              setState(() => _error = '$e');
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Colors.black,
            fontFamily: 'Rubik',
            brightness: Brightness.dark,
            primaryColor: const Color(0xffb20000),
            accentColor: const Color(0xffb20000),
            focusColor: Colors.transparent,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.white,
              selectionColor: Colors.white,
              selectionHandleColor: Colors.white,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            appBarTheme: const AppBarTheme(
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          builder: (context, child) => ScrollConfiguration(
            behavior: OverscrollRemovedBehavior(),
            child: child,
          ),
          home: _error != null || !_loaded
              ? Center(
                  child: _error != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            _error,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : CircularProgressIndicator(),
                )
              : MainView(),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
