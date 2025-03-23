import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_ui/feature/home/bloc/home_bloc.dart';
import 'package:shopping_cart_ui/model/product_model.dart';
import 'package:shopping_cart_ui/widgets/brand_verified.dart';
import 'package:shopping_cart_ui/widgets/rounded_container.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.homeBloc, required this.product});
  final HomeBloc homeBloc;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 180,
              padding: EdgeInsets.all(8),
              child: Stack(
                children: [
                  // thumbnail image
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            Image.network(product.thumbnail, fit: BoxFit.cover),
                      ),
                    ),
                  ),

                  // sale tag
                  Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: 8,
                        backgroundColor: Color(0xFFFFE24B).withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          '${product.discountPercentage}%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: Colors.black),
                        ),
                      )),

                  // favourite icon button
                  Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            homeBloc.add(
                              HomeProductWishlistButtonClickedEvent(
                                  clickedProduct: product),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Item wishlisted')));
                          },
                          icon: Icon(Iconsax.heart5)))
                ],
              ),
            ),

            SizedBox(
              height: 6,
            ),

            // Details
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.labelLarge),
                    SizedBox(height: 8),
                    // brand name with verified icon
                    TBrandTitleWithVerifiedIcon(title: product.brand)
                  ],
                ),
              ),
            ),
            const Spacer(),
            // price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // price
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('₹' + '${product.price}'),
                ),
                // add to card button
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF272727),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(16))),
                  child: GestureDetector(
                    onTap: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: product));
                    },
                    child: const SizedBox(
                        width: 32,
                        height: 32,
                        child: Center(
                            child: Icon(
                          Iconsax.add,
                          color: Colors.white,
                        ))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
