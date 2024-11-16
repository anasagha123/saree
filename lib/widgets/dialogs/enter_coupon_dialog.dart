import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/providers/cart_provider.dart';
import 'package:saree/widgets/components/my_button.dart';
import 'package:saree/widgets/components/my_text_form_field.dart';

class EnterCouponDialog extends StatefulWidget {
  const EnterCouponDialog({super.key});

  @override
  State<EnterCouponDialog> createState() => _EnterCouponDialogState();
}

class _EnterCouponDialogState extends State<EnterCouponDialog> {
  final _coupon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Consumer<CartProvider>(
        builder: (_, provider, widget) {
          if (provider.couponState == CouponState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close)),
                const Text("الرجاء ادخال كوبون الحسم"),
                SizedBox(
                  height: DeviceSize.myHeight(8),
                ),
                MyTextFormField(
                    controller: _coupon, icon: Icons.discount_outlined),
                SizedBox(
                  height: DeviceSize.myHeight(24),
                ),
                Center(
                  child: MyButton(
                    label: "ادخال",
                    onPressed: () =>
                        provider.submitCoupon(context, _coupon.text),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
