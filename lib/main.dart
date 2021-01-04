import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_app/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  double lat;
  double long;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            await getCurrentLocation();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapSample(
                lat: lat,
                long: long,
              )),
            );
          },
          child: Text(
            "Go to map"
          ),
        ),
      ),
    );
  }
  Future<void> getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((value) => {
      lat = value.latitude,
      long= value.longitude
    }
    );
  }
}

class MapSample extends StatefulWidget {
  final double lat;
  final double long;
  MapSample({this.lat,this.long});
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  @override
  void initState() {
    super.initState();
    for(int i=0; i<mapData.length; i++){
      marker.add(Marker(
          markerId: MarkerId(mapData[i].toString()),
          position: LatLng(
            mapData[i].lat,
            mapData[i].long
          ),
          infoWindow: InfoWindow(
            title: mapData[i].taskName,
            snippet: mapData[i].price.toString(),
          ),
          icon: BitmapDescriptor.defaultMarker
      ),
      );
    }
  }
  MapType _currentMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.980761271662498, 105.78793078428409),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(20.980761271662498, 105.78793078428409),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
  );
  static const LatLng _center = const LatLng(20.980761271662498, 105.78793078428409);
  final Set<Marker> marker = {};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Google map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.long),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: marker,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget> [
                  FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.map, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: InkWell(
                      onTap: (){
                        goToCurrentLocation();
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.adjust, color: Colors.white, size: 35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]
      ),
    );
  }

  Future<void> goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    await Geolocator.getCurrentPosition().then((value) => {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            //tilt: 59.440717697143555,
            zoom: 19.151926040649414
        ),
      )),
    });
  }
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.hybrid
          : MapType.normal;
    });
  }

}