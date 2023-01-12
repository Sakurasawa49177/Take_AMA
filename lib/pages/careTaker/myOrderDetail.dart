import 'package:flutter/material.dart';
import 'package:take_ama/models/Order.dart';
import 'package:take_ama/services/OrderAPI.dart';
import 'package:take_ama/utils/storageLocal.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';

class MyOrderDetail extends StatefulWidget {
  const MyOrderDetail({Key? key}) : super(key: key);

  @override
  State<MyOrderDetail> createState() => _MyOrderDetailState();
}

class _MyOrderDetailState extends State<MyOrderDetail>
    with TickerProviderStateMixin {
  late final MapController _mapController;
  OrderDetail? order;
  Position? _carePosition;

  Placemark? care_place;
  Placemark? ama_place;

  String Address_Care = '';
  String Address_Ama = '';

  List<Marker> markers = [];

  @override
  void initState() {
    // TODO: implement initState
    _mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status')),
      body: FutureBuilder(
        future: onGetOrderDetails(),
        builder: (
          BuildContext context,
          AsyncSnapshot<OrderDetail?> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Visibility(
                        visible: order!.orderStatus == 'pending' &&
                            globalProfile!.userType == '2',
                        child: ElevatedButton(
                          child: const Text('Accept'),
                          onPressed: () {
                            updateStatus("1", order!.id!);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: const Text('Reject'),
                        onPressed: () {
                          updateStatus("9", order!.id!);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: const Text('Complete'),
                        onPressed: () {
                          updateStatus("2", order!.id!);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                FutureBuilder(
                  future: initMap(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<LatLng?> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return OnsetMap();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: Colors.blue,
                              semanticsLabel: 'Loading...',
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              semanticsLabel: 'Loading...',
            ),
          );
        },
      ),
    );
  }

  Future<OrderDetail?> onGetOrderDetails() async {
    order = await ModalRoute.of(context)!.settings.arguments as OrderDetail;
    return order;
  }

  Future<LatLng?> initMap() async {
    _carePosition = await _getGeoLocationPosition();
    List<Placemark> care_placemarks = await placemarkFromCoordinates(
      _carePosition!.latitude,
      _carePosition!.longitude,
    );
    List<Placemark> ama_placemarks = await placemarkFromCoordinates(
      order!.amaLat!,
      order!.amaLong!,
    );
    care_place = care_placemarks[0];
    ama_place = ama_placemarks[0];
    LatLng? care_LatLng = LatLng(
      _carePosition!.latitude,
      _carePosition!.longitude,
    );
    return care_LatLng;
  }

  Widget OnsetMap() {
    Address_Care =
        '${care_place?.street}, ${care_place?.subLocality}, ${care_place?.locality}, ${care_place?.postalCode}, ${care_place?.country}';
    Address_Ama =
        '${ama_place?.street}, ${ama_place?.subLocality}, ${ama_place?.locality}, ${ama_place?.postalCode}, ${ama_place?.country}';

    print(Address_Care);
    LatLng? care_LatLng = LatLng(
      _carePosition!.latitude,
      _carePosition!.longitude,
    );
    LatLng? ama_LatLng = LatLng(
      order!.amaLat!,
      order!.amaLong!,
    );
    Marker care_Marker = Marker(
      height: 50,
      point: care_LatLng,
      builder: (ctx) => Container(
        child: const Icon(
          size: 50,
          Icons.location_pin,
          color: Colors.blue,
        ),
      ),
    );
    Marker ama_Marker = Marker(
      height: 50,
      point: ama_LatLng,
      builder: (ctx) => const Icon(
        size: 50,
        Icons.location_pin,
        color: Colors.green,
      ),
    );
    markers.add(care_Marker);
    markers.add(ama_Marker);

    return Container(
        height: 600,
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: ama_LatLng,
                  zoom: 15.2,
                  maxZoom: 15.2,
                  minZoom: 3,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child:
                  Row(
                    children: [
                      Container(
                          width: 300,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Your Location : ${Address_Care}',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),)
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                  child:
              Row(
                children: [
                  Container(
                      width: 300,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Ama Location : ${Address_Ama}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),)
            ),
            ElevatedButton(
              onPressed: () {
                OnResetfitBounds();
              },
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 10,
                  bottom: 10,
                ),
                child: Icon(Icons.my_location),
              ),
            ),
          ],
        ));
  }

  void OnResetfitBounds() {
    final bounds = LatLngBounds();
    LatLng? care_LatLng = LatLng(
      _carePosition!.latitude,
      _carePosition!.longitude,
    );
    LatLng? ama_LatLng = LatLng(
      order!.amaLat!,
      order!.amaLong!,
    );

    bounds.extend(care_LatLng);
    bounds.extend(ama_LatLng);
    _mapController.fitBounds(
      bounds,
      options: const FitBoundsOptions(
        maxZoom: 16.2,
        padding: EdgeInsets.only(left: 5, right: 5),
      ),
    );
  }

  Future<Position?> _getGeoLocationPosition() async {
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

  updateStatus(String status, String orderId) async {
    await OrderAPI.update(orderId, status);
    Navigator.pop(context);
  }
}
