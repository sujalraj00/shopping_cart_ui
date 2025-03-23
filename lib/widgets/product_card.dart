import 'package:flutter/material.dart';
import 'package:shopping_cart_ui/feature/home/bloc/home_bloc.dart';
import 'package:shopping_cart_ui/model/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.homeBloc, required this.product});
  final HomeBloc homeBloc;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
                image: DecorationImage(
                    image: NetworkImage(product.image), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            product.description,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '\$' + product.price.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishlistButtonClickedEvent(
                            clickedProduct: product));
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonClickedEvent(
                            clickedProduct: product));
                      },
                      icon: Icon(Icons.shopping_cart_outlined)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
