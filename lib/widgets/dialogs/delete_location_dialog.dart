import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/providers/location_provider.dart';
import 'package:saree/widgets/components/my_button.dart';

class DeleteLocationDialog extends StatelessWidget {
  final LocationModel location;

  const DeleteLocationDialog(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: DeviceSize.myHeight(300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("هل انت متأكد من حذف الموقع؟؟"),
            SizedBox(height: DeviceSize.myHeight(50)),
            MyButton(
              label: "نعم",
              onPressed: () async {
                await Provider.of<LocationProvider>(context, listen: false)
                    .removeLocationFromLocalDB(location);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: DeviceSize.myHeight(20)),
            MyButton(
              label: "لا",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
