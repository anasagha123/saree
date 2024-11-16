import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../providers/location_provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LocationProvider>(context, listen: false).determinePosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, widget) {
        return provider.islocading
            ? const Center(child: CircularProgressIndicator())
            : FlutterMap(
                options: MapOptions(
                  onTap: provider.changeCurrentPosition,
                  initialCenter: provider.currentPosition,
                  initialZoom: 16.0,
                  interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
                ),
                children: [
                  TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: provider.currentPosition,
                        child: const Icon(Icons.add_circle_outline_rounded,
                            color: Colors.black, size: 40),
                      ),
                    ],
                  ),
                ],
              );
      },
    );
  }
}
