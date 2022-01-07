class UserInfo {
  int id;
  String user;
  String name;
  String email;
  String created;
  String modified;
  int isAdmin;
  String status;
  Null photoURL;
  String lastLogin;
  Null backgroundURL;
  int canStream;
  int canUpload;
  int canViewChart;
  String about;
  String channelName;
  int emailVerified;
  String analyticsCode;
  String externalOptions;
  Null firstName;
  Null lastName;
  Null address;
  Null zipCode;
  Null country;
  Null region;
  Null city;
  String donationLink;
  int canCreateMeet;
  Null extraInfo;
  int usersId;
  int showOnTV;
  String nameTranslated;
  List<Videos> videos;
  bool isFavorite;
  bool isWatchLater;

  UserInfo(
      {this.id,
      this.user,
      this.name,
      this.email,
      this.created,
      this.modified,
      this.isAdmin,
      this.status,
      this.photoURL,
      this.lastLogin,
      this.backgroundURL,
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
      this.showOnTV,
      this.nameTranslated,
      this.videos,
      this.isFavorite,
      this.isWatchLater});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    name = json['name'];
    email = json['email'];
    created = json['created'];
    modified = json['modified'];
    isAdmin = json['isAdmin'];
    status = json['status'];
    photoURL = json['photoURL'];
    lastLogin = json['lastLogin'];
    backgroundURL = json['backgroundURL'];
    canStream = json['canStream'];
    canUpload = json['canUpload'];
    canViewChart = json['canViewChart'];
    about = json['about'];
    channelName = json['channelName'];
    emailVerified = json['emailVerified'];
    analyticsCode = json['analyticsCode'];
    externalOptions = json['externalOptions'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    zipCode = json['zip_code'];
    country = json['country'];
    region = json['region'];
    city = json['city'];
    donationLink = json['donationLink'];
    canCreateMeet = json['canCreateMeet'];
    extraInfo = json['extra_info'];
    usersId = json['users_id'];
    showOnTV = json['showOnTV'];
    nameTranslated = json['name_translated'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos.add(Videos.fromJson(v));
      });
    }
    isFavorite = json['isFavorite'];
    isWatchLater = json['isWatchLater'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['isAdmin'] = this.isAdmin;
    data['status'] = this.status;
    data['photoURL'] = this.photoURL;
    data['lastLogin'] = this.lastLogin;
    data['backgroundURL'] = this.backgroundURL;
    data['canStream'] = this.canStream;
    data['canUpload'] = this.canUpload;
    data['canViewChart'] = this.canViewChart;
    data['about'] = this.about;
    data['channelName'] = this.channelName;
    data['emailVerified'] = this.emailVerified;
    data['analyticsCode'] = this.analyticsCode;
    data['externalOptions'] = this.externalOptions;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['region'] = this.region;
    data['city'] = this.city;
    data['donationLink'] = this.donationLink;
    data['canCreateMeet'] = this.canCreateMeet;
    data['extra_info'] = this.extraInfo;
    data['users_id'] = this.usersId;
    data['showOnTV'] = this.showOnTV;
    data['name_translated'] = this.nameTranslated;
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    data['isFavorite'] = this.isFavorite;
    data['isWatchLater'] = this.isWatchLater;
    return data;
  }
}

class Videos {
  int playlistsId;
  int videosId;
  int order;
  int id;
  String title;
  String cleanTitle;
  String description;
  int viewsCount;
  int viewsCount25;
  int viewsCount50;
  int viewsCount75;
  int viewsCount100;
  String status;
  String created;
  String modified;
  int usersId;
  int categoriesId;
  String filename;
  String duration;
  String type;
  String videoDownloadedLink;
  int rotation;
  int zoom;
  String youtubeId;
  String videoLink;
  Null nextVideosId;
  int isSuggested;
  String trailer1;
  String trailer2;
  String trailer3;
  int rate;
  int canDownload;
  int canShare;
  String rrating;
  String externalOptions;
  int onlyForPaid;
  Null seriePlaylistsId;
  Null sitesId;
  String encoderURL;
  String filepath;
  int filesize;
  String pchannel;
  Null liveTransmitionsHistoryId;
  String user;
  String name;
  String email;
  int isAdmin;
  String photoURL;
  String lastLogin;
  Null backgroundURL;
  int canStream;
  int canUpload;
  int canViewChart;
  String about;
  String channelName;
  int emailVerified;
  String analyticsCode;
  Null firstName;
  Null lastName;
  Null address;
  Null zipCode;
  Null country;
  Null region;
  Null city;
  String donationLink;
  Null canCreateMeet;
  Null extraInfo;
  String cre;
  int videoOrder;
  int likes;
  Images images;
  Videos videos;
  Progress progress;
  List<Tags> tags;
  List videoTags;
  List videoTagsObject;
  List subtitles;
  VideosURL videosURL;

