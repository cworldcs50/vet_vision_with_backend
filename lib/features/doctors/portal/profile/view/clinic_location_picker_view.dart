import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../doctor_portal_controller.dart';
import '../../custom_auth_button.dart';

class ClinicLocationPickerView extends StatefulWidget {
  const ClinicLocationPickerView({super.key});

  @override
  State<ClinicLocationPickerView> createState() =>
      _ClinicLocationPickerViewState();
}

class _ClinicLocationPickerViewState extends State<ClinicLocationPickerView> {
  final controller = Get.find<DoctorPortalController>();
  final Completer<GoogleMapController> mapControllerCompleter =
      Completer<GoogleMapController>();

  late double tempLat;
  late double tempLng;
  final List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    tempLat = controller.latitude.value;
    tempLng = controller.longitude.value;
    _updateMarker(LatLng(tempLat, tempLng));
  }

  void _updateMarker(LatLng latLng) {
    setState(() {
      tempLat = latLng.latitude;
      tempLng = latLng.longitude;
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId("selected_clinic"),
          position: latLng,
          infoWindow: const InfoWindow(title: "Selected Clinic Location"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pick Clinic Location",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.accent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(tempLat, tempLng),
                zoom: 15,
              ),
              onTap: _updateMarker,
              markers: markers.toSet(),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController ctrl) {
                mapControllerCompleter.complete(ctrl);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
            ),
            child: CustomAuthButton(
              onPressed: () {
                controller.latitude.value = tempLat;
                controller.longitude.value = tempLng;
                Get.back();
                Get.snackbar(
                  "Location Selected",
                  "Clinic coordinates updated successfully. Click 'Save Changes' to save.",
                  backgroundColor: Colors.teal,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              backgroundColor: AppColors.accent,
              child: const Text(
                "Confirm Location",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
