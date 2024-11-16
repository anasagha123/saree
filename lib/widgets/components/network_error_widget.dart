import 'package:flutter/material.dart';
import 'package:saree/config/my_assets.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(MyAssets.imagePath + MyImages.network_error_illistration),
        const Text("حصل خطأ في الشبكة الرجاء اعادة المحاولة"),
      ],
    );
  }
}
