import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/models/order_model.dart';
import 'package:saree/providers/order_provider.dart';
import 'package:saree/widgets/components/network_error_widget.dart';
import 'package:saree/widgets/components/order_card.dart';

import '../../config/my_assets.dart';
import '../../config/responsive_font.dart';
import '../../config/theme.dart';

class OrdersList extends StatelessWidget {
  final PageController pageController;

  const OrdersList(this.pageController, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceSize.myHeight(280 * 3),
      child: RefreshIndicator(
        onRefresh: () async =>
            Provider.of<OrdersProvider>(context, listen: false)
                .getOrders(context),
        child: Consumer<OrdersProvider>(
          builder: (_, provider, widget) {
            // LOADING STATE
            if (provider.ordersDataState == OrdersDataState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            // GOT ORDERS SUCCESSFULLY
            if (provider.ordersDataState == OrdersDataState.hasData) {
              List<OrderModel> orders =
                  provider.orders.where((e) => !e.is_delivered).toList();
              // ORDERS IS EMPTY
              if (orders.isEmpty) {
                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            MyAssets.imagePath + MyImages.invoice,
                            width: DeviceSize.myWidth(90),
                          ),
                          Text(
                            "ابدأ بالطلب",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getResponsiveFontSize(context, 20),
                            ),
                          ),
                          const Text(
                            "قم بوضع طلبات جديدة, وستظهر لك الطلبات الحالية والسابقة هنا",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: () => pageController.jumpToPage(0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: MyTheme.primary)),
                              child: Text(
                                "اطلب الآن",
                                style: TextStyle(
                                  color: MyTheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: getResponsiveFontSize(context, 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemBuilder: (_, i) => OrderCard(orders[i]),
                itemCount: orders.length,
              );
            }
            // ERROR GETTING ORDERS
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: NetworkErrorWidget(),
            );
          },
        ),
      ),
    );
  }
}
