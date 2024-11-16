import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/providers/banners_provider.dart';
import 'package:saree/providers/store_type_provider.dart';
import 'package:saree/providers/stores_provider.dart';
import 'package:saree/screens/search_stores_screen.dart';

import '../../config/theme.dart';
import '../../widgets/layout/category_list.dart';
import '../../widgets/components/my_banner.dart';
import '../../widgets/components/my_divider.dart';
import '../../widgets/layout/store_horizantal_list.dart';
import '../../widgets/components/search_field.dart';
import '../../widgets/layout/store_vertical_list.dart';

class StoresLayout extends StatelessWidget {
  const StoresLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          Provider.of<BannersProvider>(context, listen: false)
              .getMarkitingBanners();
          Provider.of<StoreTypeProvider>(context, listen: false)
              .getStoreTypes();
          Provider.of<StoresProvider>(context, listen: false).getStores();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Center(
                child: SearchField(
                  route: SearchStoresScreen.routeName,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: MyBanner()),
            const CategoryList(),
            const SliverToBoxAdapter(child: MyDivider()),
            SliverToBoxAdapter(
              child: GestureDetector(
                // TODO :: ADD LOGIC
                onTap: null,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: MyTheme.primary,
                    ),
                    Text("خصومات تصل 50%"),
                  ],
                ),
              ),
            ),
            const StroeHorizontalList(),
            SliverToBoxAdapter(
              child: GestureDetector(
                // TODO :: ADD LOGIC
                onTap: null,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: MyTheme.primary,
                    ),
                    Text("الأكثر طلبا 🔥"),
                  ],
                ),
              ),
            ),
            const StroeHorizontalList(
              isDiscount: false,
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                // TODO :: ADD LOGIC
                onTap: null,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      color: MyTheme.primary,
                    ),
                    Text("الترتيب حسب الموقع"),
                  ],
                ),
              ),
            ),
            const StoreVerticalList(
              addButton: true,
            ),
          ],
        ),
      ),
    );
  }
}
