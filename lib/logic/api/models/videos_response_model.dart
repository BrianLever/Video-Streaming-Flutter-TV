// To parse this JSON data, do
//
//     final favorites = favoritesFromMap(jsonString);

import 'dart:convert';

VideosResponse videosResponseFromJson(dynamic str) =>
    VideosResponse.fromJson(str.runtimeType != String ? json.decode(str) : str);

dynamic videosResponseToJson(VideosResponse data) => json.encode(data.toJson());

class VideosResponse {
  VideosResponse({
    this.error,
    this.message,
    this.response,
  });

  dynamic error;
  String message;
  Response response;

  factory VideosResponse.fromJson(String str) =>
      VideosResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideosResponse.fromMap(Map<String, dynamic> json) => VideosResponse(
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
    this.sort,
    this.rowCount,
    this.totalRows,
    this.rows,
  });

  Sort sort;
  dynamic rowCount;
  dynamic totalRows;
  List<VideoData> rows;

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        sort: json['sort'] == null ? null : Sort.fromMap(json['sort']),
        rowCount: json['rowCount'] == null ? null : json['rowCount'],
        totalRows: json['totalRows'] == null ? null : json['totalRows'],
        rows: json['rows'] == null
            ? null
            : List<VideoData>.from(
                json['rows'].map((x) => VideoData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'sort': sort == null ? null : sort.toMap(),
        'rowCount': rowCount == null ? null : rowCount,
        'totalRows': totalRows == null ? null : totalRows,
        'rows': rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toMap())),
      };
}

class VideoData {
  VideoData({
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
    this.title,
    this.cleanTitle,
    this.description,
    this.viewsCount,
    this.viewsCount25,
    this.viewsCount50,
    this.viewsCount75,
    this.viewsCount100,
    this.usersId,
    this.categoriesId,
    this.filename,
    this.duration,
    this.type,
    this.videoDownloadedLink,
    this.order,
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
    this.onlyForPaid,
    this.seriePlaylistsId,
    this.sitesId,
    this.encoderUrl,
    this.filepath,
    this.filesize,
    this.pchannel,
    this.liveTransmitionsHistoryId,
    this.iconClass,
    this.category,
    this.cleanCategory,
    this.categoryDescription,
    this.videoCreation,
    this.videoModified,
    this.likes,
    this.dislikes,
    this.groups,
    this.tags,
    this.descriptionHtml,
    this.progress,
    this.isFavorite,
    this.isWatchLater,
    this.favoriteId,
    this.watchLaterId,
    this.videoTags,
    this.videoTagsObject,
    this.playlists,
    this.images,
    this.videos,
    this.poster,
    this.thumbnail,
    this.imageClass,
    this.createdHumanTiming,
    this.pageUrl,
    this.embedUrl,
    this.userPhoto,
    this.isSubscribed,
    this.subtitles,
    this.comments,
    this.commentsTotal,
    this.subscribers,
    this.wwbnUrl,
    this.wwbnEmbedUrl,
    this.wwbnImgThumbnail,
    this.wwbnImgPoster,
    this.wwbnTitle,
    this.wwbnDescription,
    this.wwbnChannelUrl,
    this.wwbnImgChannel,
    this.wwbnType,
  });

  dynamic id;
  String user;
  String name;
  String email;
  DateTime created;
  DateTime modified;
  dynamic isAdmin;
  String status;
  String photoUrl;
  DateTime lastLogin;
  dynamic backgroundUrl;
  dynamic canStream;
  dynamic canUpload;
  dynamic canViewChart;
  String about;
  String channelName;
  dynamic emailVerified;
  String analyticsCode;
  dynamic externalOptions;
  dynamic firstName;
  dynamic lastName;
  dynamic address;
  dynamic zipCode;
  dynamic country;
  dynamic region;
  dynamic city;
  String donationLink;
  dynamic canCreateMeet;
  dynamic extraInfo;
  String title;
  String cleanTitle;
  String description;
  dynamic viewsCount;
  dynamic viewsCount25;
  dynamic viewsCount50;
  dynamic viewsCount75;
  dynamic viewsCount100;
  dynamic usersId;
  dynamic categoriesId;
  String filename;
  String duration;
  String type;
  String videoDownloadedLink;
  dynamic order;
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
  dynamic onlyForPaid;
  dynamic seriePlaylistsId;
  dynamic sitesId;
  String encoderUrl;
  String filepath;
  dynamic filesize;
  String pchannel;
  dynamic liveTransmitionsHistoryId;
  IconClass iconClass;
  String category;
  String cleanCategory;
  String categoryDescription;
  DateTime videoCreation;
  DateTime videoModified;
  dynamic likes;
  dynamic dislikes;
  List<Group> groups;
  List<Tag> tags;
  String descriptionHtml;
  Progress progress;
  dynamic isFavorite;
  dynamic isWatchLater;
  dynamic favoriteId;
  dynamic watchLaterId;
  List<dynamic> videoTags;
  VideoTagsObject videoTagsObject;
  List<Playlist> playlists;
  Images images;
  Videos videos;
  String poster;
  String thumbnail;
  ImageClass imageClass;
  String createdHumanTiming;
  String pageUrl;
  String embedUrl;
  String userPhoto;
  dynamic isSubscribed;
  List<dynamic> subtitles;
  List<Comment> comments;
  dynamic commentsTotal;
  dynamic subscribers;
  String wwbnUrl;
  String wwbnEmbedUrl;
  String wwbnImgThumbnail;
  String wwbnImgPoster;
  String wwbnTitle;
  String wwbnDescription;
  String wwbnChannelUrl;
  String wwbnImgChannel;
  String wwbnType;

