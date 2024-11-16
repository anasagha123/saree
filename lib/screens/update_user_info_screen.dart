import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/device_size.dart';
import '../config/theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/components/my_button.dart';
import '../widgets/components/my_text_form_field.dart';
import '../widgets/dialogs/update_user_info_dialog.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  static const routeName = "/update-user-info";

  const UpdateUserInfoScreen({super.key});

  @override
  State<UpdateUserInfoScreen> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = Provider.of<AuthProvider>(context, listen: false).user;
      _name.text = user!.name;
      _phone.text = user.phone;
      _address.text = user.location.address;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    theme.textTheme.headlineMedium!.copyWith(color: MyTheme.primary);
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل معلومات الحساب"),
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
                  "الاسم والكنية",
                  style: theme.textTheme.headlineMedium,
                ),
                MyTextFormField(
                  controller: _name,
                  icon: Icons.person_outline,
                  validator: (val) => val!.isEmpty ? "يجب ملئ الاسم" : null,
                ),
                Text(
                  "رقم الجوال",
                  style: theme.textTheme.headlineMedium,
                ),
                MyTextFormField(
                  controller: _phone,
                  keyBoardType: TextInputType.phone,
                  icon: Icons.phone_outlined,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "يجب ملئ رقم الجوال";
                    }
                    if (val.length != 10) {
                      return "الرجاء ادخال رقم جوال صحيح";
                    }
                    return null;
                  },
                ),
                Text(
                  "العنوان",
                  style: theme.textTheme.headlineMedium,
                ),
                MyTextFormField(
                  controller: _address,
                  icon: Icons.home_outlined,
                  validator: (val) => val!.isEmpty ? "يجب ملئ العنوان" : null,
                ),
                Center(
                  child: MyButton(
                    label: "تعديل",
                    onPressed: ()  {
                      if(_formKey.currentState!.validate()){
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => UpdateUserInfoDialog(
                            name: _name.text,
                            phone: _phone.text,
                            address: _address.text,
                          ),
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