  Videos(
      {this.playlistsId,
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
      this.encoderURL,
      this.filepath,
      this.filesize,
      this.pchannel,
      this.liveTransmitionsHistoryId,
      this.user,
      this.name,
      this.email,
      this.isAdmin,
      this.photoURL,
      this.lastLogin,
      this.backgroundURL,
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
      this.videosURL});

  Videos.fromJson(Map<String, dynamic> json) {
    playlistsId = json['playlists_id'];
    videosId = json['videos_id'];
    order = json['order'];
    id = json['id'];
    title = json['title'];
    cleanTitle = json['clean_title'];
    description = json['description'];
    viewsCount = json['views_count'];
    viewsCount25 = json['views_count_25'];
    viewsCount50 = json['views_count_50'];
    viewsCount75 = json['views_count_75'];
    viewsCount100 = json['views_count_100'];
    status = json['status'];
    created = json['created'];
    modified = json['modified'];
    usersId = json['users_id'];
    categoriesId = json['categories_id'];
    filename = json['filename'];
    duration = json['duration'];
    type = json['type'];
    videoDownloadedLink = json['videoDownloadedLink'];
    rotation = json['rotation'];
    zoom = json['zoom'];
    youtubeId = json['youtubeId'];
    videoLink = json['videoLink'];
    nextVideosId = json['next_videos_id'];
    isSuggested = json['isSuggested'];
    trailer1 = json['trailer1'];
    trailer2 = json['trailer2'];
    trailer3 = json['trailer3'];
    rate = json['rate'];
    canDownload = json['can_download'];
    canShare = json['can_share'];
    rrating = json['rrating'];
    externalOptions = json['externalOptions'];
    onlyForPaid = json['only_for_paid'];
    seriePlaylistsId = json['serie_playlists_id'];
    sitesId = json['sites_id'];
    encoderURL = json['encoderURL'];
    filepath = json['filepath'];
    filesize = json['filesize'];
    pchannel = json['pchannel'];
    liveTransmitionsHistoryId = json['live_transmitions_history_id'];
    user = json['user'];
    name = json['name'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    photoURL = json['photoURL'];
    lastLogin = json['lastLogin'];
    backgroundURL = json['backgroundURL'];
    canStream = json['canStream'];
    canUpload = json['canUpload'];
    canViewChart = json['canViewChart'];
    about = json['about'];
    channelName = json['channelName'];
    emailVerified = json['emailVerified'];
    analyticsCode = json['analyticsCode'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    zipCode = json['zip_code'];
    country = json['country'];
    region = json['region'];
    city = json['city'];
    donationLink = json['donationLink'];
    canCreateMeet = json['canCreateMeet'];
    extraInfo = json['extra_info'];
    cre = json['cre'];
    videoOrder = json['video_order'];
    likes = json['likes'];
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    videos = json['videos'] != null ? Videos.fromJson(json['videos']) : null;
    progress =
        json['progress'] != null ? Progress.fromJson(json['progress']) : null;
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags.add(Tags.fromJson(v));
      });
    }
    if (json['videoTags'] != null) {
      videoTags = [];
      json['videoTags'].forEach((v) {
        videoTags.add(v);
      });
    }
    if (json['videoTagsObject'] != null) {
      videoTagsObject = [];
      json['videoTagsObject'].forEach((v) {
        videoTagsObject.add(v);
      });
    }
    if (json['subtitles'] != null) {
      subtitles = [];
      json['subtitles'].forEach((v) {
        subtitles.add(v);
      });
    }
    videosURL = json['videosURL'] != null
        ? VideosURL.fromJson(json['videosURL'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['playlists_id'] = this.playlistsId;
    data['videos_id'] = this.videosId;
    data['order'] = this.order;
    data['id'] = this.id;
    data['title'] = this.title;
    data['clean_title'] = this.cleanTitle;
    data['description'] = this.description;
    data['views_count'] = this.viewsCount;
    data['views_count_25'] = this.viewsCount25;
    data['views_count_50'] = this.viewsCount50;
    data['views_count_75'] = this.viewsCount75;
    data['views_count_100'] = this.viewsCount100;
    data['status'] = this.status;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['users_id'] = this.usersId;
    data['categories_id'] = this.categoriesId;
    data['filename'] = this.filename;
    data['duration'] = this.duration;
    data['type'] = this.type;
    data['videoDownloadedLink'] = this.videoDownloadedLink;
    data['rotation'] = this.rotation;
    data['zoom'] = this.zoom;
    data['youtubeId'] = this.youtubeId;
    data['videoLink'] = this.videoLink;
    data['next_videos_id'] = this.nextVideosId;
    data['isSuggested'] = this.isSuggested;
    data['trailer1'] = this.trailer1;
    data['trailer2'] = this.trailer2;
    data['trailer3'] = this.trailer3;
    data['rate'] = this.rate;
    data['can_download'] = this.canDownload;
    data['can_share'] = this.canShare;
    data['rrating'] = this.rrating;
    data['externalOptions'] = this.externalOptions;
    data['only_for_paid'] = this.onlyForPaid;
    data['serie_playlists_id'] = this.seriePlaylistsId;
    data['sites_id'] = this.sitesId;
    data['encoderURL'] = this.encoderURL;
    data['filepath'] = this.filepath;
    data['filesize'] = this.filesize;
    data['pchannel'] = this.pchannel;
    data['live_transmitions_history_id'] = this.liveTransmitionsHistoryId;
    data['user'] = this.user;
    data['name'] = this.name;
    data['email'] = this.email;
    data['isAdmin'] = this.isAdmin;
    data['photoURL'] = this.photoURL;
    data['lastLogin'] = this.lastLogin;
    data['backgroundURL'] = this.backgroundURL;
    data['canStream'] = this.canStream;
    data['canUpload'] = this.canUpload;
    data['canViewChart'] = this.canViewChart;
    data['about'] = this.about;
    data['channelName'] = this.channelName;
    data['emailVerified'] = this.emailVerified;
    data['analyticsCode'] = this.analyticsCode;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['region'] = this.region;
    data['city'] = this.city;
    data['donationLink'] = this.donationLink;
    data['canCreateMeet'] = this.canCreateMeet;
    data['extra_info'] = this.extraInfo;
    data['cre'] = this.cre;
    data['video_order'] = this.videoOrder;
    data['likes'] = this.likes;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    if (this.videos != null) {
      data['videos'] = this.videos.toJson();
    }
    if (this.progress != null) {
      data['progress'] = this.progress.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.videoTags != null) {
      data['videoTags'] = this.videoTags.map((v) => v.toJson()).toList();
    }
    if (this.videoTagsObject != null) {
      data['videoTagsObject'] =
          this.videoTagsObject.map((v) => v.toJson()).toList();
    }
    if (this.subtitles != null) {
      data['subtitles'] = this.subtitles.map((v) => v.toJson()).toList();
    }
    if (this.videosURL != null) {
      data['videosURL'] = this.videosURL.toJson();
    }
    return data;
  }
}

class Images {
  String poster;
  String posterPortrait;
  String posterPortraitPath;
  String posterPortraitThumbs;
  String posterPortraitThumbsSmall;
  bool thumbsGif;
  bool gifPortrait;
  String thumbsJpg;
  String thumbsJpgSmall;
  bool spectrumSource;
  String posterLandscape;
  String posterLandscapePath;
  String posterLandscapeThumbs;
  String posterLandscapeThumbsSmall;

