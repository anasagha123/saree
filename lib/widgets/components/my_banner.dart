import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/widgets/components/shimmer_loading_widget.dart';

import '../../config/device_size.dart';
import '../../network/remote/dio_helper.dart';
import '../../providers/banners_provider.dart';
import 'my_network_image.dart';

class MyBanner extends StatefulWidget {
  const MyBanner({super.key});

  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  final _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BannersProvider>(context, listen: false)
          .getMarkitingBanners();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _timer?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: DeviceSize.myHeight(5)),
        width: DeviceSize.myWidth(300),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 6,
          child: Consumer<BannersProvider>(builder: (_, provider, child) {
            _timer?.cancel();
            if (provider.bannersState == BannersState.loading) {
              return const ShimmerLoadingWidget(height: 0, width: 0);
            }
            if (provider.bannersState == BannersState.error) {
              return const Text("error");
            } else {
              if (provider.markiting_banners.length > 1) {
                _timer = Timer.periodic(
                  const Duration(seconds: 5),
                  (timer) {
                    int nextPage = (_pageController.page!.toInt() + 1) %
                        provider.markiting_banners.length;
                    _pageController.animateToPage(
                      nextPage,
                      duration: Durations.short4,
                      curve: Curves.easeInOutCubic,
                    );
                  },
                );
              }
              return PageView(
                  controller: _pageController,
                  children: provider.markiting_banners
                      .map((e) => MyNetworkImage(
                          "${DioHelper.baseUrl}/storage/images/${e.image}"))
                      .toList());
            }
          }),
        ),
      ),
    );
  }
}
