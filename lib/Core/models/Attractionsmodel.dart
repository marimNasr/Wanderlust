import 'package:wonderlustapp/Core/API/Endpoints.dart';
import 'package:wonderlustapp/Core/models/modelsinterface.dart';

class Attractionsresponsemodel implements Modelsresponseinterface {
  @override
  final List<Attractionsmodel> attractions;

  Attractionsresponsemodel({required this.attractions,});

  // Implement the models getter to conform to Modelsresponseinterface
  @override
  List<Modelsinterface> get models => attractions;

  factory Attractionsresponsemodel.fromJson(Map<String, dynamic> json) {
    return Attractionsresponsemodel(
      attractions: List<Attractionsmodel>.from(
        json[ApiKeys.places]?.map((x) => Attractionsmodel.fromJson(x)) ?? [],
      ),
    );
  }
}

// Airportsmodel implementing Modelsinterface
class Attractionsmodel implements Modelsinterface {
  @override
  final String title;
  @override
  final double rating;
  @override
  final String website;

  Attractionsmodel({
    required this.title,
    required this.rating,
    required this.website,
  });

  factory Attractionsmodel.fromJson(Map<String, dynamic> json) {
    return Attractionsmodel(
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
