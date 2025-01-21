import '../API/Endpoints.dart';

// Interface definitions
abstract class Modelsresponseinterface {
  List<Modelsinterface> get models;
}

abstract class Modelsinterface {
  String get title;
  double get rating;
  String get website;
}

