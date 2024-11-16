import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/providers/cart_provider.dart';
import 'package:saree/widgets/dialogs/disable_leaving_main_screen_dialog.dart';
import '../../config/theme.dart';
import '../../widgets/components/current_location.dart';
import '../../widgets/components/my_bottom_nav_bar.dart';
import '../../widgets/components/my_drawer.dart';
import '../chose_service_screen.dart';
import 'cart_page.dart';
import 'discount_page.dart';
import 'market_layout.dart';
import 'orders_page.dart';
import 'stores_layout.dart';

class MainScreenArguments {
  final int index;
  final bool showProducts;
  final int initialIndexForOrdersPage;

  const MainScreenArguments({
    this.showProducts = false,
    this.index = 0,
    this.initialIndexForOrdersPage = 0,
  });
}

class MainScreen extends StatefulWidget {
  static const routeName = "/home";
  final MainScreenArguments? arguments;

  const MainScreen({this.arguments, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  late List<Widget> _pages;
  late PageController pageController;
  final List<Widget> _appBars = [
    const CurrentLocation(),
    const Text("الطلبات"),
    const Text("الخصومات"),
    const Text("سلة المشتريات"),
  ];

  void _pageChanged(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  void initState() {
    index = widget.arguments?.index ?? 0;
    pageController = PageController(initialPage: index);
    _pages = [
      widget.arguments?.showProducts ?? false
          ? const MarketPage()
          : const StoresLayout(),
      OrdersPage(pageController),
      const DiscountPage(),
      CartPage(pageController),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBars[index],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (Provider.of<CartProvider>(context, listen: false)
                  .cart
                  .isEmpty) {
                Navigator.pushReplacementNamed(
                  context,
                  ChoseServiceScreen.routeName,
                );
              } else {
                showDialog(
                  context: context,
                  builder: (_) => const DisableLeavingMainScreenDialog(),
                );
              }
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: PageView(
        onPageChanged: _pageChanged,
        controller: pageController,
        children: _pages,
      ),
      floatingActionButton:
          Provider.of<CartProvider>(context, listen: false).cart.isNotEmpty &&
                  index != 3
              ? Badge(
                  label: Text(
                      "${Provider.of<CartProvider>(context, listen: false).cart.length}"),
                  child: FloatingActionButton.extended(
                    backgroundColor: MyTheme.primary,
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () => pageController.animateToPage(
                      3,
                      duration: Durations.medium2,
                      curve: Curves.easeInOutCubic,
                    ),
                    label: const Text("الذهاب للسلة"),
                  ),
                )
              : null,
      bottomNavigationBar: MyBottomNavBar(
        pageController,
        index: index,
      ),
    );
  }
}
