

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_google_app/model/place.dart';
import 'package:map_google_app/utils/location_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var initialCameraPostion;
 late LocationService locationService=LocationService();


  //Marker take datatype Marker
  Set <Marker>markers={};
  Set<Polygon>polygons={};
  Set<Polyline>polylines={};
  Set<Circle>circles={};

    bool isFirstCall=true;
   GoogleMapController ?googleMapController;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();


    upDateMyLocation();
   locationService=LocationService();
    ///3Step
    //1-if location Enable
    //2-get location
    //3-display Marker realTime


    initialCameraPostion=const CameraPosition(
        target:LatLng(30.00962548737948, 31.19972769557873),
        zoom: 1,
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("GoogleMap"),
      ),
      body: Stack(
        children: [
              GoogleMap(
                polylines: polylines,
                polygons: polygons,
                markers: markers,
            circles: circles,


            initialCameraPosition: initialCameraPostion,
            zoomControlsEnabled: false,
            onMapCreated: (controller)
            {

             googleMapController=controller;

            },
            // cameraTargetBounds:CameraTargetBounds(
            //     LatLngBounds(
            //         northeast: const LatLng(29.991532110970283, 31.317278505966403),
            //
            //
            //         southwest: const LatLng(29.96717034453684, 31.26993990869689))
            // ) ,


          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(onPressed: () {
              googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    zoom: 17,
                  target: LatLng(30.06209765980641, 31.21917331325735))
              ));
            },
            child: const Text("Click")),
          )
        ],

      ),
    );
  }
//
//   void initMapStyle() async {
//     //1-load String
//     //2-update Style mean control first
//     var nightMapStyle= await DefaultAssetBundle.of(context).loadString('asset/map_style/night_map_style.json');
//     //update style Now
//   googleMapController!.setMapStyle(nightMapStyle);
//   }
//
//   void initialMarker()
//   {
//     //ever model giveMe turn on Marker
//     // i Need come List Make Map for List
//  var myMarkers= places.map((placeModel) => Marker
//     (
//     position: placeModel.latLng,
//     markerId:  MarkerId
//       (
//       placeModel.id.toString(),
//     ),
//   ),
//   ).toSet();
// //addAll due using set n't add
//   markers.addAll(myMarkers);
//   }

//   void initialPloylines()
//   {
//     Polyline polyline=const Polyline(
//         polylineId:PolylineId("1"),
//       color: Colors.green,
//       startCap: Cap.roundCap,
//       endCap: Cap.roundCap,
//       zIndex: 2,
//
//       width: 4,
//
//       points: [
//
//           LatLng(30.01099845778135, 31.248336727899744),
//         LatLng(29.998840993915156, 31.2136088600324),
//         LatLng(29.98636204799827, 31.23023390316038),
//         LatLng(29.966947236831793, 31.270134006667533),
//
//
//       ],
//
//     );
//     Polyline polyline2=const Polyline(
//       polylineId:PolylineId("1"),
//       color: Colors.blue,
//       startCap: Cap.roundCap,
//       endCap: Cap.roundCap,
//        zIndex: 1,
//       width: 4,
//
//       points: [
//
//         LatLng(30.015207538314648, 31.27628061814353),
//         LatLng(30.01216036486731, 31.265122629518814),
//         LatLng(30.02955029222208, 31.258599497707436),
//         LatLng(30.030887852608377, 31.275765634053162),
//
//
//       ],
//
//     );
//
//     polylines.add(polyline);
//     polylines.add(polyline2);
//   }
//
//   void initialPloygon()
//   {
//   Polygon polygon =Polygon
//     (
//       polygonId: const PolygonId('1'),
//     zIndex: 1,
//     fillColor: Colors.red.withOpacity(.5),
//
//
//     strokeWidth: 3,
//
//     points:
//       const [
//         LatLng(29.870028580077154, 31.320483422830428),
//         LatLng(29.866530369175294, 31.298339106944443),
//         LatLng(29.8499308034644, 31.3252041103255),
//       ]
//   );
//   polygons.add(polygon);
//   }
//
//   void initialCircles()
//   {
// Marker  onlyMarker=  const Marker(
//         markerId: MarkerId("1"),
//       position: LatLng(29.993255307500696, 31.311430965395555),
//
//     );
// markers.add(onlyMarker);
//     Circle circle=const Circle(
//         circleId:CircleId('1'),
//       center: LatLng(29.993255307500696, 31.311430965395555),
//       radius:1000
//     );
//    circles.add(circle) ;
//   }
///First Step

///second step

  ///third step


  void upDateMyLocation()async
  {
await locationService.checkAndRequestLocationService();
  var hasPermission=
  await locationService.requestPermission();
  if(hasPermission){
    //no thing n't problem using await last method
    locationService.getRealTimeLocationData((locationData)
    {
      setMyLocationMarker(locationData);
      upDataMyCamera(locationData);
    });

  }else{

  }


  }

void upDataMyCamera(LocationData locationData) {

      ///? mean here is check google Map controller n't null , executed after ?

      if (isFirstCall) {
        CameraPosition cameraPosition=CameraPosition(
            target:(LatLng(locationData.latitude!, locationData.longitude!)),
        zoom: 17);
        googleMapController
            ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
     isFirstCall=false;
      }
      else{
        googleMapController
            ?.animateCamera(CameraUpdate.newLatLng(LatLng(locationData.latitude!, locationData.longitude!)));
      }
}

void setMyLocationMarker(LocationData locationData) {
  var myLocationMarker=Marker(
      markerId: const MarkerId("myLocation"),
      position: LatLng(locationData.latitude!,locationData.longitude! ));
  markers.add(myLocationMarker);
  //animateCamera Work n't  update uI
  setState(() {

  });
}
}
