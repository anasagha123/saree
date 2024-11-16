import 'package:flutter/material.dart';
import 'package:saree/config/device_size.dart';

class AddCurrentLocationDialog extends StatelessWidget {
  const AddCurrentLocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: DeviceSize.myHeight(300),
        alignment: Alignment.center,
        // child:
        // Consumer<LocationProvider>(
        //   builder: (ctx, provider, _) => provider.loading
        //       ? const CircularProgressIndicator()
        //       : Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             const Text("اتريد اضافة موقعك الحالي؟"),
        //             SizedBox(height: DeviceSize.myHeight(50)),
        //             MyButton(
        //                 label: "نعم",
        //                 onPressed: () async {
        //                   NavigatorState navigator = Navigator.of(context);
        //                   // await provider.determinePosition();
        //                   navigator.pop();
        //                 }),
        //             SizedBox(height: DeviceSize.myHeight(20)),
        //             MyButton(
        //               label: "لا",
        //               onPressed: () => Navigation.pop(context),
        //             ),
        //           ],
        //         ),
        // ),
      ),
    );
  }
}
