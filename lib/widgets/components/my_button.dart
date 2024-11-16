import 'package:flutter/material.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  const MyButton({required this.label, required this.onPressed ,super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        fixedSize: WidgetStatePropertyAll<Size>(
          Size(
            DeviceSize.myWidth(200),
            DeviceSize.myHeight(40),
          ),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: MyTheme.primary,
            ),
      ),
    );
  }
}
