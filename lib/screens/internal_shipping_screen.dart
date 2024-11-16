import 'package:flutter/material.dart';
import 'package:saree/config/responsive_font.dart';

import '../config/device_size.dart';
import '../config/my_assets.dart';
import '../config/theme.dart';

class InternalShippingScreen extends StatelessWidget {
  static const routeName = "/internal-shipping";
  final text = """
  سريع يقدم خدمة الشحن الداخلي
 من الباب الى الباب
ماعليك سوا ارسال صورة البكج ومعلوماته على واتساب
 وسوف نتواصل معك
 """;

  const InternalShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          MyAssets.imagePath + MyImages.appLogo,
          height: AppBar().preferredSize.height,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: getResponsiveFontSize(context, 22)),
          ),
          Image.asset(MyAssets.imagePath + MyImages.internal_shipping),
          GestureDetector(
            // TODO :: add logic
            onTap: null,
            child: Container(
              alignment: Alignment.center,
              height: DeviceSize.myHeight(80),
              width: DeviceSize.myWidth(340),
              decoration: BoxDecoration(
                color: MyTheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "ارسال بكج",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getResponsiveFontSize(context, 22),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
