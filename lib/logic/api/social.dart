import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:americonictv_tv/data/user_data.dart';
import 'package:americonictv_tv/logic/api/models/favorites_model.dart';
import 'package:americonictv_tv/logic/api/models/watch_later_model.dart';
import 'package:americonictv_tv/logic/api/videos.dart';
import 'package:americonictv_tv/logic/cache/prefs.dart';

abstract class Social {
  static Future<http.Response> like(int id) async => await http.post(
      Uri.parse('https://video.americonictv.com/plugin/API/set.json.php?APIName=like&videos_id=$id'
      '&user=${User.instance.user}&pass=${User.instance.pass}&encodedPass=true'));

  static Future<http.Response> dislike(int id) async => await http.post(
      Uri.parse('https://video.americonictv.com/plugin/API/set.json.php?APIName=dislike&videos_id=$id'
      '&user=${User.instance.user}&pass=${User.instance.pass}&encodedPass=true'));

  static Future<bool> isLiked(int id) async {
    bool liked;

    try {
      final response = await http.get(
          Uri.parse('https://video.americonictv.com/plugin/API/get.json.php?APIName=likes&videos_id=$id&user=${User.instance.user}&pass=${User.instance.pass}'));
      final decoded = jsonDecode(response.body);
      final int myVote = decoded['response']['myVote'];
      if (myVote == 1)
        liked = true;
      else if (myVote == -1) liked = false;
    } catch (e) {
      print('$e');
    }

    return liked;
  }

  static Future<http.Response> comment(
    String comment,
    int videoID, [
    int commentID,
  ]) async =>
      await http.post(
          Uri.parse('https://video.americonictv.com/plugin/API/set.json.php?APIName=comment&videos_id=$videoID'
          '&user=${User.instance.user}&pass=&pass=${User.instance.pass}&comment=$comment'));

  static Future<http.Response> favorite(int id) async => await http.get(
      Uri.parse('https://video.americonictv.com/plugin/API/set.json.php?APIName=favorite&videos_id=$id'
      '&user=${User.instance.user}&pass=${User.instance.pass}&encodedPass=true'));
  static Future<http.Response> removeFavorite(int id) async => await http.get(
  Uri.parse('https://video.americonictv.com/plugin/API/set.json.php?APIName=removeFavorite&videos_id=$id'
      '&user=${User.instance.user}&pass=${User.instance.pass}&encodedPass=true'));

  static Future<http.Response> watchLater(int id) async => await http.get(
      Uri.parse('https://video.americonictv.com/plugin/API/set.json.php?APIName=watch_later&videos_id=$id'
      '&user=${User.instance.user}&pass=${User.instance.pass}&encodedPass=true'));
  static Future<http.Response> removeWatchLater(int id) async => await http.get(
  Uri.parse('https://video.americonictv.com/plugin/API/set.json.php?APIName=removeWatch_later&videos_id=$id'
      '&user=${User.instance.user}&pass=${User.instance.pass}&encodedPass=true'));

  static Future<void> getSaved() async {
    try {
      final Favorites favorites = await VideosAPI.getFavorites(1);
      for (var video in favorites.videos)
        await Prefs.instance.setBool('${video.id} saved', true);
      final WatchLater later = await VideosAPI.getWatchLater(1);
      for (var video in later.videos)
        await Prefs.instance.setBool('${video.id} later', true);
    } catch (e) {
      print('Couldn\'t get favorites: $e');
    }
  }
}
