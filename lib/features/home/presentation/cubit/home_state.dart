part of 'home_cubit.dart';


@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HotelLoading extends HomeState {}
class HotelSuccess extends HomeState {}
class HotelError extends HomeState {
  final String error;
  HotelError(this.error);
}

class RestaurantLoading extends HomeState {}
class RestaurantSuccess extends HomeState {}
class RestaurantError extends HomeState {
  final String error;
  RestaurantError(this.error);
}

class AttractionLoading extends HomeState {}
class AttractionSuccess extends HomeState {}
class AttractionError extends HomeState {
  final String error;
  AttractionError(this.error);
}

class AirportLoading extends HomeState {}
class AirportSuccess extends HomeState {}
class AirportError extends HomeState {
  final String error;
  AirportError(this.error);
}
