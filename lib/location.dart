import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  final Color mycolor = Color.fromRGBO(128, 178, 247, 1);

  String coordinates = "No Location found";
  String adress = "No Adress found";
  bool scanning = false;

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    print(serviceEnabled);

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();

    print(permission);

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Request denied!");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "denied forever"!);
      return;
    }

    getLocation();
  }

  getLocation() async {
    setState(() {
      scanning = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      coordinates =
          'Latitude: ${position.latitude} \nLongitude : ${position.longitude}';

      List<Placemark> result =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (result.isNotEmpty) {
        adress =
            '${result[0].name},${result[0].locality} ${result[0].administrativeArea}';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "${e.toString()}");
    }

    setState(() {
      scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(
          "Your Location",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 40),
            child: Icon(
              Icons.location_on,
              size: 150,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Current Coordinates',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          scanning
              ? SpinKitThreeBounce(
                  color: mycolor,
                  size: 20,
                )
              : Text(
                  '${coordinates}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
          SizedBox(
            height: 10,
          ),
          Text(
            'current Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          scanning
              ? SpinKitThreeBounce(
                  color: mycolor,
                  size: 20,
                )
              : Text(
                  '${adress}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
          Spacer(),
          Center(
            child: ElevatedButton.icon(
                onPressed: () {
                  checkPermission();
                },
                icon: Icon(
                  Icons.location_pin,
                  color: Colors.blue,
                ),
                label: Text(
                  'Current Location',
                  style: TextStyle(color: Colors.blue),
                )),
          )
        ],
      ),
    );
  }
}
