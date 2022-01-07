import 'package:flutter/material.dart';
import 'package:americonictv_tv/ui/screens/feed/carousel/bg/bloc/bg_carousel_index_controller.dart';

class CarouselBackgroundSlide extends StatelessWidget {
  final int index;
  final String thumbnail, hqImage;

  CarouselBackgroundSlide({
    @required this.index,
    @required this.thumbnail,
    @required this.hqImage,
  });

  Future<bool> _getLargeImage(context) async {
    await precacheImage(
      NetworkImage(hqImage),
      context,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BackgroundCarouselController.stream,
      initialData: 0,
      builder: (context, selected) => AnimatedOpacity(
        opacity: selected.data == index ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: FutureBuilder(
          future: _getLargeImage(context),
          builder: (context, loaded) => AnimatedCrossFade(
            firstChild: Image.network(
              thumbnail,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            secondChild: Image.network(
              hqImage,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            crossFadeState: loaded.hasData && loaded.data
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }
}
