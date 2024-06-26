import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/controllers/global_controller.dart';
import 'package:weatherly/models/weather_data_hourly.dart';
import 'package:weatherly/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({
    super.key,
    required this.weatherDataHourly,
  });

  final RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text(
            'Today',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 20
            ? 20
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 90,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.dividerLine.withAlpha(150),
                        spreadRadius: 1,
                        blurRadius: 30,
                        offset: const Offset(0.5, 0),
                      ),
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(
                            colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor,
                            ],
                          )
                        : null),
                child: HourlyDetails(
                  index: index,
                  cardIndex: cardIndex.toInt(),
                  temp: weatherDataHourly.hourly[index].temp!,
                  timeStamp: weatherDataHourly.hourly[index].dt!,
                  weatherIcon:
                      weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final int temp;
  final int timeStamp;
  final String weatherIcon;
  final int index;
  final int cardIndex;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    return DateFormat('jm').format(time);
  }

  const HourlyDetails({
    super.key,
    required this.temp,
    required this.timeStamp,
    required this.weatherIcon,
    required this.index,
    required this.cardIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
              // fontWeight: cardIndex == index ? FontWeight.bold : null,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          height: 40,
          width: 40,
          child: Image.asset('assets/weather/$weatherIcon.png'),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Text(
            '$temp°',
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
              // fontWeight: cardIndex == index ? FontWeight.bold : null,
            ),
          ),
        ),
      ],
    );
  }
}
