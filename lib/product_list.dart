import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/providers/product_provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prodsList = context.watch<ProductProvider>().prodList;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: prodsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(prodsList[index].name ?? "No Name"),
            subtitle: Text("Color: ${prodsList[index].data?.color ?? "N/A"}"),
          );
        },
      ),
    );
  }
}
