// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:saree/models/banner_model.dart';
import 'package:saree/network/remote/dio_helper.dart';

enum BannersState {initial, loading, done, error}

class BannersProvider with ChangeNotifier {
  List<BannerModel> markiting_banners = [];
  BannersState bannersState = BannersState.initial;

  Future<void> getMarkitingBanners() async {
    bannersState = BannersState.loading;
    notifyListeners();
    try{
      await DioHelper.getData(path: EndPoints.view_markiting_banners).then(
            (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            markiting_banners.clear();
            for (int i = 0; i < val.data["data"].length; i++) {
              markiting_banners.add(BannerModel.fromMap(val.data["data"][i]));
              bannersState = BannersState.done;
              notifyListeners();
            }
          } else {
            throw(val.data["message"] ??"حدث خطأ ما");
          }
        },
      );
    } catch(e){
      bannersState = BannersState.error;
      notifyListeners();
    }
  }
}
