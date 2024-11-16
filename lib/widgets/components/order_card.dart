import 'dart:math';

import 'package:flutter/material.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';
import '../../models/order_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../screens/order_details_screen.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard(this.order, {super.key});

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
                    children: [
                      Text(order.store.name),
                      Text(order.store.address),
                      Text(order.address),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: MyTheme.primary,
                          ),
                          Text(order.store.preparation_time),
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                    "${DioHelper.baseUrl}/storage/images/${order.store.f_image}"))),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          OrderDetailsScreen.routeName,
                          arguments: order,
                        ),
                        child: Container(
                          width: DeviceSize.myWidth(130),
                          height: DeviceSize.myHeight(40),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: MyTheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "متابعة حالة الطلب",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(DeviceSize.myWidth(10)),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: [
                Icon(
                  Icons.check_box_outlined,
                  color: orderStateToInt(order.status) > 0
                      ? MyTheme.primary
                      : null,
                ),
                CustomPaint(
                  size: Size(DeviceSize.myWidth(60), DeviceSize.myHeight(5)),
                  painter: ArrowPainter(),
                ),
                Icon(
                  Icons.soup_kitchen_outlined,
                  color: orderStateToInt(order.status) > 1
                      ? MyTheme.primary
                      : null,
                ),
                CustomPaint(
                  size: Size(DeviceSize.myWidth(60), DeviceSize.myHeight(5)),
                  painter: ArrowPainter(),
                ),
                Icon(
                  Icons.delivery_dining_outlined,
                  color: orderStateToInt(order.status) > 2
                      ? MyTheme.primary
                      : null,
                ),
                CustomPaint(
                  size: Size(DeviceSize.myWidth(60), DeviceSize.myHeight(5)),
                  painter: ArrowPainter(),
                ),
                Icon(
                  Icons.home_outlined,
                  color: orderStateToInt(order.status) > 3
                      ? MyTheme.primary
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Offset startPoint = const Offset(0, 0);
    Offset endPoint = Offset(size.width, 0);
    canvas.drawLine(startPoint, endPoint, paint);

    double arrowSize = 5;
    double angle = pi / 2;
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(DeviceSize.myWidth(55) - arrowSize * cos(angle),
        arrowSize * sin(angle));
    path.moveTo(size.width, 0);
    path.lineTo(DeviceSize.myWidth(55) - arrowSize * cos(angle),
        -(arrowSize * sin(angle)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