  factory VideoData.fromJson(String str) => VideoData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoData.fromMap(Map<String, dynamic> json) => VideoData(
        id: json['id'] == null ? null : json['id'],
        user: json['user'] == null ? null : json['user'],
        name: json['name'] == null ? null : json['name'],
        email: json['email'] == null ? null : json['email'],
        created:
            json['created'] == null ? null : DateTime.parse(json['created']),
        modified:
            json['modified'] == null ? null : DateTime.parse(json['modified']),
        isAdmin: json['isAdmin'] == null ? null : json['isAdmin'],
        status: json['status'] == null ? null : json['status'],
        photoUrl: json['photoURL'] == null ? null : json['photoURL'],
        lastLogin: json['lastLogin'] == null
            ? null
            : DateTime.parse(json['lastLogin']),
        backgroundUrl: json['backgroundURL'],
        canStream: json['canStream'] == null ? null : json['canStream'],
        canUpload: json['canUpload'] == null ? null : json['canUpload'],
        canViewChart:
            json['canViewChart'] == null ? null : json['canViewChart'],
        about: json['about'] == null ? null : json['about'],
        channelName: json['channelName'] == null ? null : json['channelName'],
        emailVerified:
            json['emailVerified'] == null ? null : json['emailVerified'],
        analyticsCode:
            json['analyticsCode'] == null ? null : json['analyticsCode'],
        externalOptions:
            json['externalOptions'] == null ? null : json['externalOptions'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        address: json['address'],
        zipCode: json['zip_code'],
        country: json['country'],
        region: json['region'],
        city: json['city'],
        donationLink:
            json['donationLink'] == null ? null : json['donationLink'],
        canCreateMeet: json['canCreateMeet'],
        extraInfo: json['extra_info'],
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
        usersId: json['users_id'] == null ? null : json['users_id'],
        categoriesId:
            json['categories_id'] == null ? null : json['categories_id'],
        filename: json['filename'] == null ? null : json['filename'],
        duration: json['duration'] == null ? null : json['duration'],
        type: json['type'] == null ? null : json['type'],
        videoDownloadedLink: json['videoDownloadedLink'] == null
            ? null
            : json['videoDownloadedLink'],
        order: json['order'] == null ? null : json['order'],
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
        onlyForPaid:
            json['only_for_paid'] == null ? null : json['only_for_paid'],
        seriePlaylistsId: json['serie_playlists_id'],
        sitesId: json['sites_id'],
        encoderUrl: json['encoderURL'] == null ? null : json['encoderURL'],
        filepath: json['filepath'] == null ? null : json['filepath'],
        filesize: json['filesize'] == null ? null : json['filesize'],
        pchannel: json['pchannel'] == null ? null : json['pchannel'],
        liveTransmitionsHistoryId: json['live_transmitions_history_id'],
        iconClass: json['iconClass'] == null
            ? null
            : iconClassValues.map[json['iconClass']],
        category: json['category'] == null ? null : json['category'],
        cleanCategory:
            json['clean_category'] == null ? null : json['clean_category'],
        categoryDescription: json['category_description'] == null
            ? null
            : json['category_description'],
        videoCreation: json['videoCreation'] == null
            ? null
            : DateTime.parse(json['videoCreation']),
        videoModified: json['videoModified'] == null
            ? null
            : DateTime.parse(json['videoModified']),
        likes: json['likes'] == null ? null : json['likes'],
        dislikes: json['dislikes'] == null ? null : json['dislikes'],
        groups: json['groups'] == null
            ? null
            : List<Group>.from(json['groups'].map((x) => Group.fromMap(x))),
        tags: json['tags'] == null
            ? null
            : List<Tag>.from(json['tags'].map((x) => Tag.fromMap(x))),
        descriptionHtml:
            json['descriptionHTML'] == null ? null : json['descriptionHTML'],
        progress: json['progress'] == null
            ? null
            : Progress.fromMap(json['progress']),
        isFavorite: json['isFavorite'] == null ? null : json['isFavorite'],
        isWatchLater:
            json['isWatchLater'] == null ? null : json['isWatchLater'],
        favoriteId: json['favoriteId'] == null ? null : json['favoriteId'],
        watchLaterId:
            json['watchLaterId'] == null ? null : json['watchLaterId'],
        videoTags: json['videoTags'] == null
            ? null
            : List<dynamic>.from(json['videoTags'].map((x) => x)),
        playlists: json['playlist'] == null
        ? null
        : List<Playlist>.from(json['playlist'].map((x) => Playlist.fromMap(x))),
        images: json['images'] == null ? null : Images.fromMap(json['images']),
        videos: json['videos'] == null
            ? null
            : json['videos'].isNotEmpty
            ? (json['videos'] is List ? List<Videos>.from(json['videos'].map((x) => Videos.fromMap(x))).first
            : Videos.fromMap(json['videos'])): null,
        poster: json['Poster'] == null ? null : json['Poster'],
        thumbnail: json['Thumbnail'] == null ? null : json['Thumbnail'],
        imageClass: json['imageClass'] == null
            ? null
            : imageClassValues.map[json['imageClass']],
        createdHumanTiming: json['createdHumanTiming'] == null
            ? null
            : json['createdHumanTiming'],
        pageUrl: json['pageUrl'] == null ? null : json['pageUrl'],
        embedUrl: json['embedUrl'] == null ? null : json['embedUrl'],
        userPhoto: json['UserPhoto'] == null ? null : json['UserPhoto'],
        isSubscribed:
            json['isSubscribed'] == null ? null : json['isSubscribed'],
        subtitles: json['subtitles'] == null
            ? null
            : List<dynamic>.from(json['subtitles'].map((x) => x)),
        comments: json['comments'] == null
            ? null
            : List<Comment>.from(
                json['comments'].map((x) => Comment.fromMap(x))),
        commentsTotal:
            json['commentsTotal'] == null ? null : json['commentsTotal'],
        subscribers: json['subscribers'] == null ? null : json['subscribers'],
        wwbnUrl: json['wwbnURL'] == null ? null : json['wwbnURL'],
        wwbnEmbedUrl:
            json['wwbnEmbedURL'] == null ? null : json['wwbnEmbedURL'],
        wwbnImgThumbnail:
            json['wwbnImgThumbnail'] == null ? null : json['wwbnImgThumbnail'],
        wwbnImgPoster:
            json['wwbnImgPoster'] == null ? null : json['wwbnImgPoster'],
        wwbnTitle: json['wwbnTitle'] == null ? null : json['wwbnTitle'],
        wwbnDescription:
            json['wwbnDescription'] == null ? null : json['wwbnDescription'],
        wwbnChannelUrl:
            json['wwbnChannelURL'] == null ? null : json['wwbnChannelURL'],
        wwbnImgChannel:
            json['wwbnImgChannel'] == null ? null : json['wwbnImgChannel'],
        wwbnType: json['wwbnType'] == null ? null : json['wwbnType'],
      );

  Map<String, dynamic> toMap() => {
        'id': id == null ? null : id,
        'user': user == null ? null : user,
        'name': name == null ? null : name,
        'email': email == null ? null : email,
        'created': created == null ? null : created.toIso8601String(),
        'modified': modified == null ? null : modified.toIso8601String(),
        'isAdmin': isAdmin == null ? null : isAdmin,
        'status': status == null ? null : status,
        'photoURL': photoUrl == null ? null : photoUrl,
        'lastLogin': lastLogin == null ? null : lastLogin.toIso8601String(),
        'backgroundURL': backgroundUrl,
        'canStream': canStream == null ? null : canStream,
        'canUpload': canUpload == null ? null : canUpload,
        'canViewChart': canViewChart == null ? null : canViewChart,
        'about': about == null ? null : about,
        'channelName': channelName == null ? null : channelName,
        'emailVerified': emailVerified == null ? null : emailVerified,
        'analyticsCode': analyticsCode == null ? null : analyticsCode,
        'externalOptions': externalOptions == null ? null : externalOptions,
        'first_name': firstName,
        'last_name': lastName,
        'address': address,
        'zip_code': zipCode,
        'country': country,
        'region': region,
        'city': city,
        'donationLink': donationLink == null ? null : donationLink,
        'canCreateMeet': canCreateMeet,
        'extra_info': extraInfo,
        'title': title == null ? null : title,
        'clean_title': cleanTitle == null ? null : cleanTitle,
        'description': description == null ? null : description,
        'views_count': viewsCount == null ? null : viewsCount,
        'views_count_25': viewsCount25 == null ? null : viewsCount25,
        'views_count_50': viewsCount50 == null ? null : viewsCount50,
        'views_count_75': viewsCount75 == null ? null : viewsCount75,
        'views_count_100': viewsCount100 == null ? null : viewsCount100,
        'users_id': usersId == null ? null : usersId,
        'categories_id': categoriesId == null ? null : categoriesId,
        'filename': filename == null ? null : filename,
        'duration': duration == null ? null : duration,
        'type': type == null ? null : type,
        'videoDownloadedLink':
            videoDownloadedLink == null ? null : videoDownloadedLink,
        'order': order == null ? null : order,
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
        'only_for_paid': onlyForPaid == null ? null : onlyForPaid,
        'serie_playlists_id': seriePlaylistsId,
        'sites_id': sitesId,
        'encoderURL': encoderUrl == null ? null : encoderUrl,
        'filepath': filepath == null ? null : filepath,
        'filesize': filesize == null ? null : filesize,
        'pchannel': pchannel == null ? null : pchannel,
        'live_transmitions_history_id': liveTransmitionsHistoryId,
        'iconClass':
            iconClass == null ? null : iconClassValues.reverse[iconClass],
        'category': category == null ? null : category,
        'clean_category': cleanCategory == null ? null : cleanCategory,
        'category_description':
            categoryDescription == null ? null : categoryDescription,
        'videoCreation':
            videoCreation == null ? null : videoCreation.toIso8601String(),
        'videoModified':
            videoModified == null ? null : videoModified.toIso8601String(),
        'likes': likes == null ? null : likes,
        'dislikes': dislikes == null ? null : dislikes,
        'groups': groups == null
            ? null
            : List<dynamic>.from(groups.map((x) => x.toMap())),
        'tags': tags == null
            ? null
            : List<dynamic>.from(tags.map((x) => x.toMap())),
        'descriptionHTML': descriptionHtml == null ? null : descriptionHtml,
        'progress': progress == null ? null : progress.toMap(),
        'isFavorite': isFavorite == null ? null : isFavorite.toMap(),
        'isWatchLater': isWatchLater == null ? null : isWatchLater.toMap(),
        'favoriteId': favoriteId == null ? null : favoriteId,
        'watchLaterId': watchLaterId == null ? null : watchLaterId,
        'videoTags': videoTags == null
            ? null
            : List<dynamic>.from(videoTags.map((x) => x)),
        'playlists': playlists == null
        ? null
        : List<dynamic>.from(playlists.map((x) => x.toMap())),
        'images': images == null ? null : images.toMap(),
        'videos': videos == null ? null : videos.toMap(),
        'Poster': poster == null ? null : poster,
        'Thumbnail': thumbnail == null ? null : thumbnail,
        'imageClass':
            imageClass == null ? null : imageClassValues.reverse[imageClass],
        'createdHumanTiming':
            createdHumanTiming == null ? null : createdHumanTiming,
        'pageUrl': pageUrl == null ? null : pageUrl,
        'embedUrl': embedUrl == null ? null : embedUrl,
        'UserPhoto': userPhoto == null ? null : userPhoto,
        'isSubscribed': isSubscribed == null ? null : isSubscribed,
        'subtitles': subtitles == null
            ? null
            : List<dynamic>.from(subtitles.map((x) => x)),
        'comments': comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x.toMap())),
        'commentsTotal': commentsTotal == null ? null : commentsTotal,
        'subscribers': subscribers == null ? null : subscribers,
        'wwbnURL': wwbnUrl == null ? null : wwbnUrl,
        'wwbnEmbedURL': wwbnEmbedUrl == null ? null : wwbnEmbedUrl,
        'wwbnImgThumbnail': wwbnImgThumbnail == null ? null : wwbnImgThumbnail,
        'wwbnImgPoster': wwbnImgPoster == null ? null : wwbnImgPoster,
        'wwbnTitle': wwbnTitle == null ? null : wwbnTitle,
        'wwbnDescription': wwbnDescription == null ? null : wwbnDescription,
        'wwbnChannelURL': wwbnChannelUrl == null ? null : wwbnChannelUrl,
        'wwbnImgChannel': wwbnImgChannel == null ? null : wwbnImgChannel,
        'wwbnType': wwbnType == null ? null : wwbnType,
      };
}

