import 'package:flutter/material.dart';
import 'package:americonictv_tv/ui/screens/feed/carousel/bg/bg_slide.dart';

class BackgroundCarousel extends StatelessWidget {
  final List<String> thumbnails, hqImages;

  BackgroundCarousel({
    @required this.thumbnails,
    @required this.hqImages,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < thumbnails.length; i++)
          CarouselBackgroundSlide(
            index: i % thumbnails.length,
            thumbnail: thumbnails[i % thumbnails.length],
            hqImage: hqImages[i % thumbnails.length],
          )
      ],
    );
  }
}