  Images(
      {this.poster,
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
      this.posterLandscapeThumbsSmall});

  Images.fromJson(Map<String, dynamic> json) {
    poster = json['poster'];
    posterPortrait = json['posterPortrait'];
    posterPortraitPath = json['posterPortraitPath'];
    posterPortraitThumbs = json['posterPortraitThumbs'];
    posterPortraitThumbsSmall = json['posterPortraitThumbsSmall'];
    thumbsGif = json['thumbsGif'];
    gifPortrait = json['gifPortrait'];
    thumbsJpg = json['thumbsJpg'];
    thumbsJpgSmall = json['thumbsJpgSmall'];
    spectrumSource = json['spectrumSource'];
    posterLandscape = json['posterLandscape'];
    posterLandscapePath = json['posterLandscapePath'];
    posterLandscapeThumbs = json['posterLandscapeThumbs'];
    posterLandscapeThumbsSmall = json['posterLandscapeThumbsSmall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['poster'] = this.poster;
    data['posterPortrait'] = this.posterPortrait;
    data['posterPortraitPath'] = this.posterPortraitPath;
    data['posterPortraitThumbs'] = this.posterPortraitThumbs;
    data['posterPortraitThumbsSmall'] = this.posterPortraitThumbsSmall;
    data['thumbsGif'] = this.thumbsGif;
    data['gifPortrait'] = this.gifPortrait;
    data['thumbsJpg'] = this.thumbsJpg;
    data['thumbsJpgSmall'] = this.thumbsJpgSmall;
    data['spectrumSource'] = this.spectrumSource;
    data['posterLandscape'] = this.posterLandscape;
    data['posterLandscapePath'] = this.posterLandscapePath;
    data['posterLandscapeThumbs'] = this.posterLandscapeThumbs;
    data['posterLandscapeThumbsSmall'] = this.posterLandscapeThumbsSmall;
    return data;
  }
}

class AllVideos {
  Mp4 mp4;

