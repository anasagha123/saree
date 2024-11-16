import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/widgets/components/my_button.dart';

import '../../providers/location_provider.dart';

class SubmitAddingLocationDialog extends StatelessWidget {
  final String name;
  final String details;
  final String streetName;
  final String buildingNumber;
  final String floorNumber;
  final String apartmentNumber;
  final String nearbyLocation;
  final PageController pageController;

  const SubmitAddingLocationDialog({
    required this.pageController,
    required this.name,
    required this.details,
    required this.streetName,
    required this.buildingNumber,
    required this.floorNumber,
    required this.apartmentNumber,
    required this.nearbyLocation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("هل انت متأكد من اضافة الموقع؟"),
            SizedBox(height: DeviceSize.myHeight(24)),
            MyButton(
              label: "نعم",
              onPressed: () {
                Provider.of<LocationProvider>(context, listen: false)
                    .addLocationToLocalDB(
                  LocationModel(
                    id: -1,
                    name: name,
                    details: details,
                    street_name: streetName,
                    building_number: buildingNumber,
                    floor_number: floorNumber,
                    apartment_number: apartmentNumber,
                    nearby_location: nearbyLocation,
                    longitude:
                        Provider.of<LocationProvider>(context, listen: false)
                            .currentPosition
                            .longitude,
                    latitude:
                        Provider.of<LocationProvider>(context, listen: false)
                            .currentPosition
                            .latitude,
                  ),
                )
                    .then(
                  (val) {
                    Navigator.pop(context);
                    pageController.previousPage(
                      duration: Durations.medium2,
                      curve: Curves.easeInOutCubic,
                    );
                  },
                );
              },
            ),
            SizedBox(height: DeviceSize.myHeight(12)),
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
