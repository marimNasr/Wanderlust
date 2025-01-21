part of 'fav_cubit.dart';

@immutable
sealed class FavState {}

final class FavInitial extends FavState {}
final class FavLoading extends FavState {}
final class FavSuccess extends FavState {
   final Map<String, dynamic> favourites;
  FavSuccess( {required this.favourites});
}
final class Favfail extends FavState {
  final String error;
  Favfail({required this.error});
}

