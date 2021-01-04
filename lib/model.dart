import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngData {
  LatLngData({
    this.lat,
    this.long,
    this.taskName,
    this.price,
  });

  final double lat;
  final double long;
  final String taskName;
  final int price;


}

List<LatLngData> mapData = [

  LatLngData(
    lat: 20.98209723478262,
    long: 105.79148601312042,
    taskName: 'Ngoi choi xoi nuoc',
    price: 500000
  ),

  LatLngData(
      lat: 20.98377013656643,
      long: 105.79143236893896,
      taskName: 'Khong lam gi ca',
      price: 100000
  ),

  LatLngData(
      lat: 20.984932141151162,
      long: 105.79283784649466,
      taskName: 'Dev',
      price: 100000
  ),

  LatLngData(
      lat: 20.984401226384776,
      long: 105.79319189809269,
      taskName: 'Dev',
      price: 100000
  ),

  LatLngData(
      lat: 20.984872037687417,
      long: 105.792848575331,
      taskName: 'Doan xemmm',
      price: 300000
  ),


];