part of 'model.dart';

class Content extends Equatable {
  final String? id;
  final String? contentLink;
  final String? contentThumbnail;
  final String? contentTitle;
  final int? contentDuration;
  final String? contentDescription;
  final int? contentPrice;
  final List<dynamic>? contentInsights;

  const Content({
    this.id,
    this.contentLink,
    this.contentThumbnail,
    this.contentTitle,
    this.contentDuration,
    this.contentDescription,
    this.contentPrice,
    this.contentInsights,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as String?,
        contentLink: json['contentLink'] as String?,
        contentThumbnail: json['contentThumbnail'] as String?,
        contentTitle: json['contentTitle'] as String?,
        contentDuration: json['contentDuration'] as int?,
        contentDescription: json['contentDescription'] as String?,
        contentPrice: json['contentPrice'] as int?,
        contentInsights: json['contentInsights'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'contentLink': contentLink,
        'contentThumbnail': contentThumbnail,
        'contentTitle': contentTitle,
        'contentDuration': contentDuration,
        'contentDescription': contentDescription,
        'contentPrice': contentPrice,
        'contentInsights': contentInsights,
      };

  @override
  List<Object?> get props {
    return [
      id,
      contentLink,
      contentThumbnail,
      contentTitle,
      contentDuration,
      contentDescription,
      contentPrice,
      contentInsights,
    ];
  }
}
