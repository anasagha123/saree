import 'package:flutter/material.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/widgets/components/my_button.dart';


class EnableLocationServiceDialog extends StatelessWidget {
  const EnableLocationServiceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(20),
        height: DeviceSize.myHeight(300),
        child: Column(
          children: [
            const Text(
              "الرجاء تفعيل الموقع",
              textAlign: TextAlign.center,
            ),
            MyButton(
              label: "موافق",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
