

import '../API/Endpoints.dart';
import 'modelsinterface.dart';

class Restaurantsresponsemodel implements Modelsresponseinterface {
  @override
  final List<Restaurantsmodel> restaurants;

  Restaurantsresponsemodel({required this.restaurants});

  // Implement the models getter to conform to Modelsresponseinterface
  @override
  List<Modelsinterface> get models => restaurants;

  factory Restaurantsresponsemodel.fromJson(Map<String, dynamic> json) {
    return Restaurantsresponsemodel(
      restaurants: List<Restaurantsmodel>.from(
        json[ApiKeys.places]?.map((x) => Restaurantsmodel.fromJson(x)) ?? [],
      ),
    );
  }
}

// Airportsmodel implementing Modelsinterface
class Restaurantsmodel implements Modelsinterface {
  @override
  final String title;
  @override
  final double rating;
  @override
  final String website;

  Restaurantsmodel({
    required this.title,
    required this.rating,
    required this.website,
  });

  factory Restaurantsmodel.fromJson(Map<String, dynamic> json) {
    return Restaurantsmodel(
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
