import 'dart:async';

import 'package:flutter/material.dart';
import 'package:americonictv_tv/data/user_data.dart';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/logic/api/videos.dart';
import 'package:americonictv_tv/logic/cache/prefs.dart';
import 'package:americonictv_tv/ui/bloc/main_view_controller.dart';
import 'package:americonictv_tv/ui/screens/user_auth/login/login_display.dart';
import 'package:americonictv_tv/ui/screens/user_auth/register/register_display.dart';
import 'package:americonictv_tv/ui/screens/welcome/welcome_screen.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';
import 'package:americonictv_tv/ui/shared/focusable_icon.dart';
import 'package:americonictv_tv/ui/shared/video_entry_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final _viewController = StreamController.broadcast();

  static int _currentPage = 1;

  Future<List<VideoData>> _getChannelVideos() async =>
      await VideosAPI.getChannelVideos(User.instance.channelName, _currentPage)
          .then((value) => value.response.rows);

  Future<List<VideoData>> _getFavorites() async =>
      await VideosAPI.getFavorites(_currentPage).then((value) => value.videos);

  Future<List<VideoData>> _getWatchLater() async =>
      await VideosAPI.getWatchLater(_currentPage).then((value) => value.videos);

  final _loginButtonFocusNode = FocusNode();
  final _registerButtonFocusNode = FocusNode();
  final _closeButtonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !User.loggedIn
          ? Stack(
              children: [
                SizedBox.expand(),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FocusableButton(
                        inverted: true,
                        focusNode: _loginButtonFocusNode,
                        width: MediaQuery.of(context).size.width / 4,
                        height: 50,
                        borderRadius: 25,
                        label: 'LOGIN',
                        autofocus: true,
                        onTap: () async {
                          final success = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginDisplay()));
                          if (success) setState(() {});
                          success
                              ? _closeButtonFocusNode.requestFocus()
                              : _loginButtonFocusNode.requestFocus();
                        },
                        focusColor: Colors.transparent,
                      ),
                      const SizedBox(width: 16),
                      FocusableButton(
                        inverted: true,
                        focusNode: _registerButtonFocusNode,
                        width: MediaQuery.of(context).size.width / 4,
                        height: 50,
                        borderRadius: 25,
                        label: 'REGISTER',
                        onTap: () async {
                          final success = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterDisplay()));
                          success
                              ? _closeButtonFocusNode.requestFocus()
                              : _loginButtonFocusNode.requestFocus();
                        },
                        focusColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: FocusableIcon(
                    icon: Icons.close,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        User.instance.name,
                        style: const TextStyle(fontSize: 28),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FocusableButton(
                            width: 120,
                            height: 36,
                            label: 'Logout',
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  barrierColor: Theme.of(context).primaryColor,
                                  builder: (context) => Center(
                                      child: CircularProgressIndicator()));
                              for (var key in Prefs.instance.getKeys())
                                await Prefs.instance.remove(key);
                              User.setInstance(null);
                              Navigator.pop(context);
                              MainViewController.change(WelcomeScreen());
                              Navigator.pop(context);
                            },
                            borderRadius: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: FocusableButton(
                              width: 120,
                              height: 36,
                              label: 'Favorites',
                              onTap: () => _viewController.add(_getFavorites),
                              borderRadius: 18,
                            ),
                          ),
                          FocusableButton(
                            width: 120,
                            height: 36,
                            label: 'Watch Later',
                            onTap: () => _viewController.add(_getWatchLater),
                            borderRadius: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: FocusableIcon(
                              focusNode: _closeButtonFocusNode,
                              icon: Icons.close,
                              autoFocus: true,
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: _viewController.stream,
                  initialData: _getChannelVideos,
                  builder: (context, future) => FutureBuilder(
                    future: future.data(),
                    builder: (context, AsyncSnapshot<List<VideoData>> videos) =>
                        videos.connectionState != ConnectionState.done ||
                                videos.hasError ||
                                videos.hasData && videos.data.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  videos.connectionState != ConnectionState.done
                                      ? 'Loading...'
                                      : 'No videos found',
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 16 / 10,
                                ),
                                itemCount: videos.data.length,
                                itemBuilder: (context, i) => VideoEntryButton(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  video: videos.data[i],
                                  padding: EdgeInsets.fromLTRB(
                                    i % 4 == 0 ? 12 : 6,
                                    6,
                                    (i + 1) % 4 == 0 ? 12 : 6,
                                    6,
                                  ),
                                ),
                              ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _viewController.close();
    _loginButtonFocusNode.dispose();
    _registerButtonFocusNode.dispose();
    _closeButtonFocusNode.dispose();
    super.dispose();
  }
}
