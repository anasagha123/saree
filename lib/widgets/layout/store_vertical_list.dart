import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/theme.dart';
import 'package:saree/providers/stores_provider.dart';
import 'package:saree/widgets/components/shimmer_loading_widget.dart';

import '../../config/device_size.dart';
import '../components/store_card.dart';

class StoreVerticalList extends StatefulWidget {
  final bool isDiscount;
  final bool addButton;

  const StoreVerticalList({
    this.isDiscount = true,
    this.addButton = true,
    super.key,
  });

  @override
  State<StoreVerticalList> createState() => _StoreVerticalListState();
}

class _StoreVerticalListState extends State<StoreVerticalList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoresProvider>(
      builder: (_, provider, w) {
        if (provider.storesState == StoresState.loading) {
          return SliverList.builder(
            itemCount: 3,
            itemBuilder: (_, i) => ShimmerLoadingWidget(
              width: DeviceSize.myWidth(345),
              height: DeviceSize.myHeight(210),
              margin: const EdgeInsets.all(4),
              raduis: 8,
            ),
          );
        }
        if (provider.storesState == StoresState.hasData &&
            provider.stores.isNotEmpty) {
          int length;
          if (widget.addButton) {
            length = provider.stores.length + 1;
          } else {
            length = provider.stores.length;
          }
          return SliverList.builder(
            itemBuilder: (_, i) {
              if (i == length - 1) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(10)),
                  padding:
                      EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(10)),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "عرض المزيد",
                        style: TextStyle(color: MyTheme.primary),
                      ),
                      Icon(
                        Icons.arrow_back_rounded,
                        color: MyTheme.primary,
                      )
                    ],
                  ),
                );
              } else {
                return StoreCard(
                  provider.stores[i],
                  large: true,
                  isDiscount: widget.isDiscount,
                );
              }
            },
            itemCount: length,
          );
        }
        if (provider.storesState == StoresState.hasData &&
            provider.stores.isEmpty) {
          return const SliverToBoxAdapter(child: Text("no data"));
        }
        return const SliverToBoxAdapter(child: Text("error"));
      },
    );
  }
}
