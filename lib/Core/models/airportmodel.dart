import 'package:wonderlustapp/Core/API/Endpoints.dart';
import 'package:wonderlustapp/Core/models/modelsinterface.dart';

class Airportsresponsemodel implements Modelsresponseinterface {
  @override
  final List<Airportsmodel> airports;

  Airportsresponsemodel({required this.airports});

  // Implement the models getter to conform to Modelsresponseinterface
  @override
  List<Modelsinterface> get models => airports;

  factory Airportsresponsemodel.fromJson(Map<String, dynamic> json) {
    return Airportsresponsemodel(
      airports: List<Airportsmodel>.from(
        json[ApiKeys.places]?.map((x) => Airportsmodel.fromJson(x)) ?? [],
      ),
    );
  }
}

// Airportsmodel implementing Modelsinterface
class Airportsmodel implements Modelsinterface {
  @override
  final String title;
  @override
  final double rating;
  @override
  final String website;

  Airportsmodel({
    required this.title,
    required this.rating,
    required this.website,
  });

  factory Airportsmodel.fromJson(Map<String, dynamic> json) {
    return Airportsmodel(
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
