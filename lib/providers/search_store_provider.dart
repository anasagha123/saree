import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:saree/models/store_model.dart';
import 'package:saree/network/remote/dio_helper.dart';

enum SearchState { initial, loading, hasData, error }

class SearchStoreProvider with ChangeNotifier {
  List<StoreModel> stores = [];
  SearchState searchState = SearchState.initial;
  CancelToken? _cancelToken;

  Future<void> getStores(String? name) async {
    searchState = SearchState.loading;
    notifyListeners();
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    Map<String, dynamic> query = {"name": name};

    try {
      await DioHelper.postData(
        path: EndPoints.search_by_name,
        queryParameters: query,
        cancelToken: _cancelToken,
      ).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            stores.clear();
            for(int i = 0; i < val.data["data"].length; i++){
              stores.add(StoreModel.fromJson(val.data["data"][i]));
            }
            searchState = SearchState.hasData;
            notifyListeners();
          } else {
            throw("error");
          }
        },
      );
    } catch (e) {
      searchState = SearchState.error;
      notifyListeners();
    }
  }
}
