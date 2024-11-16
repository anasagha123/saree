import 'package:flutter/material.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';

class LabeledBox extends StatelessWidget {
  final IconData icon;
  final String label;

  const LabeledBox({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceSize.myWidth(340),
      height: DeviceSize.myHeight(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyTheme.primary),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: MyTheme.primary,
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
