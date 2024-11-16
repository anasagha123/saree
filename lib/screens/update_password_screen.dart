import 'package:flutter/material.dart';
import 'package:saree/widgets/dialogs/update_user_password_dialog.dart';

import '../config/device_size.dart';
import '../config/theme.dart';
import '../widgets/components/my_button.dart';
import '../widgets/components/my_text_form_field.dart';

class UpdateUserPasswordScreen extends StatefulWidget {
  static const routeName = "/update-user-password";

  const UpdateUserPasswordScreen({super.key});

  @override
  State<UpdateUserPasswordScreen> createState() =>
      _UpdateUserPasswordScreenState();
}

class _UpdateUserPasswordScreenState extends State<UpdateUserPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _newPassword = TextEditingController();
  final _repeatNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    theme.textTheme.headlineMedium!.copyWith(color: MyTheme.primary);
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل كلمة المرور"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(20)),
        child: SizedBox(
          height: DeviceSize.myHeight(500),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "كلمة المرور السابقة",
                  style: theme.textTheme.headlineMedium,
                ),
                MyTextFormField(
                  controller: _password,
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                Text(
                  "كلمة المرور الجديدة",
                  style: theme.textTheme.headlineMedium,
                ),
                MyTextFormField(
                  controller: _newPassword,
                  icon: Icons.lock_outline,
                  obscureText: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "يجب ملئ الحقل";
                    }
                    if (val.length < 8) {
                      return "يجب ان تكون كلمة المرور 8 احرف على الاقل";
                    }
                    return null;
                  },
                ),
                Text(
                  "تأكيد كلمة المرور الجديدة",
                  style: theme.textTheme.headlineMedium,
                ),
                MyTextFormField(
                  controller: _repeatNewPassword,
                  icon: Icons.lock_outline,
                  obscureText: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "يجب ملئ الحقل";
                    }
                    if (val != _newPassword.text) {
                      return "كلمة المرور غير متطابقة";
                    }
                    if (val.length < 8) {
                      return "يجب ان تكون كلمة المرور 8 احرف على الاقل";
                    }
                    return null;
                  },
                ),
                Center(
                  child: MyButton(
                      label: "تعديل",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => UpdateUserPasswordDialog(
                              password: _password.text,
                              newPassword: _newPassword.text,
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
