// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/order_model.dart';
import '../network/remote/dio_helper.dart';
import 'auth_provider.dart';

enum OrdersDataState { initial, loading, hasData, error }

class OrdersProvider with ChangeNotifier {
  List<OrderModel> orders = [];
  int? user_id;
  OrdersDataState ordersDataState = OrdersDataState.initial;

  Future<void> getOrders(BuildContext context) async {
    ordersDataState = OrdersDataState.loading;
    notifyListeners();

    try {
      user_id = Provider.of<AuthProvider>(context, listen: false).user!.id;
      await DioHelper.getData(
        path: EndPoints.user_orders + user_id.toString(),
        headers: {"authorization": DioHelper.User_Token},
      ).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            orders.clear();
            for (int i = 0; i < val.data["data"].length; i++) {
              orders.add(OrderModel.fromJson(val.data["data"][i]));
            }
            ordersDataState = OrdersDataState.hasData;
            notifyListeners();
          } else {
            throw ("Error");
          }
        },
      );
    } catch (e) {
      ordersDataState = OrdersDataState.error;
      notifyListeners();
    }
  }
}
