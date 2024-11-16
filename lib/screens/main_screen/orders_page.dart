import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/theme.dart';
import 'package:saree/providers/order_provider.dart';
import 'package:saree/screens/main_screen/main_screen.dart';

import '../../widgets/layout/order_list.dart';
import '../../widgets/layout/previous_orders_list.dart';

class OrdersPage extends StatefulWidget {
  final PageController pageController;

  const OrdersPage(this.pageController, {super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrdersProvider>(context, listen: false).getOrders(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainScreenArguments arguments =
        ModalRoute.of(context)?.settings.arguments as MainScreenArguments;
    return SafeArea(
      child: DefaultTabController(
        initialIndex: arguments.initialIndexForOrdersPage,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const TabBar(
              indicatorColor: MyTheme.primary,
              labelColor: MyTheme.primary,
              tabs: [
                Tab(text: "الطلبات الحالية"),
                Tab(text: "الطلبات السابقة"),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              OrdersList(widget.pageController),
              PreviousOrdersList(widget.pageController),
            ],
          ),
        ),
      ),
    );
  }
}
