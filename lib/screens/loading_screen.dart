import 'package:flutter/material.dart';
import 'package:haliyahewa/screens/location_screen.dart';
import 'package:haliyahewa/services/location.dart';
import 'package:haliyahewa/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:haliyahewa/services/weather.dart';





class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {



  void getLocationData() async{

    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreen(locationData: weatherData,)));

  }





  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
