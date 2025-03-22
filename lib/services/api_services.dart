import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_cart_ui/model/product_model.dart';

class ApiServices {
  final String baseUrl = "https://dummyjson.com/products";

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // here we extract product list and map to the product model
      final List<dynamic> productList = data['products'];
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
