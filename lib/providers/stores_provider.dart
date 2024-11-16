import 'package:flutter/material.dart';
import 'package:saree/models/store_model.dart';
import 'package:saree/network/remote/dio_helper.dart';

enum StoresState { initial, loading, hasData, error }

class StoresProvider with ChangeNotifier {
  List<StoreModel> stores = [];
  StoresState storesState = StoresState.initial;

  Future<void> getStores() async {
    storesState = StoresState.loading;
    notifyListeners();
    try {
      await DioHelper.getData(path: EndPoints.stores).then(
        (val) {
          if(val.statusCode == 200 && val.data["status"] == "success"){
            stores.clear();
            for(int i = 0; i < val.data["data"].length; i++){
              stores.add(StoreModel.fromJson(val.data["data"][i]));
            }
            storesState = StoresState.hasData;
            notifyListeners();
          } else {
            throw("Stores Provider ERROR");
          }
        },
      );
    } catch (e) {
      storesState = StoresState.error;
      notifyListeners();
    }
  }
}
