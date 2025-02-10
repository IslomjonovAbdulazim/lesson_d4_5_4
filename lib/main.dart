import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(DevicePreview(builder: (_) => WeatherApp()));
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
  String city = "Paris"; // utica, moscow, paris
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

  String getImage() {
    if (sky == "Snow") {
      return "assets/snow.png";
    } else if (sky == "Rain") {
      return "assets/rain.png";
    } else if (sky == "Clear") {
      return "assets/sunny.png";
    } else if (sky == "Wind") {
      return "assets/wind.png";
    } else {
      return "assets/cloud.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "February 10, 2025",
                    style: GoogleFonts.manrope(
                      color: Color(0xff6B7280),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    city,
                    style: GoogleFonts.manrope(
                      color: Color(0xff111827),
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 40),
                  Image.asset(getImage()),
                  Text(
                    "$temp",
                    style: GoogleFonts.manrope(
                      fontSize: 140,
                      color: Color(0xff111827),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    sky,
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xffFF8E27),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
