import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_ui/feature/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_ui/model/product_model.dart';
import 'package:shopping_cart_ui/services/api_services.dart';
import 'package:shopping_cart_ui/widgets/grid_layout.dart';
import 'package:shopping_cart_ui/widgets/product_card.dart';

import '../../cart/ui/cart_screen.dart';
import '../../profile/ui/profile_screen.dart';

class HomeScreenNav extends StatefulWidget {
  const HomeScreenNav({super.key});

  @override
  State<HomeScreenNav> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenNav> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [HomePage(), ProfileScreen(), Cart()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0.5,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Iconsax.shop), label: "Cart"),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Wishlisted')));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item added to Cart')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Product Catalogue'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      homeBloc.add(HomeWishListButtonNavigationEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_bag),
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigationEvent());
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: GridLayout(
                        itemCount: successState.products.length,
                        itemBuilder: (_, index) => ProductCard(
                            homeBloc: homeBloc,
                            product: successState.products[index])),
                  );

                  // return ProductCard(
                  //     homeBloc: homeBloc,
                  //     product: successState.products[index]);
                },
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
