


import 'dart:convert';

SeriesResponse SeriesResponseFromJson(dynamic str) =>
    SeriesResponse.fromJson(str.runtimeType != String ? json.decode(str) : str);

dynamic SeriesResponseToJson(SeriesResponse data) => json.encode(data.toJson());

class SeriesResponse {
  SeriesResponse({
    this.error,
    this.message,
    this.response,
  });

  dynamic error;
  String message;
  Response response;

  factory SeriesResponse.fromJson(String str) =>
      SeriesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SeriesResponse.fromMap(Map<String, dynamic> json) => SeriesResponse(
    error: json['error'] == null ? null : json['error'],
    message: json['message'] == null ? null : json['message'],
    response: json['response'] == null
        ? null
        : Response.fromMap(json['response']),
  );

  Map<String, dynamic> toMap() => {
    'error': error == null ? null : error,
    'message': message == null ? null : message,
    'response': response == null ? null : response.toMap(),
  };
}

class Response {
  Response({
     this.apiName,
     this.playlistsId,
     this.apiSecret,
     this.yptDeviceId,
     this.redirectUri,
     this.index,
     this.nextIndex,
     this.videos,
     this.playlistName,
     this.modified,
     this.modifiedTimeStamp,
     this.usersId,
     this.channelName,
     this.channelPhoto,
     this.channelBg,
     this.channelLink,
     this.totalPlaylistDuration,
     this.currentPlaylistTime,
     this.percentageProgress,
     this.title,
     this.videosId,
     this.path,
     this.duration,
     this.durationSeconds,

  });

       String apiName;
       dynamic playlistsId;
       String apiSecret;
       String yptDeviceId;
       String redirectUri;
       dynamic index;
       dynamic nextIndex;
       List<VideoData> videos;
       String playlistName;
       DateTime modified;
       dynamic modifiedTimeStamp;
       dynamic usersId;
       String channelName;
       String channelPhoto;
       String channelBg;
       String channelLink;
       dynamic totalPlaylistDuration;
       dynamic currentPlaylistTime;
       dynamic percentageProgress;
       String title;
       dynamic videosId;
       String path;
       String duration;
       dynamic durationSeconds;

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => Response(
    apiName: json['apiName'] == null ? null : json['apiName'],
    playlistsId: json['playlistsId'] == null ? null : json['playlistsId'],
    apiSecret: json['apiSecret'] == null ? null : json['apiSecret'],
    yptDeviceId: json['yptDeviceId'] == null ? null : json['yptDeviceId'],
    redirectUri: json['redirectUri'] == null ? null : json['redirectUri'],
    index: json['index'] == null ? null : json['index'],
    nextIndex: json['nextIndex'] == null ? null : json['nextIndex'],
    videos: json['videos'] == null
        ? null
        : List<VideoData>.from(
        json['videos'].map((x) => VideoData.fromMap(x))),
    playlistName: json['playlistName'] == null ? null : json['playlistName'],
    modified: json['modified'] == null ? null : DateTime.parse(json['modified']),
    modifiedTimeStamp: json['modifiedTimeStamp'] == null ? null : json['modifiedTimeStamp'],
    usersId: json['usersId'] == null ? null : json['usersId'],
    channelName: json['channelName'] == null ? null : json['channelName'],
    channelPhoto: json['channelPhoto'] == null ? null : json['channelPhoto'],
    channelBg: json['channelBg'] == null ? null : json['channelBg'],
    channelLink: json['channelLink'] == null ? null : json['channelLink'],
    totalPlaylistDuration: json['totalPlaylistDuration'] == null ? null : json['totalPlaylistDuration'],
    currentPlaylistTime: json['currentPlaylistTime'] == null ? null : json['currentPlaylistTime'],
    percentageProgress: json['percentageProgress'] == null ? null : json['percentageProgress'],
    title: json['title'] == null ? null : json['title'],
    videosId: json['videosId'] == null ? null : json['videosId'],
    path: json['path'] == null ? null : json['path'],
    duration: json['duration'] == null ? null : json['duration'],
    durationSeconds: json['durationSeconds'] == null ? null : json['durationSeconds'],


  );

