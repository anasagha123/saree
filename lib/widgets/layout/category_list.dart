import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/providers/store_type_provider.dart';
import 'package:saree/widgets/components/shimmer_loading_widget.dart';

import '../components/category_item.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StoreTypeProvider>(context, listen: false).getStoreTypes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: DeviceSize.myHeight(90),
        child: Consumer<StoreTypeProvider>(
          builder: (_, provider, widget) {
            if (provider.storeTypeState == StoreTypeState.loading) {
              return ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (_, i) => ShimmerLoadingWidget(
                  width: DeviceSize.myWidth(80),
                  height: DeviceSize.myHeight(86),
                  raduis: 4,
                  margin: EdgeInsets.all(DeviceSize.myHeight(5)),
                ),
              );
            }
            if (provider.storeTypeState == StoreTypeState.hasData &&
                provider.storeTypes.isNotEmpty) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.storeTypes.length,
                  itemBuilder: (_, i) => CategoryItem(provider.storeTypes[i]),
                ),
              );
            }
            if (provider.storeTypeState == StoreTypeState.hasData &&
                provider.storeTypes.isEmpty) {
              return const Text("no types");
            }
            return const Text("error");
          },
        ),
      ),
    );
  }
}
