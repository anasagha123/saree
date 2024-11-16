import 'package:flutter/material.dart';

import '../../config/device_size.dart';
import '../dialogs/info_dialog.dart';

class ShowInfoDialogButton extends StatelessWidget {
  final String info;

  const ShowInfoDialogButton(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          showDialog(context: context, builder: (ctx) => InfoDialog(info)),
      child: Icon(
        Icons.info_outline,
        size: DeviceSize.myWidth(14),
      ),
    );
  }
}