class Comment {
  Comment({
    this.id,
    this.comment,
    this.videosId,
    this.usersId,
    this.created,
    this.modified,
    this.commentsIdPai,
    this.pin,
    this.name,
    this.user,
    this.likes,
    this.dislikes,
    this.myVote,
    this.commentPlain,
    this.commentHtml,
    this.userPhotoUrl,
    this.userName,
  });

  dynamic id;
  String comment;
  dynamic videosId;
  dynamic usersId;
  DateTime created;
  DateTime modified;
  dynamic commentsIdPai;
  dynamic pin;
  String name;
  String user;
  dynamic likes;
  dynamic dislikes;
  dynamic myVote;
  String commentPlain;
  String commentHtml;
  String userPhotoUrl;
  String userName;

  factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        id: json['id'] == null ? null : json['id'],
        comment: json['comment'] == null ? null : json['comment'],
        videosId: json['videos_id'] == null ? null : json['videos_id'],
        usersId: json['users_id'] == null ? null : json['users_id'],
        created:
            json['created'] == null ? null : DateTime.parse(json['created']),
        modified:
            json['modified'] == null ? null : DateTime.parse(json['modified']),
        commentsIdPai: json['comments_id_pai'],
        pin: json['pin'] == null ? null : json['pin'],
        name: json['name'] == null ? null : json['name'],
        user: json['user'] == null ? null : json['user'],
        likes: json['likes'] == null ? null : json['likes'],
        dislikes: json['dislikes'] == null ? null : json['dislikes'],
        myVote: json['myVote'],
        commentPlain:
            json['commentPlain'] == null ? null : json['commentPlain'],
        commentHtml: json['commentHTML'] == null ? null : json['commentHTML'],
        userPhotoUrl:
            json['userPhotoURL'] == null ? null : json['userPhotoURL'],
        userName: json['userName'] == null ? null : json['userName'],
      );

  Map<String, dynamic> toMap() => {
        'id': id == null ? null : id,
        'comment': comment == null ? null : comment,
        'videos_id': videosId == null ? null : videosId,
        'users_id': usersId == null ? null : usersId,
        'created': created == null ? null : created.toIso8601String(),
        'modified': modified == null ? null : modified.toIso8601String(),
        'comments_id_pai': commentsIdPai,
        'pin': pin == null ? null : pin,
        'name': name == null ? null : name,
        'user': user == null ? null : user,
        'likes': likes == null ? null : likes,
        'dislikes': dislikes == null ? null : dislikes,
        'myVote': myVote,
        'commentPlain': commentPlain == null ? null : commentPlain,
        'commentHTML': commentHtml == null ? null : commentHtml,
        'userPhotoURL': userPhotoUrl == null ? null : userPhotoUrl,
        'userName': userName == null ? null : userName,
      };
}

