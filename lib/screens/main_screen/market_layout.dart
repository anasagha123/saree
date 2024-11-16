import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/providers/banners_provider.dart';
import 'package:saree/providers/market_provider.dart';
import 'package:saree/widgets/components/product_card.dart';
import 'package:saree/widgets/components/shimmer_loading_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';
import '../../widgets/components/my_banner.dart';
import '../../widgets/components/search_field.dart';
import '../../widgets/delegates/sliver_app_bar_delegate.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MarketProvider>(context, listen: false).getProducts();
      Provider.of<MarketProvider>(context, listen: false).getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        var marketProvider =
            Provider.of<MarketProvider>(context, listen: false);
        Provider.of<BannersProvider>(context, listen: false)
            .getMarkitingBanners();
        marketProvider.getCategories();
        if (marketProvider.selectedCategory == null) {
          marketProvider.getProducts();
        } else {
          marketProvider
              .getProductsByCategory(marketProvider.selectedCategory!);
        }
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: Center(
              child: SearchField(
                route: "none",
              ),
            ),
          ),
          const SliverToBoxAdapter(child: MyBanner()),
          const SliverToBoxAdapter(child: Divider()),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: DeviceSize.myHeight(70),
              maxHeight: DeviceSize.myHeight(70),
              child: Consumer<MarketProvider>(builder: (_, provider, w) {
                if (provider.marketCategoriesState ==
                    MarketCategoriesState.loading) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DeviceSize.myWidth(5)),
                        child: const ActionChip(label: Text("aaaaaa")),
                      ),
                    ),
                    itemCount: 3,
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.categories.length,
                    itemBuilder: (_, i) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceSize.myWidth(5)),
                      child: FilterChip(
                        onSelected: (selected) {
                          if (selected) {
                            provider
                                .getProductsByCategory(provider.categories[i]);
                          } else {
                            provider.selectedCategory = null;
                            provider.getProducts();
                          }
                        },
                        selected: provider.selectedCategory?.id ==
                            provider.categories[i].id,
                        disabledColor: Colors.white,
                        labelStyle: const TextStyle(
                            color: MyTheme.primary,
                            fontWeight: FontWeight.bold),
                        label: Text(provider.categories[i].name),
                        side: const BorderSide(color: MyTheme.primary),
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
          Consumer<MarketProvider>(
            builder: (_, provider, w) {
              if (provider.marketState == MarketState.loading) {
                return SliverList.builder(
                  itemCount: 3,
                  itemBuilder: (_, i) => ShimmerLoadingWidget(
                    margin: EdgeInsets.symmetric(
                      horizontal: DeviceSize.myWidth(10),
                      vertical: DeviceSize.myHeight(4),
                    ),
                    raduis: 4,
                    width: DeviceSize.myWidth(340),
                    height: DeviceSize.myHeight(125),
                  ),
                );
              }
              return SliverList.builder(
                itemBuilder: (_, i) => ProductCard(provider.products[i]),
                itemCount: provider.products.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
