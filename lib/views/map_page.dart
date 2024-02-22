import 'dart:async';
import 'dart:developer';

import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/views/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../constants.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomText.dart';

class MapPage extends StatefulWidget {
  MyUser user;
  MapPage({super.key,required this.user});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _initialPostion = LatLng(35.255000, 29.982050);
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  Location _locationController = Location();
  LatLng? _currentPostion ;
  LatLng? _markerPosition;
  final List<Marker> _markers = [];
  StreamSubscription<LocationData>? _locationSubscription;
  bool _isCameraMoving = false;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel(); // Cancel the location updates
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Shoppie",
            style: GoogleFonts.sarina(
                textStyle: TextStyle(
                    color: AppTitleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 34.sp)),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,automaticallyImplyLeading: false,
      ),
      body: _currentPostion==null?Center(child: CircularProgressIndicator()):Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller){_mapController.complete(controller);
            final marker = Marker(
              markerId: MarkerId('0'),
              position: LatLng(
                  _initialPostion.latitude, _initialPostion.longitude),
            );

            _markers.add(marker);}  ,
            initialCameraPosition:
                CameraPosition(target: _initialPostion, zoom: 12),
            markers: _markers.toSet()
            // {
            //   Marker(
            //       markerId: MarkerId("test"),
            //       icon: BitmapDescriptor.defaultMarker,
            //       position: _initialPostion),
            //   if (!_isCameraMoving && _markerPosition != null)
            //     Marker(
            //       markerId: MarkerId("currentLocation"),
            //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            //       position: _markerPosition!,
            //     ),
            // },
            ,onCameraMove: (CameraPosition position) {
              setState(() {
                _isCameraMoving = true;
                _markers.first =
                    _markers.first.copyWith(positionParam: position.target,iconParam: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
              });
            },
            onCameraIdle: () {
              setState(() {
                _isCameraMoving = false;

              });
            },myLocationEnabled: true,myLocationButtonEnabled: true,

          ),
          if (_currentPostion != null)
            Positioned(
              top: 16,
              left: 16,
              child: _markers.isEmpty?Container(color: Colors.white,
                child: Text(
                  "Current Location: ${_currentPostion!.latitude.toStringAsFixed(4)}, ${_currentPostion!.longitude.toStringAsFixed(4)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ):Container(height: 40,width: 330,decoration: BoxDecoration(color: Colors.white.withOpacity(0.6),shape: BoxShape.rectangle),alignment: Alignment.center,
                child: Text(
                  "Current Location: ${_markers.first.position.latitude.toStringAsFixed(4)}, ${_markers.first.position.longitude.toStringAsFixed(4)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: SizedBox(
      height: 70,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        color: Colors.white,
        child: CustomButton(
          child: CustomText(
            text: "Confirm Location",
            size: 15,
            color: Colors.white,
            align: Alignment.center,
            fontfamily: "ReadexPro",
            fontWeight: FontWeight.w500,
          ),
          onpress: () {
            //todo close map stream when done
            if(_locationSubscription !=null){
              setState(() {
                _locationSubscription!.cancel();
                //_locationController.onLocationChanged.listen((event) { })
              });
              // Navigator.of(context, rootNavigator: true).push(
              //     MaterialPageRoute(builder: (context) =>  paymentPage(pos: _markers.first.position,user: widget.user,)));
              Navigator.pop(context,_markers.first.position);
            }
          },
          height: 50,
          borderColor: Colors.white,
          borderRadius: 10,
          color: primaryColor,

        ),
      ),
    ),
    );
  }
  Future<void> _cameraToPostion(LatLng pos)async{
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPostion = CameraPosition(target: pos,zoom: 17);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPostion));
  }
  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    log("entering get location updated");
    _serviceEnabled = await _locationController.serviceEnabled();
    log(_serviceEnabled.toString());
    if (!_serviceEnabled) {
      log("entering service enabled");
      _serviceEnabled = await _locationController.requestService();
    }
    _permissionGranted = await _locationController.hasPermission();
    log(_permissionGranted.toString());
    if (_permissionGranted == PermissionStatus.denied) {
      log("entering permission denied");
      _permissionGranted = await _locationController.requestPermission();

    }
    LocationData? initialLocation = await _locationController.getLocation();

    if (initialLocation != null) {
      setState(() {
        _currentPostion = LatLng(initialLocation.latitude!, initialLocation.longitude!);
        _markerPosition = _currentPostion;
        _cameraToPostion(_currentPostion!);
      });
    }
    _locationSubscription?.cancel(); // Cancel previous subscription if exists
    _locationSubscription =_locationController.onLocationChanged.listen((LocationData currentLocation) {
      if(currentLocation.latitude !=null && currentLocation.longitude != null){
        setState(() {
          _currentPostion= LatLng(currentLocation.latitude!, currentLocation.longitude!);
          //_cameraToPostion(_currentPostion!); //camera moves to the current postion
          if (!_isCameraMoving) {
            _markerPosition = _currentPostion;
          }
        });
      }
    });
  }

}

