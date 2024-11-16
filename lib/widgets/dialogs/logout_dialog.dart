import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/providers/auth_provider.dart';
import 'package:saree/widgets/components/my_button.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("هل لنت متأكد من انك تريد تسجيل الخروج من التطبيق؟"),
            SizedBox(height: DeviceSize.myHeight(40)),
            Consumer<AuthProvider>(
              builder: (context, provider, widget) => MyButton(
                label: "نعم",
                onPressed: () => provider.logout(context),
              ),
            ),
            SizedBox(height: DeviceSize.myHeight(16)),
            MyButton(
              label: "لا",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
