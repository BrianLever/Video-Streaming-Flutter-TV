
import 'dart:convert';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';
import 'package:americonictv_tv/ui/shared/Series_entry_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SerieslistDisplay extends StatefulWidget {
  final List<Playlist> response;

  SerieslistDisplay({@required this.response});

  @override
  State<StatefulWidget> createState() {
    return _SerieslistDisplayState();
  }
}

class _SerieslistDisplayState extends State<SerieslistDisplay> {
  final _pageController = PageController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.response==null)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'No Serieslist found.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      );
    } else {
      return ListView(
        padding: EdgeInsets.symmetric(vertical: 45),
        controller: _scrollController,
        shrinkWrap: true,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              childAspectRatio: 16 / 10,
              mainAxisSpacing: 10,
            ),
            itemCount: widget.response.length,
            padding: const EdgeInsets.only(left: 12),
            itemBuilder: (context, i) => SeriesEntryButton(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              video: widget.response[i],
              animated: false,
            ),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
