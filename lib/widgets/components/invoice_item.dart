import 'package:flutter/material.dart';
import 'package:saree/models/product_model.dart';
import 'package:saree/screens/product_details_screen.dart';

import '../../config/device_size.dart';

class InvoiceItem extends StatelessWidget {
  final ProductModel product;

  const InvoiceItem(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailsScreen.routeName,
        arguments: product,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.all(5),
        width: DeviceSize.myWidth(310),
        height: DeviceSize.myHeight(35),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 2,
              color: Color(0xE5000000),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  product.name,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(product.quantity.toString()),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(product.sale_price.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
