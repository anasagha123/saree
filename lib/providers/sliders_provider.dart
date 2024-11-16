import 'package:flutter/material.dart';

import '../models/banner_model.dart';
import '../network/remote/dio_helper.dart';

enum SlidersState { initial, loading, done, error }

class SlidersProvider with ChangeNotifier {
  List<BannerModel> sliders = [];
  SlidersState slidersState = SlidersState.initial;

  Future<void> getSliders() async {
    slidersState = SlidersState.loading;
    notifyListeners();
    await DioHelper.getData(path: EndPoints.view_sliders).then(
      (val) {
        if (val.statusCode == 200 && val.data["status"] == "success") {
          sliders.clear();
          for (int i = 0; i < val.data["data"].length; i++) {
            sliders.add(BannerModel.fromMap(val.data["data"][i]));
          }
          slidersState = SlidersState.done;
          notifyListeners();
        } else {
          throw (val.data["message"] ?? "حدث خطأ ما");
        }
      },
    ).onError(
      (e, stack) {
        slidersState = SlidersState.error;
        notifyListeners();
      },
    );
  }
}
