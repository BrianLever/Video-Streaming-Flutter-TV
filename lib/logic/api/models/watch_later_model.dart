import 'dart:convert';
import 'package:americonictv_tv/logic/api/models/videos_response_model.dart';

class WatchLater {
  WatchLater({
    this.id,
    this.user,
    this.name,
    this.email,
    this.created,
    this.modified,
    this.isAdmin,
    this.status,
    this.photoUrl,
    this.lastLogin,
    this.backgroundUrl,
    this.canStream,
    this.canUpload,
    this.canViewChart,
    this.about,
    this.channelName,
    this.emailVerified,
    this.analyticsCode,
    this.externalOptions,
    this.firstName,
    this.lastName,
    this.address,
    this.zipCode,
    this.country,
    this.region,
    this.city,
    this.donationLink,
    this.canCreateMeet,
    this.extraInfo,
    this.usersId,
    this.showOnTv,
    this.nameTranslated,
    this.videos,
    this.isFavorite,
    this.isWatchLater,
  });

  int id;
  String user;
  String name;
  String email;
  String created;
  String modified;
  int isAdmin;
  String status;
  dynamic photoUrl;
  String lastLogin;
  dynamic backgroundUrl;
  int canStream;
  int canUpload;
  int canViewChart;
  String about;
  String channelName;
  int emailVerified;
  String analyticsCode;
  String externalOptions;
  dynamic firstName;
  dynamic lastName;
  dynamic address;
  dynamic zipCode;
  dynamic country;
  dynamic region;
  dynamic city;
  String donationLink;
  int canCreateMeet;
  dynamic extraInfo;
  int usersId;
  int showOnTv;
  String nameTranslated;
  List<VideoData> videos;
  bool isFavorite;
  bool isWatchLater;

  factory WatchLater.fromJson(String str) => WatchLater.fromJson(str);

  String toJson() => json.encode(toJson());

  factory WatchLater.fromMap(Map<String, dynamic> json) => WatchLater(
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : json["user"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        created: json["created"] == null ? null : json["created"],
        modified: json["modified"] == null ? null : json["modified"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        status: json["status"] == null ? null : json["status"],
        photoUrl: json["photoURL"],
        lastLogin: json["lastLogin"] == null ? null : json["lastLogin"],
        backgroundUrl: json["backgroundURL"],
        canStream: json["canStream"] == null ? null : json["canStream"],
        canUpload: json["canUpload"] == null ? null : json["canUpload"],
        canViewChart:
            json["canViewChart"] == null ? null : json["canViewChart"],
        about: json["about"] == null ? null : json["about"],
        channelName: json["channelName"] == null ? null : json["channelName"],
        emailVerified:
            json["emailVerified"] == null ? null : json["emailVerified"],
        analyticsCode:
            json["analyticsCode"] == null ? null : json["analyticsCode"],
        externalOptions:
            json["externalOptions"] == null ? null : json["externalOptions"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        zipCode: json["zip_code"],
        country: json["country"],
        region: json["region"],
        city: json["city"],
        donationLink:
            json["donationLink"] == null ? null : json["donationLink"],
        canCreateMeet:
            json["canCreateMeet"] == null ? null : json["canCreateMeet"],
        extraInfo: json["extra_info"],
        usersId: json["users_id"] == null ? null : json["users_id"],
        showOnTv: json["showOnTV"] == null ? null : json["showOnTV"],
        nameTranslated:
            json["name_translated"] == null ? null : json["name_translated"],
        videos: json["videos"] == null
            ? null
            : List<VideoData>.from(
                json["videos"].map((x) => VideoData.fromMap(x))),
        isFavorite: json["isFavorite"] == null ? null : json["isFavorite"],
        isWatchLater:
            json["isWatchLater"] == null ? null : json["isWatchLater"],
      );
}
