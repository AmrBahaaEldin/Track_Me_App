

import 'package:location/location.dart';

class LocationService{
  Location location=Location();
  ///First Step
  Future<bool>  checkAndRequestLocationService ()async
  {
    bool isServiced= await location.serviceEnabled();
    if(!isServiced)
    {
      isServiced=await location.requestService();
      if(!isServiced)
      {
       return false;
      }
    }
    return true;
  }
  ///second step
  Future<bool> requestPermission()async
  {
    var isPermission=await location.hasPermission();
    if(isPermission==PermissionStatus.deniedForever)
    {
      return false;
    }
    if(isPermission==PermissionStatus.denied)
    {
      isPermission=await location.requestPermission();
      //granted mean  is accept
      // exist  if and else(using return bool) include if
      return isPermission==PermissionStatus.granted;

    }
    return true;
  }
  ///third step

  void getRealTimeLocationData(void Function(LocationData)? onData)
  {
    location.onLocationChanged.listen((onData));
  }
}