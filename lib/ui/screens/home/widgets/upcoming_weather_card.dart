import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/common/constants.dart';
import 'package:weather/data/models/one_call_model.dart';
import 'package:weather/ui/theme/app_colors.dart';

class UpcomingWeatherCard extends StatelessWidget {
  const UpcomingWeatherCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final Daily data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 230.h,
      width: 145.w,
      child: Stack(
        children: [
          Container(
            height: 220.h,
            width: 128.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: AppColors.next[index],
            ),
            child: Stack(
              children: [
                FractionalTranslation(
                  translation: const Offset(0, 0.86),
                  child: SvgPicture.asset(
                    "assets/svgs/cloud_lower.svg",
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(),
                      Text(
                        index == 1
                            ? "Monday"
                            : index == 2
                                ? "Tuesday"
                                : index == 3
                                    ? "Wednesday"
                                    : index == 4
                                        ? "Thursday"
                                        : index == 5
                                            ? "Friday"
                                            : index == 6
                                                ? "Saturday"
                                                : index == 7
                                                    ? "Sunday"
                                                    : "Monday",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SvgPicture.asset(
                        data.weather!.first.main == "Clear"
                            ? "assets/svgs/sunny.svg"
                            : data.weather!.first.main == "Thunderstorm"
                                ? "assets/svgs/storm.svg"
                                : data.weather!.first.main == "Drizzle"
                                    ? "assets/svgs/rain.svg"
                                    : data.weather!.first.main == "Snow"
                                        ? "assets/svgs/rain.svg"
                                        : "assets/svgs/cloud_lower.svg",
                        height: 40.h,
                        width: 30.w,
                      ),
                      Text(
                        "${data.temp!.day} °",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data.temp!.morn}°",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.50),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Text(
                            "${data.temp!.eve}°",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
