import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/device_size.dart';
import '../config/my_assets.dart';
import '../config/responsive_font.dart';
import '../config/theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/components/draw_cornered_tringles.dart';
import '../widgets/components/my_button.dart';
import '../widgets/components/my_text_form_field.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController();
  final _password = TextEditingController();
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
                    size: Size(DeviceSize.width, DeviceSize.myHeight(138)),
                    painter: TrianglePainter(
                        color: MyTheme.scondery, corner: Corner.TOP_RIGHT),
                  ),
                  CustomPaint(
                    size:
                        Size(DeviceSize.myWidth(322), DeviceSize.myHeight(120)),
                    painter: TrianglePainter(
                        color: MyTheme.primary, corner: Corner.TOP_RIGHT),
                  ),
                ],
              ),
              Image.asset(
                MyAssets.imagePath + MyImages.appLogo,
                width: DeviceSize.myWidth(180),
              ),
              Text(
                "تسجيل الدخول",
                style: theme.textTheme.headlineMedium,
              ),
              Container(
                height: DeviceSize.myHeight(192),
                margin:
                    EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(25)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "رقم الجوال",
                        style: theme.textTheme.headlineMedium,
                      ),
                      MyTextFormField(
                        controller: _phone,
                        keyBoardType: TextInputType.phone,
                        icon: Icons.phone_outlined,
                        validator: (val) =>
                            val!.isEmpty ? "الرجاء ملئ رقم الجوال" : null,
                      ),
                      Text(
                        "كلمة السر",
                        style: theme.textTheme.headlineMedium,
                      ),
                      MyTextFormField(
                        controller: _password,
                        obscureText: true,
                        icon: Icons.password_outlined,
                        validator: (val) =>
                            val!.isEmpty ? "الرجاء ملئ كلمة المرور" : null,
                      ),
                    ],
                  ),
                ),
              ),
              MyButton(
                label: "تسجيل الدخول",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .login(context, _phone.text, _password.text);
                  }
                },
              ),
              Text(
                "لا تملك حساب ؟",
                style: TextStyle(fontSize: getResponsiveFontSize(context, 15)),
              ),
              MyButton(
                  label: "سجل هنا",
                  onPressed: () =>
                      Navigator.pushNamed(context, SignUpScreen.routeName)),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CustomPaint(
                    size: Size(DeviceSize.width + 36, DeviceSize.myHeight(150)),
                    painter: TrianglePainter(
                        color: MyTheme.scondery, corner: Corner.BOTTOM_LEFT),
                  ),
                  CustomPaint(
                    size: Size(DeviceSize.width, DeviceSize.myHeight(133)),
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
