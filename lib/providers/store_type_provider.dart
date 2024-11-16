import 'package:flutter/material.dart';
import 'package:saree/models/store_type_model.dart';
import 'package:saree/network/remote/dio_helper.dart';

enum StoreTypeState { initial, loading, hasData, error }

class StoreTypeProvider with ChangeNotifier {
  List<StoreTypeModel> storeTypes = [];
  StoreTypeModel? selectedType;
  StoreTypeState storeTypeState = StoreTypeState.initial;

  Future<void> getStoreTypes() async {
    storeTypeState = StoreTypeState.loading;
    notifyListeners();
    await DioHelper.getData(path: EndPoints.store_types).then(
      (val) {
        if (val.statusCode == 200 && val.data["status"] == "success") {
          storeTypes.clear();
          for (int i = 0; i < val.data["data"].length; i++) {
            storeTypes.add(StoreTypeModel.fromMap(val.data["data"][i]));
          }
          storeTypeState = StoreTypeState.hasData;
          notifyListeners();
        } else {
          throw ("getting store type error");
        }
      },
    ).onError(
      (e, stack) {
        storeTypeState = StoreTypeState.error;
        notifyListeners();
      },
    );
  }
}
