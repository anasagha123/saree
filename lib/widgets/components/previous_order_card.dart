import 'package:flutter/material.dart';
import 'package:saree/config/theme.dart';
import 'package:saree/models/order_model.dart';
import 'package:saree/network/remote/dio_helper.dart';
import 'package:saree/screens/order_details_screen.dart';

import '../../config/device_size.dart';

class PreviousOrderCard extends StatelessWidget {
  final OrderModel order;

  const PreviousOrderCard(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceSize.myWidth(350),
      height: DeviceSize.myHeight(270),
      margin: EdgeInsets.all(DeviceSize.myWidth(5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x77000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(DeviceSize.myWidth(5)),
            child: SizedBox(
              height: DeviceSize.myHeight(199),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.store.name),
                      Text(order.address),
                      ShowInvoiceButton(order),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.date_range_outlined,
                            color: MyTheme.primary,
                          ),
                          Text("Date"),
                          Icon(
                            Icons.list_outlined,
                            color: MyTheme.primary,
                          ),
                          Text("تم التوصيل")
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: DeviceSize.myWidth(150),
                    height: DeviceSize.myHeight(150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xC0000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        )
                      ],
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "${DioHelper.baseUrl}/storage/images/${order.store.f_image}"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: MyTheme.primary,
                borderRadius: BorderRadius.circular(10)),
            child: const Text(
              "اعادة الطلب",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowInvoiceButton extends StatelessWidget {
  final OrderModel order;

  const ShowInvoiceButton(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        OrderDetailsScreen.routeName,
        arguments: order,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(5)),
        decoration: BoxDecoration(
          color: const Color(0xCDD9D9D9),
          border: Border.all(width: 0.3),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: const Text(
          "عرض الفاتورة",
          style: TextStyle(color: MyTheme.primary),
        ),
      ),
    );
  }
}
