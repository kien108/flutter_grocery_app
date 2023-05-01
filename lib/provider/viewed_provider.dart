import 'package:flutter/material.dart';
import 'package:hihiienngok/models/viewed_model.dart';

class ViewedProvider with ChangeNotifier {
  Map<String, ViewedProdModel> _viewedItems = {};

  Map<String, ViewedProdModel> get getViewedItems {
    return _viewedItems;
  }

  void addToViewed({required String productId}) {
    _viewedItems.putIfAbsent(
        productId,
        () => ViewedProdModel(
            id: DateTime.now().toString(), productId: productId));

    notifyListeners();
  }

  void clearViewed() {
    _viewedItems.clear();
    notifyListeners();
  }
}
