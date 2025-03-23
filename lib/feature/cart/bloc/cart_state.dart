part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState{}

final class CartInitial extends CartState {}

class CartSuccessState extends CartState{
    final List<Product> cartItems;

  CartSuccessState({required this.cartItems});
}