import 'package:flutter/material.dart';

import '../../config/device_size.dart';

class InfoDialog extends StatelessWidget {
  final String info;

  const InfoDialog(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        height: DeviceSize.myHeight(160),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                // TODO :: specify size correctly
                icon: const Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
            ),
            const Spacer(),
            Text(
              info,
              maxLines: 6,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}