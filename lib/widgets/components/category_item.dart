import 'package:flutter/material.dart';
import 'package:saree/config/responsive_font.dart';
import 'package:saree/models/store_type_model.dart';
import 'package:saree/screens/stores_by_category_screen.dart';

import '../../config/device_size.dart';

class CategoryItem extends StatelessWidget {
  final StoreTypeModel storeType;

  const CategoryItem(this.storeType, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, StoresByCategoryScreen.routeName,
          arguments: storeType),
      child: Container(
        width: DeviceSize.myWidth(80),
        height: DeviceSize.myHeight(86),
        margin: EdgeInsets.all(DeviceSize.myHeight(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: DeviceSize.myHeight(60),
              width: DeviceSize.myWidth(80),
              color: Colors.grey.withAlpha(150),
              child: Center(
                child: Text(
                  storeType.name,
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                  ),
                ),
              ),
            ),
            Text(
              storeType.name,
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
