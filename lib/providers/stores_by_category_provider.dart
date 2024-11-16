import 'package:flutter/material.dart';
import 'package:saree/models/store_type_model.dart';

import '../models/store_model.dart';
import '../network/remote/dio_helper.dart';

enum StoresByCategoryState { initial, loading, hasData, error }
class StoresByCategoryProvider with ChangeNotifier{
  List<StoreModel> stores = [];
  final StoreTypeModel category;
  StoresByCategoryState storesBuCategoryState = StoresByCategoryState.initial;

  StoresByCategoryProvider(this.category);

  Future<void> getStores() async {
    storesBuCategoryState = StoresByCategoryState.loading;
    notifyListeners();
    try {
      await DioHelper.getData(path: "${EndPoints.store_by_type}/${category.id}").then(
            (val) {
          if(val.statusCode == 200 && val.data["status"] == "success"){
            stores.clear();
            for(int i = 0; i < val.data["data"].length; i++){
              stores.add(StoreModel.fromJson(val.data["data"][i]));
            }
            storesBuCategoryState = StoresByCategoryState.hasData;
            notifyListeners();
          } else {
            throw("Stores Provider ERROR");
          }
        },
      );
    } catch (e) {
      storesBuCategoryState = StoresByCategoryState.error;
      notifyListeners();
    }
  }
}
