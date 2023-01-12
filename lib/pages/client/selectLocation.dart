import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../components/alertpopup.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation>
    with TickerProviderStateMixin {
  late final MapController _mapController;

  Marker? current;
  Position? _position_current;
  String AddressCurrent = '';
  String Address_Now = '';

  double? latitude_current;
  double? longitude_current;

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _mapController = MapController();
    super.initState();
  }

  Future<Position?> onGetCurrentLocation() async {
    _position_current =
        await ModalRoute.of(context)!.settings.arguments as Position;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _position_current!.latitude,
      _position_current!.longitude,
    );
    Placemark place = placemarks[0];
    AddressCurrent =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print(_position_current!.latitude);
    print(_position_current!.longitude);
    print(AddressCurrent);
    return _position_current;
  }

  Future<void> onSetFocusLocation(double lat, double long) async {
    latitude_current = lat;
    longitude_current = long;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude_current!,
      longitude_current!,
    );
    Placemark place = placemarks[0];
    Address_Now =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print(latitude_current);
    print(longitude_current);
    print(Address_Now);
    setState(() {});
  }

  void OnMoveCurrentLocation(LatLng destLocation, double destZoom) {
// Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Future<void> OnSubmit() async {
    bool? resultDialog = await AlertPopupReturnBool.showMyDialog(
        context, 'บันทึกรายการ', 'คุณต้องการบันทึกรายการหรือไม่ ?');
    if ((resultDialog!)) {
      LatLng LatLngItude = LatLng(
        latitude_current ?? _position_current!.latitude,
        longitude_current ?? _position_current!.longitude,
      );
      Navigator.pop(context, LatLngItude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Center(
          child: FutureBuilder(
        future: onGetCurrentLocation(),
        builder: (BuildContext context, AsyncSnapshot<Position?> snapshot,) {
          if (snapshot.hasData) {
            return Container(
                child: Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      onPositionChanged: (position, hasGesture) {
                        position.center;
                        hasGesture = true;
                      },
                      onTap: (tapPosition, point) {
                        onSetFocusLocation(point.latitude, point.longitude);
                      },
                      center: LatLng(
                        latitude_current ?? _position_current!.latitude,
                        longitude_current ?? _position_current!.longitude,
                      ),
                      zoom: 15.2,
                    ),
                    nonRotatedChildren: [
                      AttributionWidget.defaultWidget(
                        source: '',
                        onSourceTapped: () {},
                      ),
                    ],
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              latitude_current ?? _position_current!.latitude,
                              longitude_current ?? _position_current!.longitude,
                            ),
                            builder: (context) => const Icon(
                              size: 50,
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                            height: 50,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(Address_Now == '' ? AddressCurrent : Address_Now),
                ),
              ],
            ));
          }
          return Container();
        },
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Save Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.my_location,
              color: Colors.blue,
            ),
            label: 'My location',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          print(value);
          switch (value) {
            case 0:
              OnSubmit();
              break;
            case 1:
              OnMoveCurrentLocation(
                  LatLng(
                    _position_current!.latitude,
                    _position_current!.longitude,
                  ),
                  15.2);
              onSetFocusLocation(
                  _position_current!.latitude, _position_current!.longitude);
              break;
          }
        },
      ),
    );
  }
}
