import 'package:graduation/Core/API/Endpoints.dart';

class HotelsResponseModel {
  final List<HotelsModel> hotels;

  HotelsResponseModel({required this.hotels});

  factory HotelsResponseModel.fromJson(Map<String, dynamic> json) {
    return HotelsResponseModel(
      hotels: List<HotelsModel>.from(json['properties']?.map((x) => HotelsModel.fromJson(x)) ?? []),
    );
  }
}

class HotelsModel {
  final String name;
  final String originalImage;
  final double overallRate;
  final String link;

  HotelsModel({
    required this.name,
    required this.originalImage,
    required this.overallRate,
    required this.link,
  });

  factory HotelsModel.fromJson(Map<String, dynamic> json) {
    return HotelsModel(
      name: json[ApiKeys.name] ?? "",
      originalImage: (json[ApiKeys.images] != null && json[ApiKeys.images].isNotEmpty)
          ? json[ApiKeys.images][0][ApiKeys.originalImage] ?? ""
          : '',
      overallRate: (json[ApiKeys.overallRating] != null) ? json[ApiKeys.overallRating].toDouble() : 0.0,
      link: json[ApiKeys.link] ?? (json[ApiKeys.prices] != null && json[ApiKeys.prices].isNotEmpty
          ? json[ApiKeys.prices][0][ApiKeys.source] ?? ""
          : ""),
    );
  }
}
