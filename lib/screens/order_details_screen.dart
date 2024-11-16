import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/device_size.dart';
import '../config/responsive_font.dart';
import '../config/theme.dart';
import '../models/order_model.dart';
import '../network/remote/dio_helper.dart';
import '../providers/order_details_provider.dart';
import '../widgets/components/network_error_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const routeName = "/order-details";

  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(
            "${Provider.of<OrderDetailsProvider>(context, listen: false).order.id}#"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<OrderDetailsProvider>(
        builder: (_, provider, child) {
          if (provider.orderDataStat == OrderDataStat.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.orderDataStat == OrderDataStat.hasData ||
              provider.orderDataStat == OrderDataStat.initial) {
            return RefreshIndicator(
              onRefresh: () async {
                provider.getOrderData(context);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    DeliveryEmployeeInfo(
                        isPrevious: provider.order.is_delivered),
                    provider.order.is_delivered
                        ? const SizedBox()
                        : const ContactCustomerServiceButton(),
                    RestaurantCard(provider.order),
                    InvoiceInfo(provider.order),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              provider.getOrderData(context);
            },
            child: const Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: NetworkErrorWidget(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DeliveryEmployeeInfo extends StatelessWidget {
  final bool isPrevious;

  const DeliveryEmployeeInfo({required this.isPrevious, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DeviceSize.myHeight(8)),
      margin: EdgeInsets.all(DeviceSize.myWidth(15)),
      width: DeviceSize.myWidth(330),
      height: DeviceSize.myHeight(80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0xC0000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("employee-name"),
              Text("employee-phone"),
            ],
          ),
          isPrevious
              ? const SizedBox()
              : Icon(
                  Icons.phone_outlined,
                  color: MyTheme.primary,
                  size: DeviceSize.myHeight(30),
                ),
          Container(
            width: DeviceSize.myWidth(65),
            height: DeviceSize.myHeight(65),
            color: Colors.grey.withAlpha(150),
            alignment: Alignment.center,
            child: const Text("employee-img"),
          ),
        ],
      ),
    );
  }
}

class ContactCustomerServiceButton extends StatelessWidget {
  const ContactCustomerServiceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: DeviceSize.myWidth(300),
        height: DeviceSize.myHeight(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 0.2),
          color: const Color(0x80D9D9D9),
        ),
        child: const Text(
          "تحدث مع الدعم الفني لتعديل الطلب",
          style: TextStyle(color: MyTheme.primary),
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final OrderModel order;

  const RestaurantCard(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceSize.myHeight(80),
      width: DeviceSize.myWidth(300),
      margin: EdgeInsets.all(DeviceSize.myWidth(30)),
      padding: EdgeInsets.all(DeviceSize.myHeight(8)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(order.store.name),
              Text(
                  "${order.created_at?.year}/${order.created_at?.month}/${order.created_at?.day}  ${order.created_at?.hour}:${order.created_at?.minute}"),
            ],
          ),
          Container(
            width: DeviceSize.myWidth(65),
            height: DeviceSize.myHeight(65),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "${DioHelper.baseUrl}/storage/images/${order.store.f_image}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvoiceItem extends StatelessWidget {
  final ProductOrderModel product;

  const InvoiceItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceSize.myHeight(40),
      width: DeviceSize.myWidth(300),
      margin: EdgeInsets.symmetric(vertical: DeviceSize.myHeight(2)),
      padding: EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF000000),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(product.product_name),
          Text(product.product_quntity.toString()),
          Text(product.product_price.toString()),
        ],
      ),
    );
  }
}

class InvoiceItemsList extends StatelessWidget {
  final List<ProductOrderModel> products;

  const InvoiceItemsList(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceSize.myHeight(40 * 5 + DeviceSize.myWidth(4) * 5),
      child: ListView.builder(
        itemBuilder: (_, i) => InvoiceItem(products[i]),
        itemCount: products.length,
      ),
    );
  }
}

class InvoiceInfo extends StatelessWidget {
  final OrderModel order;

  const InvoiceInfo(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(30)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          InvoiceItemsList(order.products),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("مجموع العنلصر"),
              Text("${order.products_amount}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("قيمة الخصم"),
              Text("${order.products_amount - order.after_discount}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("تكلفة التوصيل"),
              Text("${order.delivery_cost}"),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("رسوم الخدمة"),
              Text("service-bills"),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "المجموع النهائي",
                style: TextStyle(
                  fontSize: getResponsiveFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${order.total_amount}",
                style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
