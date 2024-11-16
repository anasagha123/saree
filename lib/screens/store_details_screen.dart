import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/widgets/components/shimmer_loading_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../config/device_size.dart';
import '../config/responsive_font.dart';
import '../config/theme.dart';
import '../network/remote/dio_helper.dart';
import '../providers/cart_provider.dart';
import '../providers/store_provider.dart';
import '../widgets/delegates/sliver_app_bar_delegate.dart';
import '../widgets/layout/products_list.dart';
import 'main_screen/main_screen.dart';

class StoreDetailsScreen extends StatefulWidget {
  static const routeName = "/store-details";

  const StoreDetailsScreen({super.key});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          var storeProvider =
              Provider.of<StoreProvider>(context, listen: false);
          storeProvider.getStoreData();
          storeProvider.getCategories();
          if (storeProvider.selectedCategory == null) {
            storeProvider.getStoreProducts();
          } else {
            storeProvider.filterProducts(storeProvider.selectedCategory!);
          }
        },
        child: const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            StoreData(),
            StoreCategories(),
            ProductsList(),
          ],
        ),
      ),
      floatingActionButton: Provider.of<CartProvider>(context).cart.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MainScreen.routeName,
                  (route) => false,
                  arguments: const MainScreenArguments(index: 3),
                );
              },
              backgroundColor: MyTheme.primary,
              foregroundColor: Colors.white,
              label: const Text("الذهاب الى السلة"),
              icon: const Icon(Icons.shopping_cart_outlined),
            )
          : null,
    );
  }
}

class StoreData extends StatelessWidget {
  const StoreData({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<StoreProvider>(
        builder: (_, provider, widget) {
          if (provider.storeDataState == StoreDataState.loading) {
            return ShimmerLoadingWidget(
              height: DeviceSize.myHeight(200),
              width: DeviceSize.width,
            );
          }
          if (!provider.store.status) {
            return Container(
              color: Colors.white,
              height: DeviceSize.myHeight(200),
              width: DeviceSize.width,
              child: Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: DeviceSize.width,
                              height: DeviceSize.myHeight(144),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "${DioHelper.baseUrl}/storage/images/${provider.store.image}"),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(provider.store.name),
                                Text(provider.store.address),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.restaurant_outlined,
                                  color: MyTheme.primary,
                                  size: DeviceSize.myWidth(16),
                                ),
                                const Text("data"),
                              ],
                            ),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sports_motorsports_outlined,
                                    color: MyTheme.primary,
                                    size: DeviceSize.myHeight(16),
                                  ),
                                  Text(
                                      "قيمة التوصيل ${provider.store.delivery_cost}"),
                                  const VerticalDivider(color: Colors.black),
                                  Icon(
                                    Icons.timer_outlined,
                                    color: MyTheme.primary,
                                    size: DeviceSize.myHeight(16),
                                  ),
                                  Text(
                                      "وقت التحضير ${provider.store.preparation_time}"),
                                  const VerticalDivider(color: Colors.black),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: DeviceSize.myHeight(16),
                                  ),
                                  const Text("rating"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: DeviceSize.padding.top),
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              shadows: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 4,
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(-0.7, 0.5),
                          child: Container(
                            width: DeviceSize.myWidth(80),
                            height: DeviceSize.myHeight(80),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "${DioHelper.baseUrl}/storage/images/${provider.store.image}")),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  color: Color(0xBF000000),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      "مغلق",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getResponsiveFontSize(context, 28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            color: Colors.white,
            height: DeviceSize.myHeight(200),
            width: DeviceSize.width,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: DeviceSize.width,
                      height: DeviceSize.myHeight(144),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "${DioHelper.baseUrl}/storage/images/${provider.store.image}"),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(provider.store.name),
                        Text(provider.store.address),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.restaurant_outlined,
                          color: MyTheme.primary,
                          size: DeviceSize.myWidth(16),
                        ),
                        const Text("data"),
                      ],
                    ),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_motorsports_outlined,
                            color: MyTheme.primary,
                            size: DeviceSize.myHeight(16),
                          ),
                          Text("قيمة التوصيل ${provider.store.delivery_cost}"),
                          const VerticalDivider(color: Colors.black),
                          Icon(
                            Icons.timer_outlined,
                            color: MyTheme.primary,
                            size: DeviceSize.myHeight(16),
                          ),
                          Text(
                              "وقت التحضير ${provider.store.preparation_time}"),
                          const VerticalDivider(color: Colors.black),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: DeviceSize.myHeight(16),
                          ),
                          const Text("rating"),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: DeviceSize.padding.top),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      shadows: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 4,
                        )
                      ],
                    ),
                  ),
                ),
                // const Align(
                //   alignment: Alignment(0, -0.7),
                //   child: SearchField(
                //     mini: true,
                //     transparent: true,
                //     route: "none",
                //   ),
                // ),
                Align(
                  alignment: const Alignment(-0.7, 0.5),
                  child: Container(
                    width: DeviceSize.myWidth(80),
                    height: DeviceSize.myHeight(80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "${DioHelper.baseUrl}/storage/images/${provider.store.image}")),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color(0xBF000000),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StoreCategories extends StatefulWidget {
  const StoreCategories({super.key});

  @override
  State<StoreCategories> createState() => _StoreCategoriesState();
}

class _StoreCategoriesState extends State<StoreCategories> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StoreProvider>(context, listen: false).getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: DeviceSize.myHeight(70),
        maxHeight: DeviceSize.myHeight(70),
        child: Consumer<StoreProvider>(builder: (_, provider, widget) {
          if (provider.storeCategoriesState == StoreCategoriesState.loading) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: List<Widget>.generate(
                3,
                (i) => Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ActionChip(label: Text("data")),
                  ),
                ),
              ).toList(),
            );
          }
          if (!provider.store.status) {
            return Text(
              "المطعم مغلق حاليا!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveFontSize(context, 20),
              ),
            );
          }
          if (provider.storeCategoriesState == StoreCategoriesState.hasData ||
              provider.categories.isNotEmpty) {
            return Container(
              color: Colors.white,
              alignment: Alignment.centerRight,
              child: SafeArea(
                child: ListView.builder(
                  itemCount: provider.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(5)),
                    child: FilterChip(
                      onSelected: (selected) {
                        if (selected) {
                          provider.filterProducts(provider.categories[i]);
                        } else {
                          provider.selectedCategory = null;
                          provider.getStoreProducts();
                        }
                      },
                      selected: provider.selectedCategory?.id ==
                          provider.categories[i].id,
                      labelStyle: const TextStyle(color: MyTheme.primary),
                      side: const BorderSide(color: MyTheme.primary),
                      disabledColor: Colors.white,
                      label: Text(provider.categories[i].name),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Text("error");
        }),
      ),
    );
  }
}
