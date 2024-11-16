// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/models/store_model.dart';
import 'package:saree/providers/auth_provider.dart';
import 'package:saree/providers/location_provider.dart';
import 'package:saree/screens/main_screen/main_screen.dart';
import 'package:saree/widgets/components/show_snack_bar.dart';

import '../models/product_model.dart';
import '../network/remote/dio_helper.dart';

enum OrderState { initial, loading, orderSent, error }

enum CouponState { initial, loading, success, error }

enum CartStoreDataState { initial, loading, hasData, error }

class CartProvider with ChangeNotifier {
  Map<int, ProductModel> cart = {};
  int? store_id;
  StoreModel? store;
  OrderState orderState = OrderState.initial;
  CouponState couponState = CouponState.initial;
  CartStoreDataState cartStoreDataState = CartStoreDataState.initial;

  double couponDiscount = 0;

  double total_amount = 0;
  double products_total = 0;
  double after_discount = 0;
  double discount_amount = 0;

  void calcTotal() async {
    if (store == null) {
      await getStoreData();
    }
    products_total = 0;
    for (var e in cart.values) {
      products_total += e.quantity * e.sale_price;
    }
    discount_amount = products_total * (couponDiscount / 100);
    after_discount = products_total - discount_amount;
    total_amount = after_discount + (store?.delivery_cost ?? 0);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    store_id = null;
  }

  addProduct(BuildContext context, ProductModel product) {
    if (cart.isEmpty) {
      store_id = product.store_id;
    }
    if (product.store_id == store_id!) {
      if (cart.containsKey(product.id)) {
        cart.update(
          product.id,
          (e) => ProductModel(
            id: e.id,
            name: e.name,
            price: e.price,
            sale_price: e.sale_price,
            description: e.description,
            image: e.image,
            status: e.status,
            category_id: e.category_id,
            store_id: e.store_id,
            quantity: e.quantity + 1,
          ),
        );
      } else {
        cart.putIfAbsent(
          product.id,
          () => ProductModel(
            id: product.id,
            name: product.name,
            price: product.price,
            sale_price: product.sale_price,
            description: product.description,
            image: product.image,
            status: product.status,
            category_id: product.category_id,
            store_id: product.store_id,
            quantity: product.quantity + 1,
          ),
        );
      }
    }
    notifyListeners();
  }

  decrementProduct(ProductModel product) {
    if (cart.containsKey(product.id) && cart[product.id]!.quantity > 1) {
      cart.update(
        product.id,
        (e) => ProductModel(
          id: e.id,
          name: e.name,
          price: e.price,
          sale_price: e.sale_price,
          description: e.description,
          image: e.image,
          status: e.status,
          category_id: e.category_id,
          store_id: e.store_id,
          quantity: e.quantity - 1,
        ),
      );
    } else if (cart[product.id]!.quantity == 1) {
      removeProduct(product);
    }
    notifyListeners();
  }

  removeProduct(ProductModel product) {
    if (cart.containsKey(product.id)) {
      cart.remove(product.id);
    }
    if (cart.isEmpty) {
      clearCart();
    }
    notifyListeners();
  }

  String productTotal(ProductModel product) {
    if (cart.containsKey(product.id)) {
      int total = cart[product.id]!.quantity * cart[product.id]!.sale_price;
      return total.toString();
    }
    return "0";
  }

