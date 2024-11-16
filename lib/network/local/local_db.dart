// ignore_for_file: constant_identifier_names

import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static late Database database;
  static late String databasesPath;

  static init() async {
    databasesPath = "${await getDatabasesPath()}/saree.db";
    database = await openDatabase(
      databasesPath,
      version: 1,
      onCreate: (db, version) {
        db.transaction((txn) {
          return txn.execute(
              "CREATE TABLE ${LocationsTable.tableName}(${LocationsTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,${LocationsTable.locationName} TINYTEXT,${LocationsTable.details} TEXT, ${LocationsTable.street_name} TINYTEXT,${LocationsTable.building_number} TINYTEXT, ${LocationsTable.floor_number} TINYTEXT, ${LocationsTable.apartment_number} TINYTEXT, ${LocationsTable.neerby_location} TINYTEXT,${LocationsTable.longitude} DOUBLE,${LocationsTable.latitude} DOUBLE)");
        });
      },
    );
  }

  static Future<int> insertRow(String table, Map<String, Object?> values) =>
      database.insert(table, values);

  static Future<int> updateRow(String table, Map<String, Object> values,
          {String? where}) =>
      database.update(table, values, where: where);

  static Future<int> deleteRow(String table, {String? where}) =>
      database.delete(table, where: where);

  static Future<List<Map<String, dynamic>>> selectRow(String table,
          {String where = ""}) =>
      database.rawQuery("SELECT * FROM $table $where");
}

class LocationsTable {
  static const tableName = "locations";

  static const id = "id";
  static const locationName = "name";
  static const details = "details";
  static const street_name = "streetName";
  static const building_number = "buildingNumber";
  static const floor_number = "floorNumber";
  static const apartment_number = "apartmentNumber";
  static const neerby_location = "neerbyLocation";
  static const longitude = "longitude";
  static const latitude = "latitude";
}
