import 'package:flutter/material.dart';
import 'package:hihiienngok/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductProvider with ChangeNotifier {
  static List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  ProductModel findProductById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String category) {
    List<ProductModel> _categoryList = _productsList
        .where((element) =>
            element.category.toLowerCase().contains(category.toLowerCase()))
        .toList();

    return _categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return _searchList;
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      // _productsList.clear();
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              category: element.get('productCategoryName'),
              price: double.parse(
                element.get('price'),
              ),
              salePrice: element.get('salePrice').toDouble(),
              isOnSale: element.get('isOnSale'),
              isPiece: element.get('isPiece'),
            ));
      });
    });
    notifyListeners();
  }

  // static final List<ProductModel> _productsList = [
  //   ProductModel(
  //       id: '2424',
  //       title: 'Apricot',
  //       imageUrl:
  //           'https://www.shutterstock.com/image-photo/red-apple-isolated-on-white-600w-1727544364.jpg',
  //       category: 'Fruits',
  //       price: 0.99,
  //       salePrice: 0.35,
  //       isOnSale: true,
  //       isPiece: false),
  //   ProductModel(
  //       id: '13',
  //       title: 'Apricot1',
  //       imageUrl:
  //           'https://www.shutterstock.com/image-photo/red-apple-isolated-on-white-600w-1727544364.jpg',
  //       category: 'Fruits',
  //       price: 1.2,
  //       salePrice: 0.35,
  //       isOnSale: false,
  //       isPiece: false),
  //   ProductModel(
  //       id: '444',
  //       title: 'Apricot2',
  //       imageUrl:
  //           'https://www.shutterstock.com/image-photo/red-apple-isolated-on-white-600w-1727544364.jpg',
  //       category: 'Herbs',
  //       price: 1.3,
  //       salePrice: 0.35,
  //       isOnSale: false,
  //       isPiece: false),
  //   ProductModel(
  //       id: '445',
  //       title: 'Apricot2',
  //       imageUrl:
  //           'https://www.shutterstock.com/image-photo/red-apple-isolated-on-white-600w-1727544364.jpg',
  //       category: 'Fruits',
  //       price: 0.99,
  //       salePrice: 0.38,
  //       isOnSale: true,
  //       isPiece: true),
  //   ProductModel(
  //       id: '446',
  //       title: 'Apricot2',
  //       imageUrl:
  //           'https://www.shutterstock.com/image-photo/red-apple-isolated-on-white-600w-1727544364.jpg',
  //       category: 'Fruits',
  //       price: 0.99,
  //       salePrice: 0.35,
  //       isOnSale: false,
  //       isPiece: false),
  //   ProductModel(
  //       id: '446',
  //       title: 'Apricot2',
  //       imageUrl:
  //           'https://www.shutterstock.com/image-photo/red-apple-isolated-on-white-600w-1727544364.jpg',
  //       category: 'Fruits',
  //       price: 0.99,
  //       salePrice: 0.35,
  //       isOnSale: false,
  //       isPiece: false)
  // ];
}
