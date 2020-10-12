import 'package:flutter/material.dart';
import 'package:haliyahewa/screens/city_screen.dart';
import 'package:haliyahewa/utilities/constants.dart';
import  'package:haliyahewa/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationData});

  final locationData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();


  int temperature ;
  String  weatherIcon ;
  String weatherMessage;
  String cityName ;

  @override
  void initState() {
    super.initState();
    updateUi(widget.locationData);
  }
  void updateUi(dynamic weatherData){

     setState(() {
       if(weatherData == null){
         temperature = 0;
         weatherIcon = 'Error';
         weatherMessage= 'unable to get Weather Data';
         return;
       }
       temperature = weatherData['main']['temp'].toInt();
       weatherIcon =weather.getWeatherIcon(weatherData['weather'][0]['id']);
       weatherMessage = weather.getMessage(temperature);
       cityName = weatherData['name'];
     });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherData = await weather.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                     String value = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CityScreen()));
                     var weatherData = await weather.getCityWeather(value);
                     updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



