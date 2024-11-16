import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';
import '../../models/store_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../providers/cart_provider.dart';
import '../../screens/store_details_screen.dart';
import '../dialogs/cart_not_empty_dialog.dart';

class StoreCard extends StatelessWidget {
  final StoreModel store;
  final bool large;
  final bool isDiscount;

  const StoreCard(this.store,
      {this.large = false, this.isDiscount = true, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var provider = Provider.of<CartProvider>(context, listen: false);
        if (provider.cart.isEmpty || provider.store_id == store.id) {
          Navigator.pushNamed(
            context,
            StoreDetailsScreen.routeName,
            arguments: store,
          );
        } else {
          showDialog(
            context: context,
            builder: (_) => CartNotEmptyDialog(store.name),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        width: DeviceSize.myWidth(large ? 345 : 250),
        height: DeviceSize.myHeight(210),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 1),
              color: Color(0xE5000000),
            ),
          ],
          color: const Color(0xFFFDFEFF),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: DeviceSize.myWidth(large ? 345 : 250),
                  height: DeviceSize.myHeight(130),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "${DioHelper.baseUrl}/storage/images/${store.image}"))),
                ),
                Text(store.name),
                Row(
                  children: [
                    Icon(
                      Icons.restaurant_outlined,
                      color: MyTheme.primary,
                      size: DeviceSize.myHeight(16),
                    ),
                    Text(store.store_type),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  height: DeviceSize.myHeight(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: MyTheme.primary,
                        size: DeviceSize.myHeight(16),
                      ),
                      Text(store.preparation_time),
                      const VerticalDivider(),
                      Icon(
                        Icons.sports_motorsports_outlined,
                        color: MyTheme.primary,
                        size: DeviceSize.myHeight(16),
                      ),
                      Text(store.delivery_cost.toString()),
                      const VerticalDivider(),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: DeviceSize.myHeight(16),
                      ),
                      const Text("rating"),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: const Alignment(-0.9, 0.2),
              child: Container(
                height: DeviceSize.myHeight(75),
                width: DeviceSize.myWidth(75),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withAlpha(150),
                  image: DecorationImage(
                      image: NetworkImage(
                          "${DioHelper.baseUrl}/storage/images/${store.image}"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.95, -0.9),
              child: Container(
                width: DeviceSize.myWidth(46),
                height: DeviceSize.myHeight(25),
                decoration: BoxDecoration(
                    color: MyTheme.primary,
                    borderRadius: BorderRadius.circular(4)),
                alignment: Alignment.center,
                child: Text(
                  isDiscount ? "discount" : "🔥",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
