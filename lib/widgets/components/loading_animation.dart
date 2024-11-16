import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/device_size.dart';
import '../../config/my_assets.dart';
import '../../config/theme.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  Color primary = MyTheme.primary;
  Color scondery = MyTheme.scondery;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
      Durations.long2,
      (timer) {
        setState(() {
          Color temp = primary;
          primary = scondery;
          scondery = temp;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: DeviceSize.myHeight(100),
        width: DeviceSize.myHeight(230),
        child: Stack(
          children: [
            Image.asset(
              MyAssets.imagePath + MyImages.loading,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: const Alignment(0.62, -0.36),
              child: CustomPaint(
                size: Size(DeviceSize.myWidth(53), DeviceSize.myHeight(33)),
                painter: ColumnsPainter(primary, scondery),
              ),
            ),
            Align(
              alignment: const Alignment(-0.11, 0.545),
              child: CustomPaint(
                size: Size(DeviceSize.myWidth(27), DeviceSize.myHeight(12)),
                painter: DotsPainter(primary, scondery),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnsPainter extends CustomPainter {
  final Paint paintPrimary;
  final Paint paintSecondary;

  ColumnsPainter(Color primary, Color scondery)
      : paintPrimary = Paint()..color = primary,
        paintSecondary = Paint()..color = scondery;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(
      const Offset(0, 0),
      Offset(
        DeviceSize.myWidth(11),
        DeviceSize.myHeight(36),
      ),
    );
    canvas.drawRect(rect, paintPrimary);
    rect = Rect.fromPoints(
      Offset(DeviceSize.myWidth(21), 0),
      Offset(
        DeviceSize.myWidth(32),
        DeviceSize.myHeight(36),
      ),
    );
    canvas.drawRect(rect, paintSecondary);
    rect = Rect.fromPoints(
      Offset(DeviceSize.myWidth(42), 0),
      Offset(
        DeviceSize.myWidth(53),
        DeviceSize.myHeight(36),
      ),
    );
    canvas.drawRect(rect, paintPrimary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DotsPainter extends CustomPainter {
  final Paint paintPrimary;
  final Paint paintSecondary;

  DotsPainter(Color primary, Color scondery)
      : paintPrimary = Paint()..color = primary,
        paintSecondary = Paint()..color = scondery;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(0, 0), DeviceSize.myWidth(6), paintPrimary);
    canvas.drawCircle(Offset(DeviceSize.myWidth(14), 0), DeviceSize.myWidth(6),
        paintSecondary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
