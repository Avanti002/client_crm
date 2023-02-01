import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'dart:async';
import 'gloc.dart';

String currentposi="";

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool isPressed = false;
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        Timer(Duration(seconds: 5), () { 
                  setState(() {
                    isPressed=false;    
                  });
                  });  
      }); 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
        Timer(Duration(seconds: 5), () { 
                  setState(() {
                    isPressed=false;    
                  });
                  }); 
      }); 
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        Timer(Duration(seconds: 5), () { 
                  setState(() {
                    isPressed=false;    
                  });
                  });
      }); 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    setState(() {
      currentposi=_currentPosition.toString();
    }); 
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
      appBar: AppBar(title: const Text("GeoLocation")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              const SizedBox(height: 32),
              isPressed == false ? getCurrentLoc() : getMapView(),
            ],
          ),
        ),
      ),
    );
  }
  Widget getCurrentLoc() {
    return Column(
      children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _getCurrentPosition();
                  Timer(Duration(seconds: 5), () { 
                  setState(() {
                    isPressed = true;      
                  });
                  });
              },
              child: Text('Get Current Location'),
            ),
          ],
        ); 
  }

  Widget getMapView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
               Navigator.push(context,MaterialPageRoute(builder: (context) => const MapSample()),);
              setState(() {
                isPressed = false;
              });
            },
            child: Text( 'Get Map View'),
          ),
        ),
      ],
    );
  }

}
