import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/responsive_font.dart';
import 'package:saree/network/remote/dio_helper.dart';
import 'package:saree/providers/cart_provider.dart';
import 'package:saree/providers/product_provider.dart';
import 'package:saree/screens/main_screen/main_screen.dart';

import '../config/device_size.dart';
import '../config/theme.dart';
import '../widgets/components/add_to_cart_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = "/product-details";

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          Provider.of<ProductProvider>(context).product.name,
          style: TextStyle(
            fontSize: getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<ProductProvider>(context, listen: false)
              .getProductData();
        },
        child: Consumer<ProductProvider>(builder: (_, provider, widget) {
          if (provider.productState == ProductState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.productState == ProductState.hasData ||
              provider.productState == ProductState.initial) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: DeviceSize.myWidth(17)),
                        width: DeviceSize.myWidth(325),
                        height: DeviceSize.myHeight(250),
                        decoration: BoxDecoration(
                          color: provider.product.status
                              ? Colors.white
                              : Colors.grey.withAlpha(200),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            opacity: provider.product.status ? 1 : 0.3,
                            image: NetworkImage(
                                "${DioHelper.baseUrl}/storage/images/${provider.product.image}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: provider.product.status
                            ? null
                            : Text(
                                "غير متوفر",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getResponsiveFontSize(context, 24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(height: DeviceSize.myHeight(10)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.symmetric(
                            horizontal: DeviceSize.myWidth(17)),
                        width: DeviceSize.myWidth(325),
                        height: DeviceSize.myHeight(167),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Color(0xBF000000),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: DeviceSize.myHeight(80),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Text(
                                      provider.product.name,
                                      style: TextStyle(
                                        fontSize:
                                            getResponsiveFontSize(context, 20),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      provider.product.description,
                                      style: TextStyle(
                                        fontSize:
                                            getResponsiveFontSize(context, 16),
                                      ),
                                      maxLines: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(child: AddToCartWidget(provider.product)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: DeviceSize.myHeight(40),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE2DADA),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "المجموع",
                              style: TextStyle(
                                fontSize: getResponsiveFontSize(context, 16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              Provider.of<CartProvider>(context)
                                  .productTotal(provider.product),
                              style: TextStyle(
                                fontSize: getResponsiveFontSize(context, 16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          MainScreen.routeName,
                          (route) => false,
                          arguments: const MainScreenArguments(index: 3),
                        ),
                        child: Container(
                          height: DeviceSize.myHeight(40),
                          width: DeviceSize.width,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: MyTheme.primary,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                          child: Text(
                            "الذهاب الى السلة",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getResponsiveFontSize(context, 16),
                              fontWeight: FontWeight.bold,
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
          return Text("error");
        }),
      ),
    );
  }
}
