import 'package:flutter/material.dart';

import '../widgets/components/map_widget.dart';

class SelectLocationFromMapScreen extends StatelessWidget {
  static const routeName = "/select-location-from-map";

  const SelectLocationFromMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرجاء اختيار الموقع"),
        centerTitle: true,
      ),
      body: const MapWidget(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: const Text("تأكيد المقع"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
