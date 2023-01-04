import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/bloc/current_weather/current_weather_bloc.dart';
import 'package:weather/bloc/location/location_bloc.dart';
import 'package:weather/data/data/data_provider/remote_data_provider.dart';
import 'package:weather/data/data/repository/remote_data_repository.dart';
import 'package:weather/ui/widgets/custom_app_bar.dart';

import 'home_tab_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.position,
    required this.place,
  }) : super(key: key);

  final Position position;
  final Placemark place;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CurrentWeatherBloc currentWeatherBloc;

  @override
  void initState() {
    currentWeatherBloc = CurrentWeatherBloc(
      repository: RemoteDataRepository(
        remoteDataProvider: RemoteDataProvider(),
      ),
    );
    currentWeatherBloc.add(
      CurrentWeatherRequestedEvent(
        longitude: widget.position.longitude,
        latitude: widget.position.latitude,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.h,
          ),
          child: CustomAppBar(
            country: widget.place.country.toString(),
            city: widget.place.subLocality.toString(),
          ),
        ),
        body: BlocProvider(
          create: (context) => currentWeatherBloc,
          child: HomeTabView(),
        ),
      ),
    );
  }
}
