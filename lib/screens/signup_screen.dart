

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/device_size.dart';
import '../config/my_assets.dart';
import '../config/theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/components/draw_cornered_tringles.dart';
import '../widgets/components/my_button.dart';
import '../widgets/components/my_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/register";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _password = TextEditingController();
  final _repeatPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    theme.textTheme.headlineMedium!.copyWith(color: MyTheme.primary);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: DeviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  CustomPaint(
                    size:
                        Size(DeviceSize.myWidth(363), DeviceSize.myHeight(48)),
                    painter: TrianglePainter(
                        color: MyTheme.scondery, corner: Corner.TOP_RIGHT),
                  ),
                  CustomPaint(
                    size:
                        Size(DeviceSize.myWidth(326), DeviceSize.myHeight(34)),
                    painter: TrianglePainter(
                        color: MyTheme.primary, corner: Corner.TOP_RIGHT),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: DeviceSize.myWidth(42),
                  ),
                  Image.asset(
                    MyAssets.imagePath + MyImages.appLogo,
                    width: DeviceSize.myWidth(181),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(20)),
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
                          hint: "الاسم الثلاثي",
                          validator: (val) =>
                              val!.isEmpty ? "يجب ملئ الاسم" : null,
                        ),
                        Text(
                          "رقم الجوال",
                          style: theme.textTheme.headlineMedium,
                        ),
                        MyTextFormField(
                          controller: _phone,
                          keyBoardType: TextInputType.phone,
                          hint: "0911111111",
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
                          hint: "دمشق",
                          controller: _address,
                          icon: Icons.home_outlined,
                          validator: (val) =>
                              val!.isEmpty ? "يجب ملئ العنوان" : null,
                        ),
                        Text(
                          "تعيين كلمة المرور",
                          style: theme.textTheme.headlineMedium,
                        ),
                        MyTextFormField(
                          controller: _password,
                          keyBoardType: TextInputType.visiblePassword,
                          obscureText: true,
                          hint: "\$@ree49526",
                          icon: Icons.lock_outline,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "يجب ملئ كلمة المرور";
                            }
                            if (val.length < 8) {
                              return "يجب ان تكون كلمة المرور 8 احرف على الاقل";
                            }
                            return null;
                          },
                        ),
                        Text(
                          "تأكيد كلمة المرور",
                          style: theme.textTheme.headlineMedium,
                        ),
                        MyTextFormField(
                          controller: _repeatPassword,
                          keyBoardType: TextInputType.visiblePassword,
                          obscureText: true,
                          hint: "\$@ree49526",
                          icon: Icons.lock_outline,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "يجب ملئ الحقل";
                            }
                            if (val != _password.text) {
                              return "كلمة المرور غير متطابقة";
                            }
                            if (val.length < 8) {
                              return "يجب ان تكون كلمة المرور 8 احرف على الاقل";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Consumer<AuthProvider>(
                builder: (context, provider, widget) => MyButton(
                  label: "تسجيل الحساب",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await provider.signup(
                        context,
                        _name.text,
                        _phone.text,
                        _password.text,
                        _address.text,
                      );
                    }
                  },
                ),
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CustomPaint(
                    size:
                        Size(DeviceSize.myWidth(363), DeviceSize.myHeight(48)),
                    painter: TrianglePainter(
                        color: MyTheme.scondery, corner: Corner.BOTTOM_LEFT),
                  ),
                  CustomPaint(
                    size:
                        Size(DeviceSize.myWidth(326), DeviceSize.myHeight(34)),
                    painter: TrianglePainter(
                        color: MyTheme.primary, corner: Corner.BOTTOM_LEFT),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
