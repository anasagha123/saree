import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/config/responsive_font.dart';
import 'package:saree/providers/cart_provider.dart';
import 'package:saree/screens/chose_service_screen.dart';
import 'package:saree/widgets/components/my_button.dart';

class DisableLeavingMainScreenDialog extends StatelessWidget {
  const DisableLeavingMainScreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            Text(
              "خروجك سيعني افراغ السلة هل انت متأكد من ذلك؟",
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, 18),
                height: 3,
              ),
            ),
            MyButton(
              label: "الغاء",
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(height: DeviceSize.myHeight(8),),
            MyButton(
              label: "الخروج",
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).clearCart();
                Navigator.pushReplacementNamed(
                  context,
                  ChoseServiceScreen.routeName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
