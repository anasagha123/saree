import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/models/order_model.dart';
import 'package:saree/network/remote/dio_helper.dart';
import 'package:saree/providers/auth_provider.dart';

enum OrderDataStat { initial, loading, hasData, error }

class OrderDetailsProvider with ChangeNotifier {
  OrderModel order;
  OrderDataStat orderDataStat = OrderDataStat.initial;

  OrderDetailsProvider(this.order);

  Future<void> getOrderData(BuildContext context) async {
    orderDataStat = OrderDataStat.loading;
    notifyListeners();

    try {
      await DioHelper.postData(
        path: EndPoints.view_order_data,
        headers: {"authorization": DioHelper.User_Token},
        data: {
          "user_id": Provider.of<AuthProvider>(context, listen: false).user!.id,
          "order_id": order.id,
        },
      ).then(
        (val) {
          if(val.statusCode == 200 && val.data["status"] == "success"){
            order = OrderModel.fromJson(val.data["data"][0]);
            orderDataStat = OrderDataStat.hasData;
            notifyListeners();
          } else{
            throw("error");
          }
        },
      );
    } catch (e) {
      orderDataStat = OrderDataStat.error;
      notifyListeners();
    }
  }
}
