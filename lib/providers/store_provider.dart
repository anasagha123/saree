import 'package:flutter/material.dart';
import 'package:saree/models/category_model.dart';
import 'package:saree/models/product_model.dart';
import 'package:saree/models/store_model.dart';
import 'package:saree/network/remote/dio_helper.dart';

enum StoreDataState { initial, loading, hasData, error }

enum StoreCategoriesState { initial, loading, hasData, error }

enum ProductsState { initial, loading, hasData, error }

class StoreProvider with ChangeNotifier {
  StoreModel store;
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  CategoryModel? selectedCategory;


  StoreDataState storeDataState = StoreDataState.initial;
  StoreCategoriesState storeCategoriesState = StoreCategoriesState.initial;
  ProductsState productsState = ProductsState.initial;

  StoreProvider(this.store);

  Future<void> filterProducts(CategoryModel category) async {
    selectedCategory = category;

    await getStoreProducts();

    products = products.where((e) => e.category_id == category.id).toList();
    notifyListeners();
  }

  Future<void> getStoreData() async {
    storeDataState = StoreDataState.loading;
    notifyListeners();

    try {
      await DioHelper.getData(
              path: EndPoints.view_store_data + store.id.toString())
          .then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            store = StoreModel.fromJson(val.data["data"][0]);
            storeDataState = StoreDataState.hasData;
            notifyListeners();
          } else {
            throw ("حدث خطأ ما");
          }
        },
      );
    } catch (e) {
      storeDataState = StoreDataState.error;
      notifyListeners();
    }
  }

  Future<void> getCategories() async {
    storeCategoriesState = StoreCategoriesState.loading;
    notifyListeners();

    try {
      await DioHelper.getData(path: EndPoints.food + store.id.toString()).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            categories.clear();
            for (var category in val.data["data"]) {
              categories.add(CategoryModel.fromJson(category));
            }
            storeCategoriesState = StoreCategoriesState.hasData;
            notifyListeners();
          } else {
            throw ("حدث خطأ ما");
          }
        },
      );
    } catch (e) {
      storeCategoriesState = StoreCategoriesState.error;
      notifyListeners();
    }
  }

  Future<void> getStoreProducts() async {
    productsState = ProductsState.loading;
    notifyListeners();

    try {
      await DioHelper.getData(path: EndPoints.store_product + store.id.toString()).then(
            (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            products.clear();
            for (int i = 0; i < val.data["data"].length; i++) {
              products.add(ProductModel.fromJson(val.data["data"][i]));
            }
            productsState = ProductsState.hasData;
            notifyListeners();
          } else {
            throw ("حدث خطأ ما");
          }
        },
      );
    } catch (e) {
      productsState = ProductsState.error;
      notifyListeners();
    }
  }
}
