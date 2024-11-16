import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/config/theme.dart';
import 'package:saree/providers/auth_provider.dart';
import 'package:saree/providers/cart_provider.dart';
import 'package:saree/widgets/components/my_button.dart';
import 'package:saree/widgets/components/my_text_form_field.dart';

class SubmitUserInfoDialog extends StatefulWidget {
  const SubmitUserInfoDialog({super.key});

  @override
  State<SubmitUserInfoDialog> createState() => _SubmitUserInfoDialogState();
}

class _SubmitUserInfoDialogState extends State<SubmitUserInfoDialog> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _notes = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _name.text = Provider.of<AuthProvider>(context, listen: false).user!.name;
      _phone.text =
          Provider.of<AuthProvider>(context, listen: false).user!.phone;
      _address.text = Provider.of<AuthProvider>(context, listen: false)
          .user!
          .location
          .address;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<CartProvider>(
          builder: (_, provider, widget) {
            if (provider.orderState == OrderState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close)),
                const Text("الرجاء تأكيد معلوماتك الشخصية"),
                SizedBox(
                  height: DeviceSize.myHeight(20),
                ),
                Text(
                  "الاسم",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                MyTextFormField(controller: _name, icon: Icons.person_outline),
                SizedBox(
                  height: DeviceSize.myHeight(12),
                ),
                Text(
                  "رقم الجوال",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                MyTextFormField(controller: _phone, icon: Icons.phone_outlined),
                SizedBox(
                  height: DeviceSize.myHeight(12),
                ),
                Text(
                  "العنوان",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                MyTextFormField(
                    controller: _address, icon: Icons.location_on_outlined),
                SizedBox(
                  height: DeviceSize.myHeight(12),
                ),
                Text(
                  "الملاحظات",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextField(
                  controller: _notes,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: MyTheme.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: MyTheme.primary),
                        borderRadius: BorderRadius.circular(16)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: MyTheme.primary),
                    ),
                  ),
                ),
                SizedBox(
                  height: DeviceSize.myHeight(20),
                ),
                Center(
                  child: MyButton(
                    label: "تأكيد",
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addOrder(context, _name.text, _phone.text,
                              _address.text, _notes.text);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
