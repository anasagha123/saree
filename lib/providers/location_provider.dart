// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:saree/network/local/local_db.dart';
import 'package:saree/network/local/my_shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  List<LocationModel> locations = [];
  LatLng currentPosition = const LatLng(0, 0);
  int? selectedLocationID;
  LocationModel? selectedLocation;

  bool serviceEnabled = false;
  LocationPermission permission = LocationPermission.denied;
  bool islocading = true;

  LocationProvider() {
    init();
  }

  Future<void> init() async {
    getSavedLocationId();
    getLocationsFromLocalDB();
  }

  Future<void> getLocationsFromLocalDB() async {
    var locationsJson = await MyDatabase.selectRow(LocationsTable.tableName);
    locations.clear();
    for (var locationJson in locationsJson) {
      var location = LocationModel.fromJson(locationJson);
      locations.add(location);
      if (selectedLocationID == location.id) {
        selectedLocation = location;
      }
    }
    notifyListeners();
  }

  Future<void> addLocationToLocalDB(LocationModel location) async {
    MyDatabase.insertRow(
      LocationsTable.tableName,
      location.toJson(),
    );
    saveLocationId(location);
  }

  Future<void> removeLocationFromLocalDB(LocationModel location) async {
    if (selectedLocationID == location.id) {
      selectedLocationID = null;
      selectedLocation = null;
      SharedPreferencesHelper.instance
          .remove(SharedPreferencesKeys.SELECTED_LOCATION_ID);
    }
    MyDatabase.deleteRow(LocationsTable.tableName,
        where: "id == ${location.id}");
    await getLocationsFromLocalDB();
  }

  Future<LatLng?> determinePosition() async {
    islocading = true;
    notifyListeners();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    var position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
    );
    currentPosition = LatLng(position.latitude, position.longitude);
    islocading = false;
    notifyListeners();
    return currentPosition;
  }

  Future<void> selectLocation(LocationModel location) async {
    selectedLocationID = location.id;
    selectedLocation = location;
    await saveLocationId(location);
    notifyListeners();
  }

  Future<bool> saveLocationId(LocationModel location) async {
    return await SharedPreferencesHelper.instance
        .setInt(SharedPreferencesKeys.SELECTED_LOCATION_ID, location.id);
  }

  void getSavedLocationId() {
    selectedLocationID = SharedPreferencesHelper.instance
        .getInt(SharedPreferencesKeys.SELECTED_LOCATION_ID);
  }

  void changeCurrentPosition(TapPosition tapPosition, LatLng position) {
    currentPosition = position;
    notifyListeners();
  }
}

class LocationModel {
  final int id;
  final String name;
  final String details;
  final String street_name;
  final String building_number;
  final String floor_number;
  final String apartment_number;
  final String nearby_location;
  final double longitude;
  final double latitude;

  LocationModel({
    required this.id,
    required this.name,
    required this.details,
    required this.street_name,
    required this.building_number,
    required this.floor_number,
    required this.apartment_number,
    required this.nearby_location,
    required this.longitude,
    required this.latitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      name: json["name"],
      details: json["details"],
      street_name: json["streetName"],
      building_number: json["buildingNumber"],
      floor_number: json["floorNumber"],
      apartment_number: json["apartmentNumber"],
      nearby_location: json["neerbyLocation"],
      longitude: json["longitude"],
      latitude: json["latitude"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "details": details,
      "streetName": street_name,
      "buildingNumber": building_number,
      "floorNumber": floor_number,
      "apartmentNumber": apartment_number,
      "neerbyLocation": nearby_location,
      "longitude": longitude,
      "latitude": latitude,
    };
  }
}
