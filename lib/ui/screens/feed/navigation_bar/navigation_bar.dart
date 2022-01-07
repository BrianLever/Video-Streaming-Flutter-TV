import 'package:flutter/material.dart';
import 'package:americonictv_tv/ui/screens/feed/bloc/feed_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/navigation_bar/bloc/focus_controller.dart';
import 'package:americonictv_tv/ui/screens/feed/profile/profile_screen.dart';
import 'package:americonictv_tv/ui/screens/feed/search/search_page.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';
import 'package:americonictv_tv/ui/shared/focusable_icon.dart';

class NavigationBar extends StatefulWidget {
  static _NavigationBarState state;

  @override
  State<StatefulWidget> createState() {
    state = _NavigationBarState();
    return state;
  }
}

class _NavigationBarState extends State<NavigationBar> {
  final _labels = const {'LATEST', 'TRENDING', 'LIVE', 'CATEGORIES'};

  final liveVideosButtonFocusNode = FocusNode();
  final categoriesButtonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 12, 0, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/atv_appbar_logo.png',
            fit: BoxFit.fitHeight,
            height: 34,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < 6; i++)
                StreamBuilder(
                  stream: NavBarFocusController.stream,
                  initialData: true,
                  builder: (context, canRequestFocus) => StreamBuilder(
                    stream: FeedController.stream,
                    initialData: 0,
                    builder: (context, currentPage) => i < 4
                        ? Padding(
                            padding: const EdgeInsets.only(left:20,right: 10),
                            child: FocusableButton(
                              focusNode: i == 2
                                  ? liveVideosButtonFocusNode
                                  : i == 3
                                      ? categoriesButtonFocusNode
                                      : null,
                              canRequestFocus: canRequestFocus.data,
                              autofocus: i == 0,
                              width: 140,
                              height: 32,
                              label: _labels.elementAt(i),
                              onTap: () => FeedController.change(i),
                              color: Colors.transparent,
                              textColor: currentPage.data == i
                                  ? Colors.red
                                  : Colors.white60,
                              fontWeight: currentPage.data == i
                                  ? FontWeight.bold
                                  : null,
                              inverted: true,
                              borderRadius: 16,
                              fontSize: 16,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FocusableIcon(
                              canRequestFocus: canRequestFocus.data,
                              icon: i == 4 ? Icons.search : Icons.person,
                              focusColor: Colors.red,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      i == 4 ? SearchScreen() : ProfilePage(),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    liveVideosButtonFocusNode.dispose();
    categoriesButtonFocusNode.dispose();
    super.dispose();
  }
}
