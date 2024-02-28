import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel{
 final String ? name;
 final int id;
 final LatLng latLng;
  PlaceModel({this.name,required this.id,required this.latLng});


}
///store Model Now
List<PlaceModel>places=[
  PlaceModel(id: 1, latLng: const LatLng(30.06776720356485, 31.199946717057166),name:"مدينه المهندسين" ),
  PlaceModel(id: 2, latLng: const LatLng(29.96960653379406, 31.31311450334898),name:"مول ٥٠" ),
  PlaceModel(id: 3, latLng: const LatLng(30.064738224314567, 31.2136338161805),name:"فندق أم كلثوم القاهره" ),
];