  Future<void> submitCoupon(BuildContext context, String coupon) async {
    couponState = CouponState.loading;
    notifyListeners();

    try {
      DioHelper.postData(
        path: EndPoints.coupon,
        data: {"code": coupon},
      ).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            couponDiscount =
                double.parse(val.data["data"]["discount_amount"].toString());
            couponState = CouponState.success;
            calcTotal();
            Navigator.pop(context);
            showSnackBar(
                context: context,
                message: val.data["message"],
                state: SnackBarState.success);
            notifyListeners();
          } else {
            throw (val.data["message"] ?? "حدث خطأ ما الرجاء اعادة المحاولة");
          }
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(
          context: context,
          message: e.toString(),
          state: SnackBarState.success);
      couponState = CouponState.error;
      notifyListeners();
    }
  }

  Future<void> getStoreData() async {
    cartStoreDataState = CartStoreDataState.loading;
    notifyListeners();
    try {
      await DioHelper.getData(
              path: EndPoints.view_store_data + store_id!.toString())
          .then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            store = StoreModel.fromJson(val.data["data"][0]);
            cartStoreDataState = CartStoreDataState.hasData;
            calcTotal();
          } else {
            throw ("error");
          }
        },
      );
    } catch (e) {
      cartStoreDataState = CartStoreDataState.error;
    }
  }

  Future<void> addOrder(BuildContext context, String name, String phone,
      String address, String? notes) async {
    orderState = OrderState.loading;
    notifyListeners();

    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false).selectedLocation;
    var user = Provider.of<AuthProvider>(context, listen: false).user;

    try {
      if (store != null) {
        await getStoreData().then(
          (val) async {
            Map<String, dynamic> payload = {
              "name": name,
              "phone": phone,
              "address": address,
              "products_amount": products_total,
              "after_discount": after_discount,
              "delivery_cost": store!.delivery_cost,
              "total_amount": total_amount,
              "user": user!.id,
              "store": store_id!,
              "notes": notes,
              "products":
                  List<Map<String, dynamic>>.generate(cart.length, (index) {
                ProductModel product = cart.values.elementAt(index);
                double price = product.price.toDouble();
                return {
                  "\"product_id\"": product.id,
                  "\"product_name\"": "\"${product.name}\"",
                  "\"product_price\"": price,
                  "\"product_quntity\"": product.quantity,
                  "\"product_total\"": price * product.quantity,
                };
              }).toString(),
              "location": {
                "\"lat\"": locationProvider!.latitude,
                "\"lng\"": locationProvider.longitude,
              }.toString(),
            };

            await DioHelper.postData(
              path: EndPoints.add_order,
              data: payload,
              headers: {"authorization": DioHelper.User_Token},
            ).then(
              (val) {
                if (val.statusCode == 200 && val.data["status"] == "success") {
                  orderState = OrderState.orderSent;
                  clearCart();
                  notifyListeners();
                  Navigator.popUntil(
                    context,
                    (route) => route.settings.name == MainScreen.routeName,
                  );
                  showSnackBar(
                      context: context,
                      message: val.data["message"],
                      state: SnackBarState.success);
                } else {
                  throw ("حدث خطأ ما الرجاء اعادة المحاولة");
                }
              },
            );
          },
        );
      } else {
        Map<String, dynamic> payload = {
          "name": name,
          "phone": phone,
          "address": address,
          "products_amount": products_total,
          "after_discount": after_discount,
          "delivery_cost": store!.delivery_cost,
          "total_amount": total_amount,
          "user": user!.id,
          "store": store_id!,
          "notes": notes,
          "products": List<Map<String, dynamic>>.generate(cart.length, (index) {
            ProductModel product = cart.values.elementAt(index);
            double price = product.price.toDouble();
            return {
              "\"product_id\"": product.id,
              "\"product_name\"": "\"${product.name}\"",
              "\"product_price\"": price,
              "\"product_quntity\"": product.quantity,
              "\"product_total\"": price * product.quantity,
            };
          }).toString(),
          "location": {
            "\"lat\"": locationProvider!.latitude,
            "\"lng\"": locationProvider.longitude,
          }.toString(),
        };

        await DioHelper.postData(
          path: EndPoints.add_order,
          data: payload,
          headers: {"authorization": DioHelper.User_Token},
        ).then(
          (val) {
            if (val.statusCode == 200 && val.data["status"] == "success") {
              orderState = OrderState.orderSent;
              cart.clear();
              store_id = null;
              notifyListeners();
              Navigator.pushNamedAndRemoveUntil(
                context,
                MainScreen.routeName,
                (route) => false,
                arguments: const MainScreenArguments(index: 1),
              );
              showSnackBar(
                  context: context,
                  message: val.data["message"],
                  state: SnackBarState.success);
            } else {
              throw ("حدث خطأ ما الرجاء اعادة المحاولة");
            }
          },
        );
      }
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(
          context: context, message: e.toString(), state: SnackBarState.error);
      orderState = OrderState.error;
      notifyListeners();
    }
  }
}
