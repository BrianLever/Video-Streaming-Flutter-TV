import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:americonictv_tv/data/user_data.dart';
import 'package:americonictv_tv/logic/api/models/favorites_model.dart';
import 'package:americonictv_tv/logic/api/models/watch_later_model.dart';
import 'models/category_model.dart';
import 'models/series_model.dart';
import 'models/thumb_model.dart';
import 'models/videos_response_model.dart';

abstract class VideosAPI {
  static Future<VideosResponse> getLatest([int page]) async =>
      videosResponseFromJson((await http
              .get(Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?'
                      'APIName=video&'
                      'user=${User.instance.user}'
                      '&pass=${User.instance.pass}'
                      '&encodedPass=true'
                      '&sort[created]=desc'
                      '&rowCount=' +
                  (page == null ? '50' : '50&current=$page'))))
          .body);

  static Future<VideosResponse> getTrending() async =>
      videosResponseFromJson((await http.get(
          Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=video&'
              'user=${User.instance.user}'
              '&pass=${User.instance.pass}'
              '&sort[likes]=desc&rowCount=50')))
          .body);

  static Future<CategoryResponse> getCategories() async =>
      categoryResponseFromJson((await http.get(
          Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=categories&'
              'user=${User.instance.user}'
              '&pass=${User.instance.pass}')))
          .body);

  static Future<VideosResponse> getVideosByCategory(
          String categoryName, int page, [int series]) async =>
      videosResponseFromJson((await http.get(
          Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=video&'
                      'user=${User.instance.user}'
                      '&pass=${User.instance.pass}'
                      '&catName=$categoryName&rowCount=60&current=$page' +
                  (series == null ? '' : '&is_serie=$series'))))
          .body);

  static Future<SeriesResponse> getVideosByPlaylist(int seriePlaylistId) async {

       return SeriesResponseFromJson((await http.get(Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=video_from_program'
          '&playlists_id=$seriePlaylistId&APISecret=b50659819eb61ceae567ecd5dd51ea31'))).body);
  }

  static Future<ThumbResponse> getThumb(int videosID) async {

    return thumbResponseFromJson((await http.get(Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=video_file'
        '&videos_id=$videosID&APISecret=b50659819eb61ceae567ecd5dd51ea31'))).body);
  }


  static  Future<VideosResponse> getSeries() async =>
      videosResponseFromJson(( await http.get(
          Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=video&is_serie=1&APISecret=b50659819eb61ceae567ecd5dd51ea31'))).body);


  static Future getLivestreams() async => jsonDecode((await http.get(
  Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=livestreams&'
          'user=${User.instance.user}'
          '&pass=${User.instance.pass}'
          '&')))
      .body);

  static Future<VideosResponse> getChannelVideos(String channel, int page,
          [bool infinite = false]) async =>
      videosResponseFromJson((await http.get(
          Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=video&'
                      'user=${User.instance.user}'
                      '&pass=${User.instance.pass}'
                      '&&channelName=$channel&current=$page&rowCount=' +
                  (infinite ? '1000' : '60'))))
          .body);

  static Future<VideosResponse> searchVideos(String searchTerm, int page,
          [int series]) async =>
      videosResponseFromJson((await http.get(
          Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=video&'
                      'user=${User.instance.user}'
                      '&pass=${User.instance.pass}'
                      '&&rowCount=60&current=$page&searchPhrase=$searchTerm' +
                  (series == null ? '' : '&is_serie=$series'))))
          .body);

  static Future<WatchLater> getWatchLater([int page = 1]) async {
    final decoded = jsonDecode((await http.get(
        Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=watch_later&user='
            '${User.instance.user}&pass=${User.instance.pass}&encodedPass=true&rowCount=60&page=$page')))
        .body);
    print(decoded);
    try {
      return WatchLater.fromMap(decoded[0]);
    } catch (e) {
      print(e);
      throw 'No videos found.';
    }
  }

  static Future<Favorites> getFavorites([int page = 1]) async {
    final decoded = jsonDecode((await http.get(
        Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=favorite&user='
            '${User.instance.user}&pass=${User.instance.pass}&encodedPass=true&rowCount=60&page=$page')))
        .body);
    print(decoded);
    return Favorites.fromMap(decoded[0]);
  }
}
