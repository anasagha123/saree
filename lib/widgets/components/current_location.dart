import 'package:flutter/material.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';
import '../bottom_sheets/location_bottom_sheet.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        enableDrag: false,
        context: context,
        builder: (_) => const LocationsBottomSheet(),
      ),
      child: Container(
        width: DeviceSize.myWidth(152),
        height: DeviceSize.myHeight(33),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0x80000000)),
        ),
        child: const Row(
          children: [
            Spacer(),
            Text(
              "الموقع الحالي",
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Icon(
              Icons.location_on_outlined,
              color: MyTheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