class Group {
  Group({
    this.id,
    this.usersGroupsId,
    this.videosId,
    this.groupName,
    this.created,
    this.modified,
  });

  dynamic id;
  dynamic usersGroupsId;
  dynamic videosId;
  GroupName groupName;
  DateTime created;
  DateTime modified;

  factory Group.fromJson(String str) => Group.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Group.fromMap(Map<String, dynamic> json) => Group(
        id: json['id'] == null ? null : json['id'],
        usersGroupsId:
            json['users_groups_id'] == null ? null : json['users_groups_id'],
        videosId: json['videos_id'] == null ? null : json['videos_id'],
        groupName: json['group_name'] == null
            ? null
            : groupNameValues.map[json['group_name']],
        created:
            json['created'] == null ? null : DateTime.parse(json['created']),
        modified:
            json['modified'] == null ? null : DateTime.parse(json['modified']),
      );

  Map<String, dynamic> toMap() => {
        'id': id == null ? null : id,
        'users_groups_id': usersGroupsId == null ? null : usersGroupsId,
        'videos_id': videosId == null ? null : videosId,
        'group_name':
            groupName == null ? null : groupNameValues.reverse[groupName],
        'created': created == null ? null : created.toIso8601String(),
        'modified': modified == null ? null : modified.toIso8601String(),
      };
}

