import 'package:nasa_media/features/domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  SpaceMediaModel({
    required description,
    required mediaType,
    required title,
    required mediaUrl,
  }) : super(
            description: description,
            mediaType: mediaType,
            title: title,
            mediaUrl: mediaUrl);

  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) {
    return SpaceMediaModel(
        description: json['explanation'],
        mediaType: json['media_type'],
        title: json['title'],
        mediaUrl: json['url']);
  }

  Map<String, dynamic> toJson() => {
        'explanation': description,
        'media_type': mediaType,
        'title': title,
        'url': mediaUrl,
      };
}