  AllVideos({this.mp4});

  AllVideos.fromJson(Map<String, dynamic> json) {
    mp4 = json['mp4'] != null ? Mp4.fromJson(json['mp4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.mp4 != null) {
      data['mp4'] = this.mp4.toJson();
    }
    return data;
  }
}

class Mp4 {
  String low;
  String sD;
  String hD;

  Mp4({this.low, this.sD, this.hD});

  Mp4.fromJson(Map<String, dynamic> json) {
    low = json['Low'];
    sD = json['SD'];
    hD = json['HD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Low'] = this.low;
    data['SD'] = this.sD;
    data['HD'] = this.hD;
    return data;
  }
}

class Progress {
  int percent;
  int lastVideoTime;

  Progress({this.percent, this.lastVideoTime});

  Progress.fromJson(Map<String, dynamic> json) {
    percent = json['percent'];
    lastVideoTime = json['lastVideoTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['percent'] = this.percent;
    data['lastVideoTime'] = this.lastVideoTime;
    return data;
  }
}

class Tags {
  String label;
  String type;
  String text;
  String tooltip;

  Tags({this.label, this.type, this.text, this.tooltip});

  Tags.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    type = json['type'];
    text = json['text'];
    tooltip = json['tooltip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['label'] = this.label;
    data['type'] = this.type;
    data['text'] = this.text;
    data['tooltip'] = this.tooltip;
    return data;
  }
}

class VideosURL {
  Webp webp;
  Webp gif;
  Webp jpgRoku;
  Webp jpgThumbsSprit;
  Webp jpg;
  Webp mp4Low;
  Webp mp4SD;
  Webp mp4HD;

  VideosURL(
      {this.webp,
      this.gif,
      this.jpgRoku,
      this.jpgThumbsSprit,
      this.jpg,
      this.mp4Low,
      this.mp4SD,
      this.mp4HD});

  VideosURL.fromJson(Map<String, dynamic> json) {
    webp = json['webp'] != null ? Webp.fromJson(json['webp']) : null;
    gif = json['gif'] != null ? Webp.fromJson(json['gif']) : null;
    jpgRoku = json['jpg_roku'] != null ? Webp.fromJson(json['jpg_roku']) : null;
    jpgThumbsSprit = json['jpg_thumbsSprit'] != null
        ? Webp.fromJson(json['jpg_thumbsSprit'])
        : null;
    jpg = json['jpg'] != null ? Webp.fromJson(json['jpg']) : null;
    mp4Low = json['mp4_Low'] != null ? Webp.fromJson(json['mp4_Low']) : null;
    mp4SD = json['mp4_SD'] != null ? Webp.fromJson(json['mp4_SD']) : null;
    mp4HD = json['mp4_HD'] != null ? Webp.fromJson(json['mp4_HD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.webp != null) {
      data['webp'] = this.webp.toJson();
    }
    if (this.gif != null) {
      data['gif'] = this.gif.toJson();
    }
    if (this.jpgRoku != null) {
      data['jpg_roku'] = this.jpgRoku.toJson();
    }
    if (this.jpgThumbsSprit != null) {
      data['jpg_thumbsSprit'] = this.jpgThumbsSprit.toJson();
    }
    if (this.jpg != null) {
      data['jpg'] = this.jpg.toJson();
    }
    if (this.mp4Low != null) {
      data['mp4_Low'] = this.mp4Low.toJson();
    }
    if (this.mp4SD != null) {
      data['mp4_SD'] = this.mp4SD.toJson();
    }
    if (this.mp4HD != null) {
      data['mp4_HD'] = this.mp4HD.toJson();
    }
    return data;
  }
}

class Webp {
  String filename;
  String path;
  String url;
  String type;
  String format;

  Webp({this.filename, this.path, this.url, this.type, this.format});

  Webp.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    path = json['path'];
    url = json['url'];
    type = json['type'];
    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['filename'] = this.filename;
    data['path'] = this.path;
    data['url'] = this.url;
    data['type'] = this.type;
    data['format'] = this.format;
    return data;
  }
}
