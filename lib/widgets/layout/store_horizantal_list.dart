import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/theme.dart';
import 'package:saree/providers/stores_provider.dart';
import 'package:saree/widgets/components/shimmer_loading_widget.dart';

import '../../config/device_size.dart';
import '../components/store_card.dart';

class StroeHorizontalList extends StatefulWidget {
  final bool isDiscount;
  final bool addButton;

  const StroeHorizontalList({
    this.isDiscount = true,
    this.addButton = true,
    super.key,
  });

  @override
  State<StroeHorizontalList> createState() => _StroeHorizontalListState();
}

class _StroeHorizontalListState extends State<StroeHorizontalList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StoresProvider>(context, listen: false).getStores();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<StoresProvider>(
        builder: (_, provider, child) {
          if (provider.storesState == StoresState.loading) {
            return SizedBox(
              height: DeviceSize.myHeight(210),
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 7),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) =>
                    ShimmerLoadingWidget(

                      margin: const EdgeInsets.all(4),
                      width: DeviceSize.myWidth(250),
                      height: DeviceSize.myHeight(210),
                    raduis: 8,),
                itemCount: 3,
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
            return SizedBox(
              height: DeviceSize.myHeight(210),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                physics: const BouncingScrollPhysics(),
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => i == length - 1
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: DeviceSize.myWidth(10)),
                        padding: EdgeInsets.symmetric(
                            horizontal: DeviceSize.myWidth(10)),
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
                      )
                    : StoreCard(
                        provider.stores[i],
                        large: false,
                        isDiscount: widget.isDiscount,
                      ),
                itemCount: length,
              ),
            );
          }
          if (provider.storesState == StoresState.hasData &&
              provider.stores.isEmpty) {
            return const Text("no data");
          }
          return const Text("error");
        },
      ),
    );
  }
}
