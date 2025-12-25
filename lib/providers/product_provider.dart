import 'package:flutter/material.dart';
import 'package:provider_practice/model/product_model.dart';
import 'package:provider_practice/repositories/product_repository.dart';
import 'package:provider_practice/utility.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _prodList = [];
  List<Product> get prodList => _prodList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getProducts() async {
    List<Product> blankList = [];
    setIsLoading(true);
    var response = await ProductRepository.getProductList();
    print("Response: ${response.toString()}");
    if (response == null) {
      Utility.showToast(message: "Error");
      setIsLoading(false);
      _prodList.addAll(blankList);
    } else {
      setIsLoading(false);
      _prodList = response ?? blankList;
    }
    notifyListeners();
  }

  addProducts(Product product) {
    _prodList.add(product);
    notifyListeners();
  }

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
