import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/ui/theme/app_colors.dart';

class WeatherCardCollapsed extends StatelessWidget {
  const WeatherCardCollapsed({
    Key? key,
    required this.humidity,
    required this.weatherType,
    required this.temperature,
  }) : super(key: key);
  final String temperature;
  final String weatherType;
  final String humidity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.dodgerBlue,
        borderRadius: BorderRadius.circular(30.h),
      ),
      height: 335.h,
      width: 374.w,
      margin: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 20.w,
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Image.asset(
            "assets/pngs/weather_card_bg.png",
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${temperature.substring(0, 2)}°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 120.sp,
                    fontFamily: "Sans",
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  weatherType,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.sp,
                    fontFamily: "Sans",
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Humidity",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sans",
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "$humidity°",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.20),
                    fontSize: 23.sp,
                    fontFamily: "Sans",
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
          FractionalTranslation(
            translation: const Offset(1.45, 1.32),
            child: SvgPicture.asset(
              "assets/svgs/clouds.svg",
            ),
          ),
        ],
      ),
    );
  }
}
