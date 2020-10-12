import 'package:geolocator/geolocator.dart';
class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async{
    try {
     Position position = await  getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
     latitude = position.latitude;
     longitude = position.longitude;
    }catch(e){
      print(e);
    }
  }

}