import 'package:flutter/material.dart';
import 'package:take_ama/models/Order.dart';
import 'package:take_ama/models/UserLogin.dart';
import 'package:take_ama/pages/careTaker/myOrderDetail.dart';
import 'package:take_ama/services/OrderAPI.dart';
import 'package:take_ama/utils/storageLocal.dart';
import 'package:take_ama/utils/validatefield.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class CaretakerDetailPage extends StatefulWidget {
  const CaretakerDetailPage({Key? key}) : super(key: key);

  @override
  State<CaretakerDetailPage> createState() => _CaretakerDetailPageState();
}

class _CaretakerDetailPageState extends State<CaretakerDetailPage> {
  var txtAmount = TextEditingController();
  var txtHours = TextEditingController();
  OrderDetail orderDetail = OrderDetail();
  String location = 'Null, Press Button';
  String Address = 'search';

  @override
  Widget build(BuildContext context) {
    Profile profile = ModalRoute.of(context)!.settings.arguments as Profile;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareTaker'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Name: ${profile.firstName} ${profile.lastName}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(profile.detail ?? ''),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: txtHours,
              onChanged: (String? v) {
                v = v ?? "";
                if (int.tryParse(v) != null) {
                  double amount = double.parse(v) * 300;
                  txtAmount.text = '$amount';
                }
                if (v == '') {
                  txtAmount.text = '0';
                }
                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "จำนวนชั่วโมง",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: txtAmount,
              readOnly: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  String? validateString =
                      ValidateField.validateNumber(txtAmount.text);
                  print('$validateString ${txtAmount.text}');
                  if (validateString == null) {
                    orderDetail.amaName = globalProfile!.firstName!;
                    orderDetail.price = txtAmount.text;
                    orderDetail.hours = txtHours.text;
                    orderDetail.careTaker = profile.id;
                    orderDetail.id = globalProfile!.id;
                    onSelectLocation();
                  }
                },
                child: const Text("Confirm"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onSelectLocation() async {
    try {
      Position _position = await _getGeoLocationPosition();
      final result = await Navigator.pushNamed(context, '/selectlocation',
          arguments: _position);

      LatLng position_selected = result as LatLng;
      orderDetail.amaLat =
          double.parse(position_selected.latitude.toStringAsFixed(8));
      orderDetail.amaLong =
          double.parse(position_selected.longitude.toStringAsFixed(8));
      createOrder();
      Navigator.pop(context);
    } catch (error) {
      print(error);
    }
  }

  void createOrder() async {
    await OrderAPI.create(orderDetail, globalProfile!.id!);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
