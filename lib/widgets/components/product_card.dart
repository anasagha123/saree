import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/device_size.dart';
import '../../config/responsive_font.dart';
import '../../config/theme.dart';
import '../../models/product_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../providers/cart_provider.dart';
import '../../screens/product_details_screen.dart';
import 'add_to_cart_widget.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetailsScreen.routeName,
          arguments: product),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: DeviceSize.myWidth(10),
          vertical: DeviceSize.myHeight(4),
        ),
        padding: EdgeInsets.all(DeviceSize.myHeight(2.5)),
        width: DeviceSize.myWidth(340),
        height: DeviceSize.myHeight(125),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 3,
              color: Color(0xD9000000),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PriceChart(
                  product.price,
                  isCrossed: true,
                ),
                Row(
                  children: [
                    Consumer<CartProvider>(
                      builder: (_, provider, child) => PriceChart(
                        provider.cart.containsKey(product.id)
                            ? provider.cart[product.id]!.quantity *
                                product.sale_price
                            : product.sale_price,
                      ),
                    ),
                    const SizedBox(width: 16),
                    AddToCartWidget(product),
                  ],
                ),
              ],
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Image.network(
                    "${DioHelper.baseUrl}/storage/images/${product.image}",
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: const EdgeInsets.all(2),
                    width: DeviceSize.myWidth(40),
                    height: DeviceSize.myHeight(21),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: MyTheme.primary,
                    ),
                    child: const Text(
                      "discount",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceChart extends StatelessWidget {
  final int price;
  final bool isCrossed;

  const PriceChart(this.price, {this.isCrossed = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceSize.myWidth(90),
      height: DeviceSize.myHeight(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            color: Color(0xE5000000),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        price.toString(),
        style: isCrossed
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
    );
  }
}
