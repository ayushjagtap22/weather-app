import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/bloc/location/location_bloc.dart';
import 'package:location/location.dart' as l;
import 'package:weather/ui/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late LocationBloc locationBloc;
  late Position position;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    l.Location location = l.Location();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await location.requestService();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
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
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    locationBloc = LocationBloc();
    locationBloc.add(LocationRequestedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final screenSize = Size(
      width,
      height,
    );
    ScreenUtil.init(
      BoxConstraints(
        maxHeight: height,
        maxWidth: width,
      ),
      designSize: const Size(414, 896),
      context: context,
    );
    return BlocProvider(
      create: (context) => locationBloc,
      child: Scaffold(
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationFetchState) {
              return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF5D50FE),
                          Color(0xFF8572FC),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: SvgPicture.asset(
                      "assets/svgs/onboarding.svg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () async {
                        locationBloc.add(LocationRequestedEvent());
                        final List<Placemark> p =
                            await placemarkFromCoordinates(
                          state.position.latitude,
                          state.position.longitude,
                        );
                        final place = p.first;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              position: state.position,
                              place: place,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 59.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 30),
                        alignment: Alignment.center,
                        child: Text(
                          "EXPLORE",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return Center();
          },
        ),
      ),
    );
  }
}
