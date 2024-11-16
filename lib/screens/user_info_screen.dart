import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/widgets/components/network_error_widget.dart';

import '../config/my_assets.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../widgets/dialogs/delete_user_dialog.dart';
import 'update_password_screen.dart';
import 'update_user_info_screen.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = "/user-info";

  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("معلومات الحساب")),
      body: Consumer<AuthProvider>(
        builder: (_, provider, widget) => RefreshIndicator(
          onRefresh: () async => await provider.getUserInfo(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                      MyAssets.imagePath + MyImages.default_profile_image),
                  const Text("معلومات الحساب"),
                  userData(context, provider.userDataState, provider.user),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget userData(BuildContext context, UserDataState state, UserModel? user) {
  if (state == UserDataState.loading) {
    return const CircularProgressIndicator();
  }
  if (state == UserDataState.done || user != null) {
    return Stack(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Text("الاسم: ${user!.name}"),
                Text("رقم الجوال: ${user.phone}"),
                Text("العنوان: ${user.location.address}"),
              ],
            ),
            PopupMenuButton(
              color: Colors.white,
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  child: const Text("تعديل معلومات الحساب"),
                  onTap: () => Navigator.pushNamed(
                      context, UpdateUserInfoScreen.routeName),
                ),
                PopupMenuItem(
                  child: const Text("تعديل كلمة المرور"),
                  onTap: () => Navigator.pushNamed(
                      context, UpdateUserPasswordScreen.routeName),
                ),
                PopupMenuItem(
                  child: const Text("حذف الحساب"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => const DeleteUserDialog());
                  },
                ),
              ],
              child: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
      ],
    );
  }
  return const NetworkErrorWidget();
}
