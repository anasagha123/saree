import 'package:flutter/material.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/widgets/components/my_button.dart';

class AddALocationDialog extends StatelessWidget {
  const AddALocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            const Text("يحب عليك اضافة موقع وتحديد اولا"),
            SizedBox(height: DeviceSize.myHeight(16)),
            MyButton(
              label: "حسنا",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
