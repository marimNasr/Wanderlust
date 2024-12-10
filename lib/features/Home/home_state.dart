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
