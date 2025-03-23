import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart_ui/feature/cart/data/cart_items.dart';
import 'package:shopping_cart_ui/model/product_model.dart';
import 'package:shopping_cart_ui/services/api_services.dart';

import '../../wishlist/wishlist_items.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);

    // on<HomeWishListButtonNavigationEvent>(homeWishListButtonNavigationEvent);
    on<HomeCartButtonNavigationEvent>(homeCartButtonNavigationEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    final apiServices = ApiServices();
    // emit(HomeLoadedSuccessState(products: apiServices.getProducts.map((json) => Product(
    //   id: json['id'],
    //   title: json['title'],
    //   description: json['description'],
    //   category: json['category'],
    //   price: json['price'],
    //   discountPercentage: json['discountPercentage'],
    //   rating: json['rating'],
    //   stock: json['stock'],
    //   tags: json['tags'],
    //   brand: json['brand'],
    //   sku: json['sku'],
    //   weight: json['weight'],
    //   dimensions: json['dimensions'],
    //   warrantyInformation: json['warrantyInformation'],
    //   shippingInformation: json['shippingInformation'],
    //   availabilityStatus: json['availabilityStatus'],
    //   reviews: json['reviews'],
    //   returnPolicy: json['returnPolicy'],
    //   minimumOrderQuantity: json['minimumOrderQuantity'],
    //   meta: json['meta'],
    //   images: json['images'],
    //   thumbnail: json['thumbnail']
    // ))));
    emit(HomeLoadedSuccessState(products: await apiServices.getProducts()));
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('cart product clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeCartButtonNavigationEvent(
      HomeCartButtonNavigationEvent event, Emitter<HomeState> emit) {
    print('cart navigate clicked');
    emit(HomeNavigateToCartPageActionState());
  }
}

FutureOr<void> homeProductWishlistButtonClickedEvent(
    HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
  print('wishlist product clicked');
  wishlistItems.add(event.clickedProduct);

  emit(HomeProductItemWishlistedActionState());
}