  Map<String, dynamic> toMap() => {
    'apiName': apiName == null ? null : apiName,
    'playlistsId': playlistsId == null ? null : playlistsId,
    'apiSecret': apiSecret == null ? null : apiSecret,
    'yptDeviceId': yptDeviceId == null ? null : yptDeviceId,
    'redirectUri': redirectUri == null ? null : redirectUri,
    'index': index == null ? null : index,
    'nextIndex': nextIndex == null ? null : nextIndex,
    'videos': videos == null
        ? null
        : List<dynamic>.from(videos.map((x) => x.toMap())),
    'playlistName': playlistName == null ? null : playlistName,
    'modified': modified == null ? null : modified.toIso8601String(),
    'modifiedTimeStamp': modifiedTimeStamp == null ? null : modifiedTimeStamp,
    'usersId': usersId == null ? null : usersId,
    'channelName': channelName == null ? null : channelName,
    'channelPhoto': channelPhoto == null ? null : channelPhoto,
    'channelBg': channelBg == null ? null : channelBg,
    'channelLink': channelLink == null ? null : channelLink,
    'totalPlaylistDuration': totalPlaylistDuration == null ? null : totalPlaylistDuration,
    'currentPlaylistTime': currentPlaylistTime == null ? null : currentPlaylistTime,
    'percentageProgress': percentageProgress == null ? null : percentageProgress,
    'title': title == null ? null : title,
    'videosId': videosId == null ? null : videosId,
    'path': path == null ? null : path,
    'duration': duration == null ? null : duration,
    'durationSeconds': durationSeconds == null ? null : durationSeconds,
  };
}

class VideoData {
  VideoData({
    this.playlistsId,
    this.videosId,
    this.order,
    this.id,
    this.title,
    this.cleanTitle,
    this.description,
    this.viewsCount,
    this.viewsCount25,
    this.viewsCount50,
    this.viewsCount75,
    this.viewsCount100,
    this.status,
    this.created,
    this.modified,
    this.usersId,
    this.categoriesId,
    this.filename,
    this.duration,
    this.type,
    this.videoDownloadedLink,
    this.rotation,
    this.zoom,
    this.youtubeId,
    this.videoLink,
    this.nextVideosId,
    this.isSuggested,
    this.trailer1,
    this.trailer2,
    this.trailer3,
    this.rate,
    this.canDownload,
    this.canShare,
    this.rrating,
    this.externalOptions,
    this.onlyForPaid,
    this.seriePlaylistsId,
    this.sitesId,
    this.videoPassword,
    this.encoderUrl,
    this.filepath,
    this.fileSize,
    this.pchannel,
    this.liveTransmitionsHistoryId,
    this.path,
    this.info,
    // this.category,
  });

  dynamic playlistsId;
  dynamic videosId;
  dynamic order;
  dynamic id;
  String title;
  String cleanTitle;
  String description;
  dynamic viewsCount;
  dynamic viewsCount25;
  dynamic viewsCount50;
  dynamic viewsCount75;
  dynamic viewsCount100;
  String status;
  DateTime created;
  DateTime modified;
  dynamic usersId;
  dynamic categoriesId;
  String filename;
  String duration;
  String type;
  String videoDownloadedLink;
  dynamic rotation;
  dynamic zoom;
  String youtubeId;
  String videoLink;
  dynamic nextVideosId;
  dynamic isSuggested;
  String trailer1;
  String trailer2;
  String trailer3;
  dynamic rate;
  dynamic canDownload;
  dynamic canShare;
  String rrating;
  String externalOptions;
  dynamic onlyForPaid;
  dynamic seriePlaylistsId;
  dynamic sitesId;
  String videoPassword;
  String encoderUrl;
  String filepath;
  dynamic fileSize;
  String pchannel;
  dynamic liveTransmitionsHistoryId;
  String path;
  List<Info> info;
  // Category category;



