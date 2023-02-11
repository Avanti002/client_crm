
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:quantbit_crm/location_page.dart' as posi;


String currposi=posi.currentposi;
var lat=double.parse(currposi.substring(10,19));
var longi=double.parse(currposi.substring(33));
final CameraPosition _kGoogle =  CameraPosition(
      target: LatLng(lat,longi),
    zoom: 18,
  );

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);
  
  @override
  _MapSampleState createState() => _MapSampleState();
}
  
class _MapSampleState extends State<MapSample> {
  
  Completer<GoogleMapController> _controller = Completer();
  
  Uint8List? marketimages;

  final List<Marker> _markers = <Marker>[];
    
  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  
  }
    
  @override
  void initState() {
    super.initState();
  }
  

  
    
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GMap"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          child: SafeArea(
            child: GoogleMap(
              initialCameraPosition: _kGoogle,
              markers: Set<Marker>.of(_markers),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
              },
            ),
          ),
        ),
      ),
    );
  }
 }