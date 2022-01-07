import 'package:flutter/material.dart';
import 'package:americonictv_tv/data/user_data.dart';
import 'package:americonictv_tv/logic/cache/prefs.dart';
import 'package:americonictv_tv/ui/bloc/main_view_controller.dart';
import 'package:americonictv_tv/ui/elemets/user_agreement.dart';
import 'package:americonictv_tv/ui/screens/feed/feed_screen.dart';
import 'package:americonictv_tv/ui/screens/welcome/welcome_screen.dart';
import 'package:americonictv_tv/ui/shared/animated_bg_gradient.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    MainViewController.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Prefs.instance.getBool('eulaAccepted') == null)
        showDialog(context: context, builder: (context) => AgreementDialog());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: StreamBuilder(
          stream: MainViewController.stream,
          initialData: User.loggedIn ? FeedScreen() : WelcomeScreen(),
          builder: (context, body) => Stack(
            children: [
              Image.asset(
                'assets/images/background_3.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              AnimatedBgGradient(),
              AnimatedBgGradient(),
              body.data,
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }

  @override
  void dispose() {
    MainViewController.dispose();
    super.dispose();
  }
}