enum GroupName { EMPTY, PREMIUM, SUBSCRIPTION }

final groupNameValues = enumValues({
  '': GroupName.EMPTY,
  'Premium': GroupName.PREMIUM,
  'Subscription': GroupName.SUBSCRIPTION
});

enum IconClass { FA_FA_FW_ICONPICKER_COMPONENT, FA_FA_FILM }

final iconClassValues = enumValues({
  'fa fa-film': IconClass.FA_FA_FILM,
  'fa fa-fw iconpicker-component': IconClass.FA_FA_FW_ICONPICKER_COMPONENT
});

enum ImageClass { LANDSCAPE }

final imageClassValues = enumValues({'landscape': ImageClass.LANDSCAPE});

class Images {
  Images({
    this.poster,
    this.posterPortrait,
    this.posterPortraitPath,
    this.posterPortraitThumbs,
    this.posterPortraitThumbsSmall,
    this.thumbsGif,
    this.gifPortrait,
    this.thumbsJpg,
    this.thumbsJpgSmall,
    this.spectrumSource,
    this.posterLandscape,
    this.posterLandscapePath,
    this.posterLandscapeThumbs,
    this.posterLandscapeThumbsSmall,
  });

  String poster;
  String posterPortrait;
  String posterPortraitPath;
  String posterPortraitThumbs;
  String posterPortraitThumbsSmall;
  dynamic thumbsGif;
  dynamic gifPortrait;
  String thumbsJpg;
  String thumbsJpgSmall;
  dynamic spectrumSource;
  dynamic posterLandscape;
  dynamic posterLandscapePath;
  String posterLandscapeThumbs;
  String posterLandscapeThumbsSmall;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        poster: json['poster'] == null ? null : json['poster'],
        posterPortrait:
            json['posterPortrait'] == null ? null : json['posterPortrait'],
        posterPortraitPath: json['posterPortraitPath'] == null
            ? null
            : json['posterPortraitPath'],
        posterPortraitThumbs: json['posterPortraitThumbs'] == null
            ? null
            : json['posterPortraitThumbs'],
        posterPortraitThumbsSmall: json['posterPortraitThumbsSmall'] == null
            ? null
            : json['posterPortraitThumbsSmall'],
        thumbsGif: json['thumbsGif'] == null ? null : json['thumbsGif'],
        gifPortrait: json['gifPortrait'] == null ? null : json['gifPortrait'],
        thumbsJpg: json['thumbsJpg'] == null ? null : json['thumbsJpg'],
        thumbsJpgSmall:
            json['thumbsJpgSmall'] == null ? null : json['thumbsJpgSmall'],
        spectrumSource:
            json['spectrumSource'] == null ? null : json['spectrumSource'],
        posterLandscape:
            json['posterLandscape'] == null ? null : json['posterLandscape'],
        posterLandscapePath: json['posterLandscapePath'] == null
            ? null
            : json['posterLandscapePath'],
        posterLandscapeThumbs: json['posterLandscapeThumbs'] == null
            ? null
            : json['posterLandscapeThumbs'],
        posterLandscapeThumbsSmall: json['posterLandscapeThumbsSmall'] == null
            ? null
            : json['posterLandscapeThumbsSmall'],
      );

  Map<String, dynamic> toMap() => {
        'poster': poster == null ? null : poster,
        'posterPortrait': posterPortrait == null ? null : posterPortrait,
        'posterPortraitPath':
            posterPortraitPath == null ? null : posterPortraitPath,
        'posterPortraitThumbs':
            posterPortraitThumbs == null ? null : posterPortraitThumbs,
        'posterPortraitThumbsSmall': posterPortraitThumbsSmall == null
            ? null
            : posterPortraitThumbsSmall,
        'thumbsGif': thumbsGif == null ? null : thumbsGif,
        'gifPortrait': gifPortrait == null ? null : gifPortrait,
        'thumbsJpg': thumbsJpg == null ? null : thumbsJpg,
        'thumbsJpgSmall': thumbsJpgSmall == null ? null : thumbsJpgSmall,
        'spectrumSource': spectrumSource == null ? null : spectrumSource,
        'posterLandscape': posterLandscape == null ? null : posterLandscape,
        'posterLandscapePath':
            posterLandscapePath == null ? null : posterLandscapePath,
        'posterLandscapeThumbs':
            posterLandscapeThumbs == null ? null : posterLandscapeThumbs,
        'posterLandscapeThumbsSmall': posterLandscapeThumbsSmall == null
            ? null
            : posterLandscapeThumbsSmall,
      };
}

