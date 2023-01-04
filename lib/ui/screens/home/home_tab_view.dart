import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather/bloc/current_weather/current_weather_bloc.dart';
import 'package:weather/ui/theme/app_colors.dart';

import 'widgets/upcoming_weather_card.dart';
import 'widgets/weather_card_collapsed.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  // late PageController pageController;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    // pageController = PageController(viewportFraction: 0.5);
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        if (state is CurrentWeatherLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CurrentWeatherReceivedState) {
          return Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: TabBar(
                  controller: controller,
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: AppColors.textColor,
                  labelColor: const Color(0xFF5D50FE),
                  indicatorColor: Colors.red,
                  labelStyle: TextStyle(
                    // backgroundColor: const Color(0x1AADA7FE),
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  indicator: const BoxDecoration(color: Colors.white),
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  tabs: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.w,
                        horizontal: 15.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: selectedIndex == 0
                            ? const Color(0x1AADA7FE)
                            : Colors.white,
                      ),
                      child: const Text(
                        "Today",
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.w,
                        horizontal: 15.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: selectedIndex == 1
                            ? const Color(0x1AADA7FE)
                            : Colors.white,
                      ),
                      child: const Text(
                        "Tomorrow",
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.w,
                        horizontal: 15.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: selectedIndex == 2
                            ? const Color(0x1AADA7FE)
                            : Colors.white,
                      ),
                      child: const Text(
                        "Next Week",
                      ),
                    ),
                  ],
                ),
              ),
              WeatherCardCollapsed(
                temperature: state.currentWeather.current!.temp.toString(),
                humidity: state.currentWeather.current!.humidity.toString(),
                weatherType: state.currentWeather.current!.weather!.first.main
                    .toString(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Next 7 Days",
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Expanded(
                // height: 240.h,
                // width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.currentWeather.daily!.length,
                  padding: EdgeInsets.only(left: 20.w),
                  itemBuilder: (context, index) {
                    return UpcomingWeatherCard(
                      data: state.currentWeather.daily![index],
                      index: index + 1,
                    );
                  },
                  // shrinkWrap: true,
                ),
              ),
              // SmoothPageIndicator(controller: controller, count: count)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 170.w,
                  vertical: 20.h,
                ),
                child: TabBar(
                  controller: controller,
                  indicator: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  tabs: [
                    Container(
                      height: 13.w,
                      decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? AppColors.dodgerBlue
                            : Color(0xFFE7E4FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      height: 13.w,
                      decoration: BoxDecoration(
                        color: selectedIndex == 1
                            ? AppColors.dodgerBlue
                            : Color(0xFFE7E4FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      height: 13.w,
                      decoration: BoxDecoration(
                        color: selectedIndex == 2
                            ? AppColors.dodgerBlue
                            : Color(0xFFE7E4FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text(
              "Something went wrong!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
      },
    );
  }
}
