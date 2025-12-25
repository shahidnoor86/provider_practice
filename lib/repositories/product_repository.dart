import 'dart:convert';

import 'package:provider_practice/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  static Future<List<Product>> getProductList() async {
    List<Product> productList = [];

    Uri url = Uri.parse('https://api.restful-api.dev/objects');
    return http.get(url).then((data) async {
      print(data.body);
      if (data.statusCode == 200) {
        List<dynamic> list = data.body.isNotEmpty ? json.decode(data.body) : [];
        for (var i in list) {
          Product product = Product.fromJson(i);
          productList.add(product);
        }
        return productList;
      }
      return [];
    });
  }
}
