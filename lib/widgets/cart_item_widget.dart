// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shopping_cart_ui/feature/cart/bloc/cart_bloc.dart';
import 'package:shopping_cart_ui/model/product_model.dart';

class CartTileWidget extends StatelessWidget {
  const CartTileWidget({
    Key? key,
    required this.cartBloc,
    required this.productDataModel,
  }) : super(key: key);
  final CartBloc cartBloc;

  final Product productDataModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.thumbnail))),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            productDataModel.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                '\$' + productDataModel.price.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        cartBloc.add(
                            CartRemoveFromCartEvent(product: productDataModel));
                      },
                      icon: const Icon(Icons.shopping_bag)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
