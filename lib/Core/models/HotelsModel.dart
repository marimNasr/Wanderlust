

import '../API/Endpoints.dart';
import 'modelsinterface.dart';

class Hotelsresponsemodel implements Modelsresponseinterface {
  @override
  final List<Hotelsmodel> Hotels;

  Hotelsresponsemodel({required this.Hotels});

  // Implement the models getter to conform to Modelsresponseinterface
  @override
  List<Modelsinterface> get models => Hotels;

  factory Hotelsresponsemodel.fromJson(Map<String, dynamic> json) {
    return Hotelsresponsemodel(
      Hotels: List<Hotelsmodel>.from(
        json[ApiKeys.places]?.map((x) => Hotelsmodel.fromJson(x)) ?? [],
      ),
    );
  }
}

// Airportsmodel implementing Modelsinterface
class Hotelsmodel implements Modelsinterface {
  @override
  final String title;
  @override
  final double rating;
  @override
  final String website;

  Hotelsmodel({
    required this.title,
    required this.rating,
    required this.website,
  });

  factory Hotelsmodel.fromJson(Map<String, dynamic> json) {
    return Hotelsmodel(
      title: json[ApiKeys.title] ?? "",
      rating: (json[ApiKeys.rating] != null)
          ? json[ApiKeys.rating].toDouble()
          : 0.0,
      website: json[ApiKeys.website] ??
          (json[ApiKeys.prices] != null && json[ApiKeys.prices].isNotEmpty
              ? json[ApiKeys.prices][0][ApiKeys.source] ?? ""
              : ""),
    );
  }
}
