import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/device_size.dart';
import '../config/my_assets.dart';
import '../config/responsive_font.dart';
import '../config/theme.dart';
import '../network/remote/dio_helper.dart';
import '../providers/sliders_provider.dart';
import '../widgets/components/my_divider.dart';
import '../widgets/components/my_network_image.dart';
import '../widgets/dialogs/logout_dialog.dart';
import 'internal_shipping_screen.dart';
import 'main_screen/main_screen.dart';

class ChoseServiceScreen extends StatelessWidget {
  static const routeName = "chose-service";

  const ChoseServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            PinnedHeaderSliver(
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      MyAssets.imagePath + MyImages.appLogo,
                      width: DeviceSize.myWidth(160),
                      height: DeviceSize.myHeight(70),
                      fit: BoxFit.fill,
                    ),
                    IconButton(
                      onPressed: () async => showDialog(
                          context: context,
                          builder: (context) => const LogoutDialog()),
                      icon: const Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
              ),
            ),
            const PinnedHeaderSliver(child: MyDivider()),
            ChangeNotifierProvider(
              create: (ctx) => SlidersProvider(),
              child: const Items(),
            ),
          ],
        ),
      ),
    );
  }
}

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SlidersProvider>(context, listen: false).getSliders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SlidersProvider>(
      builder: (_, provider, widget) {
        Widget loadingWidget = const Center(
          child: CircularProgressIndicator(),
        );

        return SliverToBoxAdapter(
          child: Column(
            children: [
              const ServiceCard(
                arabicLabel: "طلب الطعام",
                englishLabel: "Order food",
                route: MainScreen.routeName,
                icon: MyAssets.imagePath + MyImages.order_food_icon,
                arg: false,
              ),
              const ServiceCard(
                arabicLabel: "اطلب من الماركت",
                englishLabel: "Order from the market",
                route: MainScreen.routeName,
                icon: MyAssets.imagePath + MyImages.market_icon,
                arg: true,
              ),
              const ServiceCard(
                arabicLabel: "الشحن الداخلي",
                englishLabel: "Coming soon",
                route: InternalShippingScreen.routeName,
                icon: MyAssets.imagePath + MyImages.deliver_icon,
              ),
              if (provider.slidersState == SlidersState.done)
                ...provider.sliders.map(
                  (e) => AdvertismentCards(e.image),
                )
              else
                loadingWidget,
            ],
          ),
        );
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String arabicLabel;
  final String englishLabel;
  final String route;
  final String icon;
  final bool? arg;

  const ServiceCard({
    required this.arabicLabel,
    required this.englishLabel,
    required this.route,
    required this.icon,
    this.arg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route == MainScreen.routeName) {
          Navigator.pushNamed(context, route,
              arguments: MainScreenArguments(showProducts: arg!));
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        height: DeviceSize.myHeight(175),
        width: DeviceSize.myWidth(310),
        margin: EdgeInsets.symmetric(
          vertical: DeviceSize.myHeight(20),
        ),
        decoration: BoxDecoration(
          color: MyTheme.primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x7F000000),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.9, -0.9),
              child: Text(
                "7 / 24",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getResponsiveFontSize(context, 12),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.75, -1),
              child: CustomPaint(
                size: Size(DeviceSize.myWidth(29), DeviceSize.myHeight(20)),
                painter: ColumnsBuilder(),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    arabicLabel,
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, 30),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    englishLabel,
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, 20),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0.75, 1),
              child: CustomPaint(
                size: Size(DeviceSize.myWidth(29), DeviceSize.myHeight(20)),
                painter: ColumnsBuilder(),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.9),
              child: Image.asset(
                icon,
                width: DeviceSize.myWidth(26),
                height: DeviceSize.myHeight(26),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdvertismentCards extends StatelessWidget {
  final String image;

  const AdvertismentCards(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: DeviceSize.myHeight(175),
      width: DeviceSize.myWidth(310),
      margin: EdgeInsets.symmetric(vertical: DeviceSize.myHeight(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x7F000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: MyNetworkImage("${DioHelper.baseUrl}/storage/images/$image"),
    );
  }
}

class ColumnsBuilder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    Rect rect = Rect.fromPoints(
      const Offset(0, 0),
      Offset(
        DeviceSize.myWidth(7),
        DeviceSize.myHeight(20),
      ),
    );
    canvas.drawRect(rect, paint);
    rect = Rect.fromPoints(
      Offset(DeviceSize.myWidth(11), 0),
      Offset(
        DeviceSize.myWidth(18),
        DeviceSize.myHeight(20),
      ),
    );
    canvas.drawRect(rect, paint);
    rect = Rect.fromPoints(
      Offset(DeviceSize.myWidth(22), 0),
      Offset(
        DeviceSize.myWidth(29),
        DeviceSize.myHeight(20),
      ),
    );
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
