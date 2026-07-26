class GetBannerModel {
  final int id;
  final String title;
  final String url;
  final String message;
  final DateTime startDateTime;
  final DateTime endDateTime;

  GetBannerModel({
    required this.id,
    required this.title,
    required this.url,
    required this.message,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory GetBannerModel.fromJson(Map<String, dynamic> json) {
    return GetBannerModel(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      message: json['message'] as String,
      startDateTime: DateTime.parse(json['start_datetime'] as String),
      endDateTime: DateTime.parse(json['end_datetime'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'message': message,
      'start_datetime': startDateTime.toIso8601String(),
      'end_datetime': endDateTime.toIso8601String(),
    };
  }

  static List<GetBannerModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => GetBannerModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
