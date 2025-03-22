part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final Product clickedProduct;

  HomeProductWishlistButtonClickedEvent({required this.clickedProduct});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final Product clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeWishListButtonNavigationEvent extends HomeEvent {}

class HomeCartButtonNavigationEvent extends HomeEvent {}
