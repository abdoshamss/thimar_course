import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thimar_course/screens/add_address/cubit.dart';

class AddAddressesScreen extends StatefulWidget {
  const AddAddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressesScreen> createState() => _AddAddressesScreenState();
}

class _AddAddressesScreenState extends State<AddAddressesScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(31.0465221, 31.3920076),
    zoom: 16,
  );
  final CameraPosition _kLake = const CameraPosition(
      target: LatLng(31.2676905, 32.3006332), zoom: 15.151926040649414);
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: Builder(builder: (context) {
        CounterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: GoogleMap(
            mapType: MapType.normal,
            markers: markers,
            onTap: (location) {
              print(location.latitude);
              print(location.longitude);
              markers.add(
                Marker(
                  markerId: const MarkerId("1"),
                  position: LatLng(
                    location.latitude,
                    location.longitude,
                  ),
                ),
              );
              setState(() {});
            },
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          // floatingActionButton: FloatingActionButton.extended(
          //   onPressed: _goToTheLake,
          //   label: const Text('To the lake!'),
          //   icon: const Icon(Icons.directions_boat),
          // ),
        );
      }),
    );
  }
}
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
//
//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }
// }

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     FloatingActionButton(
//       onPressed: () {
//         cubit.plus();
//       },
//       child: const Icon(Icons.add),
//     ),
//     Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: BlocBuilder<CounterCubit, CounterStates>(
//         builder: (context, state) => Text(
//           "${cubit.count}",
//           style: const TextStyle(
//             fontSize: 35,
//           ),
//         ),
//       ),
//     ),
//     FloatingActionButton(
//       onPressed: () {
//         cubit.minus();
//       },
//       child: const Icon(Icons.remove),
//     ),
//   ],
// ),
