import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart_ui/model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
