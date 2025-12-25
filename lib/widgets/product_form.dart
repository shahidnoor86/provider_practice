import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/model/product_model.dart';
import 'package:provider_practice/providers/product_provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  List<Map<String, dynamic>> products = [];

  void addProduct() {
    if (_formKey.currentState!.validate()) {
      final Product product = Product(
        id: idController.text,
        name: nameController.text,
        data: Data(
          color: colorController.text,
          capacity: capacityController.text,
        ),
      );

      print("New Product: $product");

      setState(() {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.addProducts(product);
      });

      // Clear fields
      idController.clear();
      nameController.clear();
      colorController.clear();
      capacityController.clear();
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                  validator: (value) => value!.isEmpty ? 'Enter ID' : null,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) => value!.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                  validator: (value) => value!.isEmpty ? 'Enter color' : null,
                ),
                TextFormField(
                  controller: capacityController,
                  decoration: const InputDecoration(labelText: 'Capacity'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter capacity' : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: addProduct,
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
