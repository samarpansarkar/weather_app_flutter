import 'package:flutter/material.dart';
import 'package:weather_app_flutter/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/utils/custom_color.dart';
import 'package:weather_app_flutter/widgets/comfort_level.dart';
import 'package:weather_app_flutter/widgets/current_weather.dart';
import 'package:weather_app_flutter/widgets/header_widgets.dart';
import 'package:weather_app_flutter/widgets/hourly_weather.dart';

import '../widgets/daily_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.chekLoading().isTrue
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/clouds.png",
                      height: 200,
                      width: 200,
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
              )
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),
                    //for our current temp,
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          globalController.getData().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HourlyDataWidget(
                      weatherDataHourly:
                          globalController.getData().getHourlyWeather(),
                    ),
                    DailyDataWidget(
                      weatherDataDaily:
                          globalController.getData().getDailyWeather(),
                    ),
                    Container(
                      height: 2,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    ComfortLevel(
                      weatherDataCurrent:
                          globalController.getData().getCurrentWeather(),
                    )
                  ],
                ),
              )),
      ),
    );
  }
}
