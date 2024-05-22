import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherly/controllers/global_controller.dart';
import 'package:weatherly/utils/custom_colors.dart';
import 'package:weatherly/widgets/comfort_level.dart';
import 'package:weatherly/widgets/current_weather_widget.dart';
import 'package:weatherly/widgets/daily_data_forecast.dart';
import 'package:weatherly/widgets/header_widget.dart';
import 'package:weatherly/widgets/hourly_data_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // callj
    final globalController = Get.put(GlobalController(), permanent: true);
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/clouds.png',
                        width: 200,
                        height: 200,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(height: 20),
                      const HeaderWidget(),
                      // for our current temp ('current')
                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                      // for our hourly data ('hourly')
                      HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather(),
                      ),
                      // for our daily data ('daily')

                      DailyDataForecast(
                        weatherDataDaily:
                            globalController.getData().getDailyWeather(),
                      ),

                      Container(height: 1, color: CustomColors.dividerLine),
                      const SizedBox(
                        height: 10,
                      ),

                      // for our comfort level

                      ComfortLevel(
                          weatherDataCurrent:
                              globalController.getData().getCurrentWeather())
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
