import 'package:flutter/material.dart';
import 'package:saree/config/responsive_font.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';

class SearchField extends StatelessWidget {
  final bool mini;
  final bool transparent;
  final String route;

  const SearchField({
    this.mini = false,
    this.transparent = false,
    required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: DeviceSize.myWidth(mini ? 136 : 290),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(transparent ? 0x00FAFAFA : 0xFFFAFAFA),
          border: transparent ? Border.all() : null,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 2,
              color: Color(transparent ? 0x00000000 : 0xE5000000),
            ),
          ],
        ),
        child: Row(
          children: [
            const Spacer(flex: 3),
            Text(
              "ابحث عن طلبك",
              style: TextStyle(
                  color: const Color(0xFF7F7F7F),
                  fontSize: getResponsiveFontSize(context, 16)),
            ),
            const Spacer(flex: 2),
            const Icon(
              Icons.search_outlined,
              color: MyTheme.primary,
              size: 18,
            ),
            SizedBox(width: DeviceSize.myWidth(10))
          ],
        ),
      ),
    );
  }
}