  factory VideoData.fromJson(String str) => VideoData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoData.fromMap(Map<String, dynamic> json) => VideoData(

    playlistsId: json['playlists_id'] == null ? null : json['playlists_id'],
    videosId: json['videos_id'] == null ? null : json['videos_id'],
    order: json['order'] == null ? null : json['order'],
    id: json['id'] == null ? null : json['id'],
    title: json['title'] == null ? null : json['title'],
    cleanTitle: json['clean_title'] == null ? null : json['clean_title'],
    description: json['description'] == null ? null : json['description'],
    viewsCount: json['views_count'] == null ? null : json['views_count'],
    viewsCount25:
    json['views_count_25'] == null ? null : json['views_count_25'],
    viewsCount50:
    json['views_count_50'] == null ? null : json['views_count_50'],
    viewsCount75:
    json['views_count_75'] == null ? null : json['views_count_75'],
    viewsCount100:
    json['views_count_100'] == null ? null : json['views_count_100'],
    status: json['status'] == null ? null : json['status'],
    created:
    json['created'] == null ? null : DateTime.parse(json['created']),
    modified:
    json['modified'] == null ? null : DateTime.parse(json['modified']),
    usersId: json['users_id'] == null ? null : json['users_id'],
    categoriesId:
    json['categories_id'] == null ? null : json['categories_id'],
    filename: json['filename'] == null ? null : json['filename'],
    duration: json['duration'] == null ? null : json['duration'],
    type: json['type'] == null ? null : json['type'],
    videoDownloadedLink: json['videoDownloadedLink'] == null
        ? null
        : json['videoDownloadedLink'],
    rotation: json['rotation'] == null ? null : json['rotation'],
    zoom: json['zoom'] == null ? null : json['zoom'],
    youtubeId: json['youtubeId'] == null ? null : json['youtubeId'],
    videoLink: json['videoLink'] == null ? null : json['videoLink'],
    nextVideosId: json['next_videos_id'],
    isSuggested: json['isSuggested'] == null ? null : json['isSuggested'],
    trailer1: json['trailer1'] == null ? null : json['trailer1'],
    trailer2: json['trailer2'] == null ? null : json['trailer2'],
    trailer3: json['trailer3'] == null ? null : json['trailer3'],
    rate: json['rate'] == null ? null : json['rate'],
    canDownload: json['can_download'] == null ? null : json['can_download'],
    canShare: json['can_share'] == null ? null : json['can_share'],
    rrating: json['rrating'] == null ? null : json['rrating'],
    externalOptions:
    json['externalOptions'] == null ? null : json['externalOptions'],
    onlyForPaid:
    json['only_for_paid'] == null ? null : json['only_for_paid'],
    seriePlaylistsId: json['serie_playlists_id'],
    sitesId: json['sites_id'],
    videoPassword: json['videoPassword'] == null ? null : json['videoPassword'],
    encoderUrl: json['encoderURL'] == null ? null : json['encoderURL'],
    filepath: json['filepath'] == null ? null : json['filepath'],
    fileSize: json['filesize'] == null ? null : json['filesize'],
    pchannel: json['pchannel'] == null ? null : json['pchannel'],
    liveTransmitionsHistoryId: json['live_transmitions_history_id'] == null ? null : json['live_transmitions_history_id'],
    path: json['path'] == null ? null : json['path'],
    info: json['info'] == null
        ? null
        : List<Info>.from(
        json['info'].map((x) => Info.fromMap(x))),
    // category: json['category'] == null ? null : Category.fromMap(json['category']),


  );

