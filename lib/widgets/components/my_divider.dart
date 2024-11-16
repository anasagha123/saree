import 'package:flutter/material.dart';

import '../../config/device_size.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: DeviceSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.black,
            Colors.white,
          ],
        ),
      ),
    );
  }
}
