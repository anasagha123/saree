import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/widgets/components/shimmer_loading_widget.dart';

import '../../config/device_size.dart';
import '../../config/my_assets.dart';
import '../../config/responsive_font.dart';
import '../../config/theme.dart';
import '../../providers/auth_provider.dart';
import '../../screens/login_screen.dart';
import '../../screens/main_screen/main_screen.dart';
import '../../screens/user_info_screen.dart';
import '../dialogs/logout_dialog.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: DeviceSize.width,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(DeviceSize.myWidth(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close_rounded,
                  size: 40,
                  weight: 1000,
                ),
              ),
              Center(
                child: Image.asset(
                    MyAssets.imagePath + MyImages.default_profile_image),
              ),
              const UserName(),
              Center(
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, UserInfoScreen.routeName),
                  child: Container(
                    alignment: Alignment.center,
                    height: DeviceSize.myHeight(41),
                    width: DeviceSize.myWidth(189),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xE7000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      "معلومات الملف الشخصي",
                      style: TextStyle(
                        color: MyTheme.primary,
                        fontSize: getResponsiveFontSize(context, 16),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: DeviceSize.myHeight(50)),
              const DrawerButton(
                icon: Icons.article_outlined,
                label: "الطلبات السابقة",
                route: MainScreen.routeName,
                mainScreenArguments:
                    MainScreenArguments(index: 1, initialIndexForOrdersPage: 1),
              ),
              SizedBox(height: DeviceSize.myHeight(20)),
              const DrawerButton(
                icon: Icons.local_fire_department_outlined,
                label: "مركز الخصومات والرسائل",
                route: MainScreen.routeName,
                mainScreenArguments: MainScreenArguments(index: 2),
              ),
              SizedBox(height: DeviceSize.myHeight(20)),
              const DrawerButton(
                icon: Icons.exit_to_app_outlined,
                label: "الخروج",
                route: LoginScreen.routeName,
              ),
              SizedBox(
                height: DeviceSize.myHeight(150),
              ),
              GestureDetector(
                child: Container(
                  height: DeviceSize.myHeight(56),
                  width: DeviceSize.myWidth(335),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xBF000000),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "تحدث مع خدمة العملاء",
                        style: TextStyle(
                          color: MyTheme.primary,
                          fontSize: getResponsiveFontSize(context, 16),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        width: DeviceSize.myWidth(10),
                      ),
                      const Icon(
                        Icons.headset_mic_outlined,
                        color: MyTheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<AuthProvider>(builder: (_, provider, widget) {
        switch (provider.userDataState) {
          case UserDataState.loading:
            return ShimmerLoadingWidget(
              height: DeviceSize.myHeight(30),
              width: DeviceSize.myWidth(120),
            );
          case UserDataState.error:
            return const Text("ERROR");
          case UserDataState.done:
            return Text(provider.user!.name);
          default:
            return const Text("ERROR");
        }
      }),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final String label;
  final MainScreenArguments mainScreenArguments;
  final IconData icon;
  final String route;

  const DrawerButton({
    this.mainScreenArguments = const MainScreenArguments(),
    required this.route,
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (route) {
          case MainScreen.routeName:
            Navigator.pushReplacementNamed(
              context,
              route,
              arguments: mainScreenArguments,
            );
            break;
          case LoginScreen.routeName:
            showDialog(
              context: context,
              builder: (context) => const LogoutDialog(),
            );
            break;
          default:
            throw "error unhandled route";
        }
      },
      child: Container(
        height: DeviceSize.myHeight(35),
        width: DeviceSize.myWidth(285),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xE7000000),
              offset: Offset(0, 2),
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: DeviceSize.myWidth(5)),
            Icon(icon),
            SizedBox(width: DeviceSize.myWidth(10)),
            Text(
              label,
              style: TextStyle(fontSize: getResponsiveFontSize(context, 16)),
            ),
          ],
        ),
      ),
    );
  }
}
