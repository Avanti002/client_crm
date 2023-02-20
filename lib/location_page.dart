import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'dart:async';
import 'gloc.dart';

String currentposi = "";
String inlat = "";
String inlong = "";
String inaddress = "";
String inTime = "";
String inRunning = "";
String outlat = "";
String outlong = "";
String outaddress = "";
String outTime = "";
String outRunning = "";
DateTime now = DateTime.now();

enum Location { location1, location2 }

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool isPressed = false;
  String? _currentAddress;
  Position? _currentPosition;
  double differenceHours = 0;
  String timein =
      '${now.hour % 12}:${now.minute} ${now.hour < 12 ? 'AM' : 'PM'}';
  String timeout =
      '${now.hour % 12}:${now.minute} ${now.hour < 12 ? 'AM' : 'PM'}';
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  int _result = 0;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        Timer(const Duration(seconds: 5), () {
          setState(() {
            isPressed = false;
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
          Timer(const Duration(seconds: 5), () {
            setState(() {
              isPressed = false;
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
        Timer(const Duration(seconds: 5), () {
          setState(() {
            isPressed = false;
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
      currentposi = _currentPosition.toString();
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

  void _getHours() {
    int timeinMinutes =
        (now.hour % 12) * 60 + now.minute + (now.hour < 12 ? 0 : 720);
    int timeoutMinutes =
        (now.hour % 12) * 60 + now.minute + (now.hour < 12 ? 0 : 720);
    int differenceMinutes = timeoutMinutes - timeinMinutes;
    setState(() {
      differenceHours = differenceMinutes / 60.0;
    });
  }

  void _calculate() {
    int number1 = int.tryParse(_controller1.text) ?? 0;
    int number2 = int.tryParse(_controller2.text) ?? 0;

    setState(() {
      _result = number2 - number1;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller1.addListener(_calculate);
    _controller2.addListener(_calculate);
  
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(title: const Text("GeoLocation")),
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(children: [getInCurrentLoc()]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LAT: $inlat'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('LNG: $inlong'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('ADDRESS: $inaddress'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Time:$inTime'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _controller1,
                      decoration: const InputDecoration(
                        labelText: 'Enter your Meter Running',
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    )
                  ],
                )
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(children: [getOutCurrentLoc()]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LAT: ${outlat}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('LNG: ${outlong}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('ADDRESS: ${outaddress}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Time:$outTime'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _controller2,
                      decoration: const InputDecoration(
                        labelText: 'Enter your  Meter Running',
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    )
                  ],
                )
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total (kms): $_result km',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Total Work Hours (Hours): $differenceHours ',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ])));
  }

  Widget getInCurrentLoc() {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            _getCurrentPosition();
            Timer(const Duration(seconds: 5), () {
              setState(() {
                isPressed = true;
                inlat = _currentPosition!.latitude.toString();
                inlong = _currentPosition!.longitude.toString();
                inaddress = _currentAddress!;
                inTime = timein;
                inRunning = _controller1.text;
              });
              print(inlat);
              print(inlong);
              print(inaddress);
              print(inRunning);
            });
          },
          child: const Text('In'),
        ),
      ],
    );
  }

  Widget getOutCurrentLoc() {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            _getCurrentPosition();
            Timer(const Duration(seconds: 5), () {
              setState(() {
                isPressed = true;
                outlat = _currentPosition!.latitude.toString();
                outlong = _currentPosition!.longitude.toString();
                outaddress = _currentAddress!;
                outTime = timeout;
                outRunning = _controller2.text;
              });
              print(outlat);
              print(outlong);
              print(outaddress);
              print(outRunning);
            });
          },
          child: const Text('OUT'),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapSample()),
              );
              setState(() {
                isPressed = false;
              });
            },
            child: const Text('Get Map View'),
          ),
        ),
      ],
    );
  }
}
