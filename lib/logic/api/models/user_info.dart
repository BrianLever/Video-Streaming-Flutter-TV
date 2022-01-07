// To parse this JSON data, do
//
//     final userInfo = userInfoFromMap(jsonString);

import 'dart:convert';

class UserInfo {
  UserInfo({
    this.error,
    this.message,
    this.response,
  });

  bool error;
  String message;
  Response response;

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        error: json["error"],
        message: json["message"],
        response: Response.fromMap(json["response"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "response": response.toMap(),
      };
}

class Response {
  Response({
    this.user,
    this.livestream,
  });

  Info user;
  Livestream livestream;

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        user: Info.fromMap(json["user"]),
        livestream: Livestream.fromMap(json["livestream"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "livestream": livestream.toMap(),
      };
}

class Livestream {
  Livestream({
    this.id,
    this.title,
    this.public,
    this.saveTransmition,
    this.created,
    this.modified,
    this.key,
    this.description,
    this.usersId,
    this.categoriesId,
    this.showOnTv,
    this.liveServersId,
    this.server,
    this.poster,
    this.joinUrl,
  });

  int id;
  String title;
  int public;
  int saveTransmition;
  DateTime created;
  DateTime modified;
  String key;
  String description;
  int usersId;
  int categoriesId;
  int showOnTv;
  int liveServersId;
  String server;
  String poster;
  String joinUrl;

  factory Livestream.fromJson(String str) =>
      Livestream.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Livestream.fromMap(Map<String, dynamic> json) => Livestream(
        id: json["id"],
        title: json["title"],
        public: json["public"],
        saveTransmition: json["saveTransmition"],
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
        key: json["key"],
        description: json["description"],
        usersId: json["users_id"],
        categoriesId: json["categories_id"],
        showOnTv: json["showOnTV"],
        liveServersId: json["live_servers_id"],
        server: json["server"],
        poster: json["poster"],
        joinUrl: json["joinURL"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "public": public,
        "saveTransmition": saveTransmition,
        "created": created.toIso8601String(),
        "modified": modified.toIso8601String(),
        "key": key,
        "description": description,
        "users_id": usersId,
        "categories_id": categoriesId,
        "showOnTV": showOnTv,
        "live_servers_id": liveServersId,
        "server": server,
        "poster": poster,
        "joinURL": joinUrl,
      };
}

class Info {
  Info({
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
    this.canCreateMeet,
    this.canViewChart,
    this.about,
    this.channelName,
    this.emailVerified,
    this.analyticsCode,
    this.externalOptions,
    this.donationLink,
    this.extraInfo,
    this.groups,
    this.identification,
    this.photo,
    this.background,
    this.tags,
    this.isEmailVerified,
    this.checkmark1,
    this.checkmark2,
    this.checkmark3,
  });

  int id;
  String user;
  String name;
  String email;
  DateTime created;
  DateTime modified;
  int isAdmin;
  String status;
  String photoUrl;
  DateTime lastLogin;
  dynamic backgroundUrl;
  int canStream;
  int canUpload;
  int canCreateMeet;
  int canViewChart;
  String about;
  String channelName;
  int emailVerified;
  String analyticsCode;
  String externalOptions;
  String donationLink;
  dynamic extraInfo;
  List<dynamic> groups;
  String identification;
  String photo;
  String background;
  List<Tag> tags;
  int isEmailVerified;
  int checkmark1;
  int checkmark2;
  int checkmark3;

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        id: json["id"],
        user: json["user"],
        name: json["name"],
        email: json["email"],
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
        isAdmin: json["isAdmin"],
        status: json["status"],
        photoUrl: json["photoURL"],
        lastLogin: DateTime.parse(json["lastLogin"]),
        backgroundUrl: json["backgroundURL"],
        canStream: json["canStream"],
        canUpload: json["canUpload"],
        canCreateMeet: json["canCreateMeet"],
        canViewChart: json["canViewChart"],
        about: json["about"],
        channelName: json["channelName"],
        emailVerified: json["emailVerified"],
        analyticsCode: json["analyticsCode"],
        externalOptions: json["externalOptions"],
        donationLink: json["donationLink"],
        extraInfo: json["extra_info"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        identification: json["identification"],
        photo: json["photo"],
        background: json["background"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromMap(x))),
        isEmailVerified: json["isEmailVerified"],
        checkmark1: json["checkmark1"],
        checkmark2: json["checkmark2"],
        checkmark3: json["checkmark3"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user": user,
        "name": name,
        "email": email,
        "created": created.toIso8601String(),
        "modified": modified.toIso8601String(),
        "isAdmin": isAdmin,
        "status": status,
        "photoURL": photoUrl,
        "lastLogin": lastLogin.toIso8601String(),
        "backgroundURL": backgroundUrl,
        "canStream": canStream,
        "canUpload": canUpload,
        "canCreateMeet": canCreateMeet,
        "canViewChart": canViewChart,
        "about": about,
        "channelName": channelName,
        "emailVerified": emailVerified,
        "analyticsCode": analyticsCode,
        "externalOptions": externalOptions,
        "donationLink": donationLink,
        "extra_info": extraInfo,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "identification": identification,
        "photo": photo,
        "background": background,
        "tags": List<dynamic>.from(tags.map((x) => x.toMap())),
        "isEmailVerified": isEmailVerified,
        "checkmark1": checkmark1,
        "checkmark2": checkmark2,
        "checkmark3": checkmark3,
      };
}

class Tag {
  Tag({
    this.type,
    this.text,
  });

  String type;
  String text;

  factory Tag.fromJson(String str) => Tag.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        type: json["type"],
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "text": text,
      };
}
