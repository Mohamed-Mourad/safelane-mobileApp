import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safelane/Shared/cubit/cubit.dart';
import 'package:safelane/Shared/cubit/states.dart';
import 'package:safelane/Shared/components/constants.dart';
import 'package:safelane/Shared/routes.dart';
import '../RouteDetailsScreens/routeBoxScreen.dart';
import 'menu.dart';
import 'widgetReuse.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with SingleTickerProviderStateMixin {
  Position? _currentPosition;
  bool _isLocationEnabled = true;
  bool _isPermissionGranted = true;
  GoogleMapController? mapController;

  late AnimationController animationController;
  late Animation<double> animation;
  bool isSearchExpanded = false;

  @override
  void initState() {
    super.initState();

    _checkLocationPermission();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _checkLocationPermission() async {
    final status = await Geolocator.checkPermission();
    setState(() {
      _isPermissionGranted = status == LocationPermission.always || status == LocationPermission.whileInUse;
    });

    if (!_isPermissionGranted) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Permission Required',
              style: TextStyle(fontFamily: "Poppins", color: SLNavy),
            ),
            content: Text('SafeLane requires permission to access your location'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _requestLocationPermission();
                },
                child: Text('Proceed'),
              ),
            ],
          );
        },
      );
    }

    if (_isPermissionGranted)
      _checkDeviceLocationService();
  }

  Future<void> _requestLocationPermission() async {
    final permissionStatus = await Geolocator.requestPermission();
    setState(() {
      _isPermissionGranted = permissionStatus == LocationPermission.always || permissionStatus == LocationPermission.whileInUse;
    });

    _checkDeviceLocationService();
  }

  Future<void> _checkDeviceLocationService() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Device location required',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            content: Text('Turn on device location'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _getCurrentLocation();
                },
                child: Text('Proceed'),
              ),
            ],
          );
        },
      );
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      await context.read<AppCubit>().addSource(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _isLocationEnabled = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is RouteDrawnState || state is AppInitialState) {
          setState(() {});
        }
      },
      builder: (context, state) {
        if (state is DestinationUpdatedState || state is RouteDrawnState) {
          return MaterialApp(
            routes: Routes.routes,
            home: Scaffold(
              body: Stack(
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_currentPosition != null && _isPermissionGranted && _isLocationEnabled)
                        Expanded(
                          child: GoogleMap(
                            polylines: context.read<AppCubit>().route.routes,
                            markers: context.read<AppCubit>().markers,
                            onMapCreated: (controller) {
                              mapController = controller;
                              // controller.animateCamera(
                              //   CameraUpdate.newCameraPosition(
                              //     CameraPosition(
                              //       target: context.read<AppCubit>().center,
                              //       zoom: 12.0,
                              //     ),
                              //   ),
                              // );
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                              ),
                              zoom: 9.0,
                            ),
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                          ),
                        ),
                    ],
                  ),

                  RouteBoxScreen(),

                  // CustomMenuButton(),
                  //
                  // CustomMapButton(
                  //   top: 30.0,
                  //   right: 70.0,
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/search');
                  //   },
                  //   icon: Icons.search,
                  // ),
                  //
                  // CustomMapButton(
                  //   top: 30.0,
                  //   right: 15.0,
                  //   onPressed: () {},
                  //   icon: Icons.filter_alt_outlined,
                  // ),
                ],
              ),
            ),
          );
        } else {
          return MaterialApp(
            routes: Routes.routes,
            home: Scaffold(
              body: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_currentPosition != null && _isPermissionGranted && _isLocationEnabled)
                        Expanded(
                          child: GoogleMap(
                            onMapCreated: (controller) {
                              mapController = controller;
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                              ),
                              zoom: 15.0,
                            ),
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                          ),
                        ),
                    ],
                  ),

                  CustomMenuButton(),

                  CustomMapButton(
                    top: 30.0,
                    right: 70.0,
                    onPressed: () {
                      // Navigator.pushNamed(context, '/search');
                      Navigator.popAndPushNamed(context, '/search');
                    },
                    icon: Icons.search,
                  ),

                  CustomMapButton(
                    top: 30.0,
                    right: 15.0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/filter');
                    },
                    icon: Icons.filter_alt_outlined,
                  ),

                  CustomMapButton(
                    right: 15.0,
                    bottom: 15.0,
                    onPressed: () {
                      if (mapController != null && _currentPosition != null) {
                        mapController!.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                              ),
                              zoom: 15.0,
                            ),
                          ),
                        );
                      }
                    },
                    icon: Icons.my_location,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
