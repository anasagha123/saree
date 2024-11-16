import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/widgets/components/show_snack_bar.dart';

import '../config/device_size.dart';
import '../config/responsive_font.dart';
import '../config/theme.dart';
import '../providers/cart_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/components/invoice_item.dart';
import '../widgets/components/labeled_box.dart';
import '../widgets/components/show_info_dialog.dart';
import '../widgets/dialogs/enter_coupon_dialog.dart';
import '../widgets/bottom_sheets/location_bottom_sheet.dart';
import 'store_details_screen.dart';

class InvoiceScreen extends StatefulWidget {
  static const routeName = "/invoice";

  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CartProvider>(context, listen: false).getStoreData();
      Provider.of<CartProvider>(context, listen: false).calcTotal();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الطلب"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("العنوان"),
                TextButton(
                  child: const Text(
                    "تغيير العنوان",
                    style: TextStyle(color: Color(0xFF5355E0)),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      useSafeArea: true,
                      enableDrag: false,
                      context: context,
                      builder: (_) => const LocationsBottomSheet(),
                    );
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer<LocationProvider>(
              builder: (_, provider, w) => LabeledBox(
                icon: Icons.location_on_outlined,
                label: provider.selectedLocation == null
                    ? "الرجاء تحديد الموقع"
                    : provider.selectedLocation!.name,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Text("طريقة الدفع")),
          const SliverToBoxAdapter(
            child: LabeledBox(
              icon: Icons.attach_money_rounded,
              label: "الدفع عند الاستلام",
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: DeviceSize.myHeight(20))),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                width: DeviceSize.myWidth(210),
                height: DeviceSize.myHeight(40),
                padding: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "كود الخصم",
                      style: TextStyle(
                          fontSize: getResponsiveFontSize(context, 18)),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => const EnterCouponDialog(),
                          barrierDismissible: false,
                        );
                      },
                      child: Container(
                        width: DeviceSize.myWidth(80),
                        height: DeviceSize.myHeight(40),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyTheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "ادخال",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getResponsiveFontSize(context, 18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: DeviceSize.myHeight(20))),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "تفاصيل الفاتورة",
                    style:
                        TextStyle(fontSize: getResponsiveFontSize(context, 18)),
                  ),
                  TextButton(
                    onPressed: () {
                      if (Provider.of<CartProvider>(context, listen: false)
                              .cartStoreDataState ==
                          CartStoreDataState.hasData) {
                        Navigator.pushNamed(
                          context,
                          StoreDetailsScreen.routeName,
                          arguments:
                              Provider.of<CartProvider>(context, listen: false)
                                  .store,
                        );
                      }
                    },
                    child: Text(
                      "اضافة المزيد +",
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, 18),
                        color: const Color(0xFF5355E0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: DeviceSize.myWidth(340),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Consumer<CartProvider>(
                builder: (_, provider, child) => Column(
                  children: [
                    ...provider.cart.values.map((e) => InvoiceItem(e)),
                    SizedBox(height: DeviceSize.myHeight(16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("اجمالي الطلب"),
                        Text("${provider.after_discount}"),
                        const SizedBox(),
                      ],
                    ),
                    SizedBox(height: DeviceSize.myHeight(8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("قيمة الخصم"),
                        Text(provider.discount_amount.toString()),
                        const SizedBox(),
                      ],
                    ),
                    SizedBox(height: DeviceSize.myHeight(8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("تكلفة التوصيل"),
                        provider.cartStoreDataState ==
                                CartStoreDataState.hasData
                            ? Text("${provider.store!.delivery_cost}")
                            : const Text("LOADING"),
                        const ShowInfoDialogButton(
                            "تضاف رسوم خدمة توصيل , بحد أقصى []. تهدف هذه الرسوم إلى ضمان تقديم أفضل خدمة ممكنة لك"),
                      ],
                    ),
                    SizedBox(height: DeviceSize.myHeight(16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "المجموع الكلي",
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(context, 18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: (_, provider, child) {
                            if (provider.cartStoreDataState ==
                                CartStoreDataState.hasData) {
                              return Text(
                                "${provider.total_amount}",
                                style: TextStyle(
                                  fontSize: getResponsiveFontSize(context, 18),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return const Text("LOADING");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (Provider.of<CartProvider>(context, listen: false)
                        .cart
                        .isNotEmpty) {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        useSafeArea: true,
                        enableDrag: false,
                        context: context,
                        builder: (_) => const LocationsBottomSheet(
                          isBuying: true,
                        ),
                      );
                    } else {
                      showSnackBar(
                        context: context,
                        message: "لا يمكنك اتمام عملية الشراء بسلة فارغة",
                        state: SnackBarState.error,
                      );
                    }
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
                      "اتمام الشراء",
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
      ),
    );
  }
}
