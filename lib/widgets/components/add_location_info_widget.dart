import 'package:flutter/material.dart';
import 'package:saree/config/responsive_font.dart';
import 'package:saree/widgets/dialogs/submit_adding_location_dialog.dart';

import '../../config/device_size.dart';
import '../../config/theme.dart';
import '../../screens/select_location_from_map_screen.dart';
import 'map_widget.dart';

class AddLocationInfo extends StatefulWidget {
  final PageController pageController;

  const AddLocationInfo(this.pageController, {super.key});

  @override
  State<AddLocationInfo> createState() => _AddLocationInfoState();
}

class _AddLocationInfoState extends State<AddLocationInfo> {
  final _name = TextEditingController();
  final _details = TextEditingController();
  final _streetName = TextEditingController();
  final _buildingNumber = TextEditingController();
  final _floorNumber = TextEditingController();
  final _apartmentNumber = TextEditingController();
  final _nearbyLocation = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, val2) {
        widget.pageController
            .previousPage(duration: Durations.medium1, curve: Curves.linear);
      },
      child: ListView(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => widget.pageController.previousPage(
                  duration: Durations.medium2,
                  curve: Curves.easeInOutCubic,
                ),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Text("معلومات العنوان"),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Container(
            height: DeviceSize.myHeight(160),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                const MapWidget(),
                Align(
                  alignment: const Alignment(-0.9, -0.9),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, SelectLocationFromMapScreen.routeName),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: getResponsiveFontSize(context, 28),
                          ),
                          Text(
                            "تعديل",
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: DeviceSize.myHeight(16)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  decoration: inputDecoration(hint: "البلد"),
                  validator: (val) => val!.isEmpty ? "يجب ملئ الحقل" : null,
                ),
                SizedBox(height: DeviceSize.myHeight(12)),
                TextFormField(
                  controller: _details,
                  decoration: inputDecoration(hint: "المحافظة او المدينة"),
                  validator: (val) => val!.isEmpty ? "يجب ملئ الحقل" : null,
                ),
                SizedBox(height: DeviceSize.myHeight(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: DeviceSize.myWidth(160),
                      child: TextFormField(
                        controller: _streetName,
                        decoration: inputDecoration(hint: "اسم الشارع"),
                      ),
                    ),
                    SizedBox(
                      width: DeviceSize.myWidth(160),
                      child: TextFormField(
                        controller: _buildingNumber,
                        decoration: inputDecoration(hint: "رقم البناية"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: DeviceSize.myHeight(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: DeviceSize.myWidth(160),
                      child: TextFormField(
                        controller: _floorNumber,
                        decoration: inputDecoration(hint: "رقم الطابق"),
                      ),
                    ),
                    SizedBox(
                      width: DeviceSize.myWidth(160),
                      child: TextFormField(
                        controller: _apartmentNumber,
                        decoration: inputDecoration(hint: "رقم الشقة"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: DeviceSize.myHeight(12)),
                TextFormField(
                  controller: _nearbyLocation,
                  decoration: inputDecoration(hint: "اقرب نقطة دالة"),
                ),
              ],
            ),
          ),
          SizedBox(height: DeviceSize.myHeight(16)),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (_) => SubmitAddingLocationDialog(
                    pageController: widget.pageController,
                    name: _name.text,
                    details: _details.text,
                    apartmentNumber: _apartmentNumber.text,
                    floorNumber: _floorNumber.text,
                    buildingNumber: _buildingNumber.text,
                    nearbyLocation: _nearbyLocation.text,
                    streetName: _streetName.text,
                  ),
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: MyTheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "تأكيد العنوان",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration({required String hint}) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.primary),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      );
}
