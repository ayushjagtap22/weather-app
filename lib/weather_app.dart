import 'package:flutter/material.dart';
import 'package:weather/custom_material_color.dart';
import 'package:weather/ui/screens/splash/splash_screen.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        fontFamily: "OpenSans",
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: CustomMaterialColor.createMaterialColor(
          const Color(0xFF5D50FE),
        ),
      ),
    );
  }
}
