import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/api/fetch_weather.dart';
import 'package:weather_app_flutter/model/weather/weather_data.dart';

class GlobalController extends GetxController {
  //Create various variables
  final RxBool _isLoading = true.obs;

  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  //instane for them tio be called
  RxBool chekLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;

  WeatherData getData() {
    return weatherData.value;
  }

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
    //return if servie is not enable
    if (!isServiceEnabled) {
      return Future.error("Location not enable!!");
    }

    //Status of parmition
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permition are denied forever!!");
    } else if (locationPermission == LocationPermission.denied) {
      //request a new permition
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Locaation permition denied!!");
      }
    }

    //getting the current location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //update our lattitude adn longitude
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;
      //calling our weather API
      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  //card index code
  RxInt getIndex() {
    return _currentIndex;
  }
}
