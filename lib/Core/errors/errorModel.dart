class ErrorModel {
  final String message;

  ErrorModel({required this.message});

  factory ErrorModel.fromJson(json) {
    return ErrorModel(
        message: json['error']);

  }
}