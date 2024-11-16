import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/config/my_assets.dart';

import '../../providers/auth_provider.dart';
import '../components/my_button.dart';

class UpdateUserInfoDialog extends StatelessWidget {
  final String name;
  final String phone;
  final String address;

  const UpdateUserInfoDialog({
    required this.name,
    required this.phone,
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Consumer<AuthProvider>(
        builder: (context, provider, widget) {
          switch (provider.userDataState) {
            case UserDataState.done:
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("هل انت متأكد من تغيير معلومات حسابك؟"),
                    SizedBox(
                      height: DeviceSize.myHeight(16),
                    ),
                    Image.asset(MyAssets.imagePath +
                        MyImages.update_user_info_illistration),
                    SizedBox(
                      height: DeviceSize.myHeight(24),
                    ),
                    MyButton(
                      label: "تأكيد",
                      onPressed: () async {
                        await provider.updateUser(
                          context,
                          name,
                          phone,
                          address,
                        );
                      },
                    ),
                    SizedBox(
                      height: DeviceSize.myHeight(8),
                    ),
                    MyButton(
                        label: "الغاء",
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
              );
            case UserDataState.updatingUserPassword:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return const Text("Error");
          }
        },
      ),
    );
  }
}
