import 'package:flutter/material.dart';

import '../components/add_location_info_widget.dart';
import '../components/select_location_widget.dart';

class LocationsBottomSheet extends StatefulWidget {
  final bool isBuying;

  const LocationsBottomSheet({this.isBuying = false, super.key});

  @override
  State<LocationsBottomSheet> createState() => _LocationsBottomSheetState();
}

class _LocationsBottomSheetState extends State<LocationsBottomSheet> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SelectLocationWidget(_pageController,isBuying: widget.isBuying,),
        AddLocationInfo(_pageController),
      ],
    );
  }
}
