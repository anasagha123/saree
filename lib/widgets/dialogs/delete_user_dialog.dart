import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/providers/auth_provider.dart';
import 'package:saree/widgets/components/my_button.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Consumer<AuthProvider>(
        builder: (_,provider, widget) => Column(
          children: [
            const Text("هل انت متأكد من حذف الحساب؟"),
            MyButton(label: "نعم", onPressed: () async {
              await provider.deleteUser(context);
            }),
            MyButton(label: "الغاء", onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
