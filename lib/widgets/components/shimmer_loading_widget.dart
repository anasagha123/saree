import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final double height;
  final double width;
  final double raduis;
  final EdgeInsets margin;

  const ShimmerLoadingWidget({
    required this.height,
    required this.width,
    this.raduis = 0,
    this.margin = EdgeInsets.zero,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(raduis),
          color: Colors.black,
        ),
      ),
    );
  }
}
