

import 'dart:convert';

ThumbResponse thumbResponseFromJson(dynamic str) =>
    ThumbResponse.fromJson(str.runtimeType != String ? json.decode(str) : str);

dynamic thumbResponseeToJson(ThumbResponse data) => json.encode(data.toJson());

class ThumbResponse {
  ThumbResponse({
    this.error,
    this.message,
    this.response,
  });

  dynamic error;
  String message;
  Response response;

  factory ThumbResponse.fromJson(String str) =>
      ThumbResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ThumbResponse.fromMap(Map<String, dynamic> json) => ThumbResponse(
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
    this.videosID,
    this.filename,
    this.videoFile,
    this.sources,
    this.images,
  });

  dynamic videosID;
  String filename;
  String videoFile;
  List<Source> sources;
  Images images;

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => Response(
    videosID: json['videos_id'] == null ? null : json['videos_id'],
    filename: json['filename'] == null ? null : json['filename'],
    videoFile: json['video_file'] == null ? null : json['video_file'],
    sources: json['sources'] == null
        ? null
        : List<Source>.from(
        json['sources'].map((x) => Source.fromMap(x))),
    images: json['images'] == null ? null : Images.fromMap(json['images']),
  );

  Map<String, dynamic> toMap() => {
    'videosID': videosID == null ? null : videosID,
    'filename': filename == null ? null : filename,
    'videoFile': videoFile == null ? null : videoFile,
    'sources': sources == null
        ? null
        : List<dynamic>.from(sources.map((x) => x.toMap())),
    'images': images == null ? null : images.toMap(),
  };
}

class Source {
  Source({
    this.type,
    this.src,

  });


  String type;
  String src;


  factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Source.fromMap(Map<String, dynamic> json) => Source(

    type: json['type'] == null ? null : json['type'],
    src: json['src'] == null ? null : json['src'],

  );

  Map<String, dynamic> toMap() => {

    'type': type == null ? null : type,
    'text': src == null ? null : src,

  };
}








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
  String posterLandscape;
  String posterLandscapePath;
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