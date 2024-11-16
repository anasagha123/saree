
import 'package:flutter/material.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';

class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.all(DeviceSize.myWidth(30)),
          width: DeviceSize.myWidth(300),
          height: DeviceSize.myHeight(150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0xE5000000),
                offset: Offset(0,2),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("احصل على الخصم المقدم من سريع"),
              GestureDetector(
                child: Container(
                  width: DeviceSize.myWidth(140),
                  height: DeviceSize.myHeight(40),
                  decoration: BoxDecoration(
                    color: MyTheme.primary,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  alignment: Alignment.center,
                  child: const Text("share", style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