class Progress {
  Progress({
    this.percent,
    this.lastVideoTime,
  });

  dynamic percent;
  dynamic lastVideoTime;

  factory Progress.fromJson(String str) => Progress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Progress.fromMap(Map<String, dynamic> json) => Progress(
        percent: json['percent'] == null ? null : json['percent'],
        lastVideoTime:
            json['lastVideoTime'] == null ? null : json['lastVideoTime'],
      );

  Map<String, dynamic> toMap() => {
        'percent': percent == null ? null : percent,
        'lastVideoTime': lastVideoTime == null ? null : lastVideoTime,
      };
}

class Tag {
  Tag({
    this.label,
    this.type,
    this.text,
    this.tooltip,
  });

  String label;
  String type;
  dynamic text;
  GroupName tooltip;

  factory Tag.fromJson(String str) => Tag.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        label: json['label'] == null ? null : json['label'],
        type: json['type'] == null ? null : json['type'],
        text: json['text'],
        tooltip: json['tooltip'] == null
            ? null
            : groupNameValues.map[json['tooltip']],
      );

  Map<String, dynamic> toMap() => {
        'label': label == null ? null : label,
        'type': type == null ? null : type,
        'text': text,
        'tooltip': tooltip == null ? null : groupNameValues.reverse[tooltip],
      };
}


