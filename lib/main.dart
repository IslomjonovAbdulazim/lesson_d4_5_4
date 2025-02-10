import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String key = "30d288037340bc186f3c77d4ad7d435a";
  bool isLoading = false;
  String city = "Tashkent";
  int temp = 0;
  String sky = "";

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    WeatherFactory wf = WeatherFactory(key);
    isLoading = true;
    setState(() {});
    Weather weather = await wf.currentWeatherByCityName(city);
    isLoading = false;
    setState(() {});
    temp = weather.temperature?.celsius?.toInt() ?? temp;
    sky = weather.weatherMain ?? sky;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
