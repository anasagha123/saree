import 'package:flutter/material.dart';
import 'package:saree/models/product_model.dart';
import 'package:saree/network/remote/dio_helper.dart';

enum ProductState { initial, loading, hasData, error }

class ProductProvider with ChangeNotifier {
  ProductModel product;
  int itemCount = 0;
  ProductState productState = ProductState.initial;

  ProductProvider(this.product);

  Future<void> getProductData() async {
    productState = ProductState.loading;
    notifyListeners();
    try {
      await DioHelper.getData(
              path: EndPoints.view_product_data + product.id.toString())
          .then(
        (val) {
          if(val.statusCode == 200 && val.data["status"] == "success"){
            product = ProductModel.fromJson(val.data["data"][0]);
            productState = ProductState.hasData;
            notifyListeners();
          } else {
            throw("error");
          }
        },
      );
    } catch (e) {
      productState = ProductState.error;
    }
  }

  addToItemCount(){
    itemCount++;
    notifyListeners();
  }

  decrementToItemCount(){
    if(itemCount != 0){
      itemCount--;
      notifyListeners();
    }
  }
}