class Playlist {
  Playlist({
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
    this.encoderUrl,
    this.filepath,
    this.fileSize,
    this.pchannel,
    this.liveTransmitionsHistoryId,
    this.user,
    this.name,
    this.email,
    this.isAdmin,
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
    this.cre,
    this.videoOrder,
    this.likes,
    this.images,
    this.videos,
    this.progress,
    this.tags,
    this.videoTags,
    this.videoTagsObject,
    this.subtitles,

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
  String encoderUrl;
  String filepath;
  dynamic fileSize;
  String pchannel;
  dynamic liveTransmitionsHistoryId;
  String user;
  String name;
  String email;
  dynamic isAdmin;
  String photoUrl;
  DateTime lastLogin;
  dynamic backgroundUrl;
  dynamic canStream;
  dynamic canUpload;
  dynamic canViewChart;
  String about;
  String channelName;
  dynamic emailVerified;
  String analyticsCode;
  dynamic firstName;
  dynamic lastName;
  dynamic address;
  dynamic zipCode;
  dynamic country;
  dynamic region;
  dynamic city;
  String donationLink;
  dynamic canCreateMeet;
  dynamic extraInfo;
  DateTime cre;
  dynamic videoOrder;
  dynamic likes;
  Images images;
  Videos videos;
  Progress progress;
  List<Tag> tags;
  List<dynamic> videoTags;
  VideoTagsObject videoTagsObject;
  List<dynamic> subtitles;






  factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(

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
    encoderUrl: json['encoderURL'] == null ? null : json['encoderURL'],
    filepath: json['filepath'] == null ? null : json['filepath'],
    fileSize: json['filesize'] == null ? null : json['filesize'],
    pchannel: json['pchannel'] == null ? null : json['pchannel'],
    liveTransmitionsHistoryId: json['live_transmitions_history_id'] == null ? null : json['live_transmitions_history_id'],
    user: json['user'] == null ? null : json['user'],
    name: json['name'] == null ? null : json['name'],
    email: json['email'] == null ? null : json['email'],
    isAdmin: json['isAdmin'] == null ? null : json['isAdmin'],
    photoUrl: json['photoURL'] == null ? null : json['photoURL'],
    lastLogin: json['lastLogin'] == null
        ? null
        : DateTime.parse(json['lastLogin']),
    backgroundUrl: json['backgroundURL'],
    canStream: json['canStream'] == null ? null : json['canStream'],
    canUpload: json['canUpload'] == null ? null : json['canUpload'],
    canViewChart:
    json['canViewChart'] == null ? null : json['canViewChart'],
    about: json['about'] == null ? null : json['about'],
    channelName: json['channelName'] == null ? null : json['channelName'],
    emailVerified:
    json['emailVerified'] == null ? null : json['emailVerified'],
    analyticsCode:
    json['analyticsCode'] == null ? null : json['analyticsCode'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    address: json['address'],
    zipCode: json['zip_code'],
    country: json['country'],
    region: json['region'],
    city: json['city'],
    donationLink:
    json['donationLink'] == null ? null : json['donationLink'],
    canCreateMeet: json['canCreateMeet'],
    extraInfo: json['extra_info'],
    cre:
    json['cre'] == null ? null : DateTime.parse(json['cre']),
    videoOrder: json['video_order'] == null ? null : json['video_order'],
    likes: json['likes'] == null ? null : json['likes'],
    images: json['images'] == null ? null : Images.fromMap(json['images']),
    videos: json['videos'] == null
        ? null
        : json['videos'].isNotEmpty
        ? (json['videos'] is List ? List<Videos>.from(json['videos'].map((x) => Videos.fromMap(x))).first
        : Videos.fromMap(json['videos'])): null,
    progress: json['progress'] == null
        ? null
        : Progress.fromMap(json['progress']),
    tags: json['tags'] == null
        ? null
        : List<Tag>.from(json['tags'].map((x) => Tag.fromMap(x))),
    videoTags: json['videoTags'] == null
        ? null
        : List<dynamic>.from(json['videoTags'].map((x) => x)),
    subtitles: json['subtitles'] == null
        ? null
        : List<dynamic>.from(json['subtitles'].map((x) => x)),

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
    'encoderURL': encoderUrl == null ? null : encoderUrl,
    'filepath': filepath == null ? null : filepath,
    'filesize': fileSize == null ? null : fileSize,
    'pchannel': pchannel == null ? null : pchannel,
    'live_transmitions_history_id': liveTransmitionsHistoryId == null ? null : liveTransmitionsHistoryId,
    'user': user == null ? null : user,
    'name': name == null ? null : name,
    'email': email == null ? null : email,
    'isAdmin': isAdmin == null ? null : isAdmin,
    'status': status == null ? null : status,
    'photoURL': photoUrl == null ? null : photoUrl,
    'lastLogin': lastLogin == null ? null : lastLogin.toIso8601String(),
    'backgroundURL': backgroundUrl,
    'canStream': canStream == null ? null : canStream,
    'canUpload': canUpload == null ? null : canUpload,
    'canViewChart': canViewChart == null ? null : canViewChart,
    'about': about == null ? null : about,
    'channelName': channelName == null ? null : channelName,
    'emailVerified': emailVerified == null ? null : emailVerified,
    'analyticsCode': analyticsCode == null ? null : analyticsCode,
    'first_name': firstName,
    'last_name': lastName,
    'address': address,
    'zip_code': zipCode,
    'country': country,
    'region': region,
    'city': city,
    'donationLink': donationLink == null ? null : donationLink,
    'canCreateMeet': canCreateMeet,
    'extra_info': extraInfo,
    'cre':
    cre == null ? null : cre.toIso8601String(),
    'video_order': videoOrder == null ? null : videoOrder,
    'likes': likes == null ? null : likes,
    'images': images == null ? null : images.toMap(),
    'videos': videos == null
        ? null
        : videos.toMap(),
    'progress': progress == null ? null : progress.toMap(),
    'tags': tags == null
        ? null
        : List<dynamic>.from(tags.map((x) => x.toMap())),

    'videoTags': videoTags == null
        ? null
        : List<dynamic>.from(videoTags.map((x) => x)),

    'subtitles': subtitles == null
        ? null
        : List<dynamic>.from(subtitles.map((x) => x)),
  };
}

class VideoTagsObject {
  VideoTagsObject();

  factory VideoTagsObject.fromJson(String str) =>
      VideoTagsObject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoTagsObject.fromMap(Map<String, dynamic> json) =>
      VideoTagsObject();

  Map<String, dynamic> toMap() => {};
}

class Videos {
  Videos({this.mp4});

  Mp4 mp4;

  factory Videos.fromJson(String str) => Videos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Videos.fromMap(Map<String, dynamic> json) => Videos(
        mp4: json['mp4'] == null ? null : Mp4.fromMap(json['mp4']),
      );

  Map<String, dynamic> toMap() => {
        'mp4': mp4 == null ? null : mp4.toMap(),
      };
}

class Mp4 {
  Mp4({this.low, this.sd, this.hd});

  String low;
  String sd;
  String hd;

  factory Mp4.fromJson(String str) => Mp4.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mp4.fromMap(Map<String, dynamic> json) => Mp4(
        low: json['Low'] == null ? null : json['Low'],
        sd: json['SD'] == null ? null : json['SD'],
        hd: json['HD'] == null ? null : json['HD'],
      );

  Map<String, dynamic> toMap() => {
        'Low': low == null ? null : low,
        'SD': sd == null ? null : sd,
        'HD': hd == null ? null : hd,
      };
}

class Sort {
  Sort({this.likes});

  String likes;

  factory Sort.fromJson(String str) => Sort.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sort.fromMap(Map<String, dynamic> json) => Sort(
        likes: json['likes'] == null ? null : json['likes'],
      );

  Map<String, dynamic> toMap() => {
        'likes': likes == null ? null : likes,
      };
}

class enumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  enumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