  Map<String, dynamic> toMap() => {

    'playlists_id': playlistsId == null ? null : playlistsId,
    'videos_id': videosId == null ? null : videosId,
    'order': order == null ? null : order,
    'id': id == null ? null : id,
    'title': title == null ? null : title,
    'clean_title': cleanTitle == null ? null : cleanTitle,
    'description': description == null ? null : description,
    'views_count': viewsCount == null ? null : viewsCount,
    'views_count_25': viewsCount25 == null ? null : viewsCount25,
    'views_count_50': viewsCount50 == null ? null : viewsCount50,
    'views_count_75': viewsCount75 == null ? null : viewsCount75,
    'views_count_100': viewsCount100 == null ? null : viewsCount100,
    'status': status == null ? null : status,
    'created': created == null ? null : created.toIso8601String(),
    'modified': modified == null ? null : modified.toIso8601String(),
    'users_id': usersId == null ? null : usersId,
    'categories_id': categoriesId == null ? null : categoriesId,
    'filename': filename == null ? null : filename,
    'duration': duration == null ? null : duration,
    'type': type == null ? null : type,
    'videoDownloadedLink':
    videoDownloadedLink == null ? null : videoDownloadedLink,
    'rotation': rotation == null ? null : rotation,
    'zoom': zoom == null ? null : zoom,
    'youtubeId': youtubeId == null ? null : youtubeId,
    'videoLink': videoLink == null ? null : videoLink,
    'next_videos_id': nextVideosId,
    'isSuggested': isSuggested == null ? null : isSuggested,
    'trailer1': trailer1 == null ? null : trailer1,
    'trailer2': trailer2 == null ? null : trailer2,
    'trailer3': trailer3 == null ? null : trailer3,
    'rate': rate == null ? null : rate,
    'can_download': canDownload == null ? null : canDownload,
    'can_share': canShare == null ? null : canShare,
    'rrating': rrating == null ? null : rrating,
    'externalOptions': externalOptions == null ? null : externalOptions,
    'only_for_paid': onlyForPaid == null ? null : onlyForPaid,
    'serie_playlists_id': seriePlaylistsId,
    'sites_id': sitesId,
    'videoPassword': videoPassword == null ? null : videoPassword,
    'encoderURL': encoderUrl == null ? null : encoderUrl,
    'filepath': filepath == null ? null : filepath,
    'filesize': fileSize == null ? null : fileSize,
    'pchannel': pchannel == null ? null : pchannel,
    'live_transmitions_history_id': liveTransmitionsHistoryId == null ? null : liveTransmitionsHistoryId,
    'path': path == null ? null : path,
    'info': info == null
        ? null
        : List<dynamic>.from(info.map((x) => x.toMap())),
    // 'category': category == null ? null : category.toMap(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.cleanName,
    this.description,
    this.nextVideoOrder,
    this.parentId,
    this.created,
    this.modified,
    this.iconClass,
    this.usersId,
    this.private,
    this.allowDownload,
    this.order,
  });

  dynamic id;
  String name;
  String cleanName;
  String description;
  String nextVideoOrder;
  String parentId;
  DateTime created;
  DateTime modified;
  String iconClass;
  dynamic usersId;
  dynamic private;
  dynamic allowDownload;
  dynamic order;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json['id'] == null ? null : json['id'],
    name: json['name'] == null ? null : json['name'],
    cleanName: json['cleanName'] == null ? null : json['cleanName'],
    description: json['description'] == null ? null : json['description'],
    nextVideoOrder: json['nextVideoOrder'] == null ? null : json['nextVideoOrder'],
    parentId: json['parentId'] == null ? null : json['parentId'],
    created:
    json['created'] == null ? null : DateTime.parse(json['created']),
    modified:
    json['modified'] == null ? null : DateTime.parse(json['modified']),
    iconClass: json['pin'] == null ? null : json['iconClass'],
    usersId: json['name'] == null ? null : json['usersId'],
    private: json['user'] == null ? null : json['private'],
    allowDownload: json['allowDownload'] == null ? null : json['allowDownload'],
    order: json['order'] == null ? null : json['order'],
  );

  Map<String, dynamic> toMap() => {
    'id': id == null ? null : id,
    'name': name == null ? null : name,
    'cleanName': cleanName == null ? null : cleanName,
    'description': usersId == null ? null : description,
    'nextVideoOrder': nextVideoOrder == null ? null : nextVideoOrder,
    'parentId': parentId == null ? null : parentId,
    'created': created == null ? null : created.toIso8601String(),
    'modified': modified == null ? null : modified.toIso8601String(),
    'iconClass': iconClass == null ? null : iconClass,
    'usersId': usersId == null ? null : usersId,
    'private': private == null ? null : private,
    'allowDownload': allowDownload == null ? null : allowDownload,
    'order': order == null ? null : order,
  };
}

class Info {
  Info({
    this.label,
    this.type,
    this.text,
    this.tooltip,
  });

  String label;
  dynamic type;
  dynamic text;
  String tooltip;


  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
    label: json['label'] == null ? null : json['label'],
    type: json['type'] == null ? null : json['type'],
    text: json['text'] == null ? null : json['text'],
    tooltip: json['tooltip'] == null ? null : json['tooltip'],

  );

  Map<String, dynamic> toMap() => {
    'label': label == null ? null : label,
    'type': type == null ? null : type,
    'text': text == null ? null : text,
    'tooltip': tooltip == null ? null : tooltip,

  };
}







