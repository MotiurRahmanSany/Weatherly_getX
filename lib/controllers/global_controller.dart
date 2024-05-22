import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:weatherly/api/fetch_weather.dart';
import 'package:weatherly/models/weather_data.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;
  WeatherData getData() => weatherData.value;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // return if service is not enabled

    if (!isServiceEnabled) return Future.error('Location not enabled');

    // status of persmission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permission are denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }

    // getting the current position
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // _latitude.value = position.latitude;
    // _longitude.value = position.longitude;
    // _isLoading.value = false;

    // return position;

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //  update our latitude and longitude
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;

      return FetchWeatherAPI()
          .processData(_latitude.value, _longitude.value)
          .then((value) {
        _isLoading.value = false;
        weatherData.value = value;
      });
    });
  }

  RxInt getIndex() => _currentIndex;
}
