import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';

class AddToCartWidget extends StatelessWidget {
  final ProductModel product;

  const AddToCartWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, provider, widget) {
        if (provider.cart.containsKey(product.id)) {
          return Container(
            width: DeviceSize.myWidth(100),
            height: DeviceSize.myHeight(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyTheme.primary),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.addProduct(context, product);
                    provider.calcTotal();
                  },
                  child: Container(
                    height: DeviceSize.myHeight(20),
                    width: DeviceSize.myWidth(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyTheme.primary)),
                    alignment: Alignment.center,
                    child: const Text("+"),
                  ),
                ),
                Text(
                  provider.cart[product.id]!.quantity.toString(),
                  style: const TextStyle(
                    color: MyTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    provider.decrementProduct(product);
                    provider.calcTotal();
                  },
                  child: Container(
                    height: DeviceSize.myHeight(20),
                    width: DeviceSize.myWidth(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyTheme.primary)),
                    alignment: Alignment.center,
                    child: const Text("-"),
                  ),
                ),
              ],
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            if (product.status) {
              provider.addProduct(context, product);
            }
          },
          child: Container(
            width: DeviceSize.myWidth(100),
            height: DeviceSize.myHeight(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: product.status ? MyTheme.primary : Colors.grey,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "اضافة للسلة",
              style: TextStyle(
                color: product.status ? MyTheme.primary : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
