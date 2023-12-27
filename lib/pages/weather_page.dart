import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/themes.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherServices(apiKey: 'a79d0c319324f281653b813df752b61d');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getcurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherCondition(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }

  bool isSwitched = false;

  IconData lgcon = CupertinoIcons.moon_fill;
  IconData drkcon = CupertinoIcons.sun_max_fill;

  Future displayBottomSheet() {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return const SizedBox(
          height: 200,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isSwitched ? Themes().lightTheme : Themes().darkTheme,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              color: !isSwitched
                  ? Colors.amber
                  : const Color.fromARGB(255, 21, 7, 96),
              onPressed: () {
                setState(() {
                  isSwitched = !isSwitched;
                });
              },
              icon: Icon(isSwitched ? lgcon : drkcon, size: 40),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_weather?.cityName ?? "Loading city...",
                  style: const TextStyle(
                    fontSize: 30,
                  )),
              Lottie.asset(getWeatherCondition(_weather?.mainCondition)),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${_weather?.temperature.round()}',
                          style: const TextStyle(fontSize: 30)),
                      const Text(
                        '°C',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ],
              ),
              Text(_weather?.mainCondition ?? "",
                  style: const TextStyle(fontSize: 20)),
              Text(_weather?.base ?? "", style: const TextStyle(fontSize: 20)),
              // ListTile(
              //     title: const Text('Dark Mode'),
              //     leading: IconButton(
              //       onPressed: () {
              //         setState(() {
              //           isSwitched = !isSwitched;
              //         });
              //       },
              //       icon: Icon(isSwitched ? lgcon : drkcon),
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
