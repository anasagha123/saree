import 'package:flutter/material.dart';
import 'package:saree/models/product_model.dart';
import 'package:saree/network/remote/dio_helper.dart';

import '../models/category_model.dart';

enum MarketState { initial, loading, hasData, error }

enum MarketCategoriesState { initial, loading, hasData, error }

class MarketProvider with ChangeNotifier {
  List<ProductModel> products = [];
  MarketState marketState = MarketState.initial;

  List<CategoryModel> categories = [];
  MarketCategoriesState marketCategoriesState = MarketCategoriesState.initial;

  CategoryModel? selectedCategory;

  Future<void> getProducts() async {
    marketState = MarketState.loading;
    notifyListeners();

    try {
      await DioHelper.getData(path: EndPoints.market_products).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            products.clear();
            for (var product in val.data["data"]) {
              products.add(ProductModel.fromJson(product));
            }
            marketState = MarketState.hasData;
            notifyListeners();
          } else {
            throw ("error");
          }
        },
      );
    } catch (e) {
      marketState = MarketState.error;
    }
  }

  Future<void> getCategories() async {
    marketCategoriesState = MarketCategoriesState.loading;
    notifyListeners();

    try {
      await DioHelper.getData(path: EndPoints.market).then(
            (val) {
          if(val.statusCode == 200 && val.data["status"] == "success"){
            categories.clear();
            for(var category in val.data["data"]){
              categories.add(CategoryModel.fromJson(category));
            }
            marketCategoriesState = MarketCategoriesState.hasData;
            notifyListeners();
          } else {
            throw("error");
          }
        },
      );
    } catch (e) {}
  }

  Future<void> getProductsByCategory(CategoryModel category) async {
    selectedCategory = category;
    marketState = MarketState.loading;
    notifyListeners();

    try {
      await DioHelper.getData(path: EndPoints.filter_by_cat+ category.id.toString()).then(
            (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            products.clear();
            for (var product in val.data["data"]) {
              products.add(ProductModel.fromJson(product));
            }
            marketState = MarketState.hasData;
            notifyListeners();
          } else {
            throw ("error");
          }
        },
      );
    } catch (e) {
      marketState = MarketState.error;
    }
  }
}
