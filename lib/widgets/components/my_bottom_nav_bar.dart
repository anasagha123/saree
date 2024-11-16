import 'package:flutter/material.dart';
import 'package:saree/config/device_size.dart';

import '../../config/theme.dart';

class MyBottomNavBar extends StatelessWidget {
  final int index;
  final PageController pageController;

  const MyBottomNavBar(this.pageController, {this.index = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceSize.myHeight(70),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide()), color: Colors.white),
      child: BottomNavigationBar(
        selectedItemColor: MyTheme.primary,
        unselectedItemColor: const Color(0xFF000000),
        elevation: 0,
        backgroundColor: Colors.white,
        onTap: (index) => pageController.jumpToPage(index),
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: "الطلبات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined),
            label: "الخصومات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "السلة",
          ),
        ],
      ),
    );
  }
}
