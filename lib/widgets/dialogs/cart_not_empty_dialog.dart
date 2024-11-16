import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/providers/cart_provider.dart';
import 'package:saree/widgets/components/my_button.dart';

class CartNotEmptyDialog extends StatelessWidget {
  final String store;

  const CartNotEmptyDialog(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Text(
              "لا يمكنك الشراء من أكثر من مطعم من اجل الشراء من عليك اما اتما عملية الشراء او افراغ السلة$store"),
          MyButton(label: "اتمام عملية الشراء", onPressed: () {}),
          MyButton(
              label: "افراغ السلة",
              onPressed: () => Provider.of<CartProvider>(context, listen: false)
                  .clearCart()),
          MyButton(label: "الرجوع", onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
