// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:saree/network/local/my_shared_preferences.dart';

class DioHelper {
  static const API_Token =
      "Bearer base64:qlOoUEYoOLrdPozcFvCaqB4lkComuxp2avmcP9rhD0E=";
  static String? User_Token;
  static const baseUrl = "https://saree.social360.agency/dashboard";
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: baseUrl),
  );

  static Future setUserToken(String userToken) async {
    User_Token = "Bearer $userToken";
    await SharedPreferencesHelper.instance
        .setString(SharedPreferencesKeys.USER_TOKEN, User_Token!);
  }

  static Future<void> getUserTokenFromCache() async {
    User_Token = SharedPreferencesHelper.instance
        .getString(SharedPreferencesKeys.USER_TOKEN);
  }

  static removeUserToken() async {
    User_Token = null;
    await SharedPreferencesHelper.instance
        .remove(SharedPreferencesKeys.USER_TOKEN);
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _dio.options.headers = headers ?? {"authorization": API_Token};
    return await _dio.get(path,
        queryParameters: queryParameters, data: data, cancelToken: cancelToken);
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _dio.options.headers = headers ?? {"authorization": API_Token};
    return await _dio.post(path,
        queryParameters: queryParameters, data: data, cancelToken: cancelToken);
  }

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _dio.options.headers = headers ?? {"authorization": API_Token};
    return await _dio.delete(path,
        queryParameters: queryParameters, data: data, cancelToken: cancelToken);
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _dio.options.headers = headers ?? {"authorization": API_Token};
    return await _dio.put(path,
        queryParameters: queryParameters, data: data, cancelToken: cancelToken);
  }
}

class EndPoints {
  // auth
  static const sign_up = "/api/register";
  static const log_in = "/api/login";
  static const user_info = "/api/user-info";
  static const delete_user = "/api/user/delete";
  static const log_out = "/api/logout";
  static const update_password = "/api/user/update-password";
  static const update_user = "/api/user/update";

  // banners
  static const view_sliders = "/api/banners/slider";
  static const view_markiting_banners = "/api/banners/marketing";

  // food
  static const view_store_data = "/api/store/";
  static const search_by_name = "/api/stores/search";
  static const stores = "/api/food";
  static const store_types = "/api/store-categories";
  static const store_by_type = "/api/store-by-category/";

  // products
  static const view_product_data = "/api/product/";
  static const store_product = "/api/products/";
  static const filter_by_cat = "/api/products-by-cat/";
  static const market_products = "/api/market/products";

  // categories
  static const food = "/api/food/categories/";
  static const market = "/api/market/categories";

  // orders
  static const user_orders = "/api/orders/";
  static const add_order = "/api/add-order";
  static const view_order_data = "/api/show-order";

  // coupons
  static const coupon = "/api/coupon-isactive";

  // notes
  static const all_notes = "/api/notes";
  static const show_note = "/api/show-note/";
}
