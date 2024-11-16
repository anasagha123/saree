import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/widgets/components/product_card.dart';

import '../../config/device_size.dart';
import '../../config/my_assets.dart';
import '../../config/responsive_font.dart';
import '../../config/theme.dart';
import '../../providers/cart_provider.dart';
import '../invoice_screen.dart';

class CartPage extends StatelessWidget {
  final PageController pageController;

  const CartPage(this.pageController, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CartProvider>(
        builder: (ctx, provider, _) {
          if (provider.cart.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MyAssets.imagePath + MyImages.add_to_cart,
                  width: DeviceSize.myWidth(90),
                ),
                Text(
                  "أضف بعض العناصر",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getResponsiveFontSize(context, 20),
                  ),
                ),
                const Text("قم بالبدء بإضافة عناصر جديدة لإنشاء سلة تسوق"),
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
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemBuilder: (_, i) =>
                      ProductCard(provider.cart.values.elementAt(i)),
                  itemCount: provider.cart.values.length,
                ),
                SliverToBoxAdapter(
                  child: GestureDetector(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: MyTheme.primary),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "اضافة المزيد +",
                          style: TextStyle(
                            color: MyTheme.primary,
                            fontSize: getResponsiveFontSize(context, 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, InvoiceScreen.routeName);
                        },
                        child: Container(
                          width: DeviceSize.width,
                          height: DeviceSize.myHeight(50),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: MyTheme.primary,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                          ),
                          child: Text(
                            "متابعة",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getResponsiveFontSize(context, 18),
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
        },
      ),
    );
  }
}
