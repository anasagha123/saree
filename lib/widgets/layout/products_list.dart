import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/config/responsive_font.dart';
import 'package:saree/providers/store_provider.dart';
import 'package:saree/widgets/components/shimmer_loading_widget.dart';

import '../../config/theme.dart';
import '../components/product_card.dart';

class ProductsList extends StatefulWidget {
  final bool addMoreButton;

  const ProductsList({this.addMoreButton = false, super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StoreProvider>(context, listen: false).getStoreProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(builder: (_, provider, w) {
      if (provider.productsState == ProductsState.loading) {
        return SliverList.builder(
          itemBuilder: (_, i) => ShimmerLoadingWidget(
            width: DeviceSize.myWidth(340),
            height: DeviceSize.myHeight(125),
            raduis: 4,
            margin: EdgeInsets.symmetric(
              horizontal: DeviceSize.myWidth(10),
              vertical: DeviceSize.myHeight(4),
            ),
          ),
          itemCount: 3,
        );
      }
      if (!provider.store.status) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: DeviceSize.myWidth(50),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(
              "نعتذر المطعم خارج وقت العمل سيعود ليفتح غدا صباحا",
              style: TextStyle(fontSize: getResponsiveFontSize(context, 18)),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      if (provider.productsState == ProductsState.hasData ||
          provider.products.isNotEmpty) {
        int length;
        if (widget.addMoreButton) {
          length = provider.products.length + 1;
        } else {
          length = provider.products.length;
        }
        return SliverList.builder(
          itemBuilder: (_, i) => i == provider.products.length &&
                  widget.addMoreButton
              ? GestureDetector(
                  // TODO :: add logic
                  onTap: null,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyTheme.primary, width: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "اضافة المزيد +",
                      style: TextStyle(color: MyTheme.primary),
                    ),
                  ),
                )
              : ProductCard(provider.products[i]),
          itemCount: length,
        );
      }
      return const SliverToBoxAdapter(child: Text("error"));
    });
  }
}
